import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:args/command_runner.dart';
import 'package:chalkdart/chalkdart.dart';
import 'package:daemon/cli/entry.dart';
import 'package:dio/dio.dart';
import 'package:interact/interact.dart';
import 'package:owvision_daemon_client_dart/owvision_daemon_client_dart.dart';
import 'package:shared/format_duration.dart';
import 'package:shared/models/station_live_state.dart';
import 'package:web_socket_channel/io.dart';

class StationCommand extends Command<int> {
  @override
  String get description =>
      "Get information about the connected weather stations.";

  @override
  String get name => "station";

  StationCommand() {
    addSubcommand(StationListCommand());
    addSubcommand(StationConnnectCommand());
    addSubcommand(StationSelectCommand());
  }
}

class StationListCommand extends Command<int> {
  @override
  String get description => "Lists all connected weather stations";

  @override
  String get name => "list";

  @override
  FutureOr<int>? run() async {
    final stationsApi = daemonClient.getStationApi();

    try {
      final response = await stationsApi.stationsAll();
      final stations = response.data;
      for (final station in stations!) {
        final selected = station.id == cliConfig.selectedStationId;
        print(
          "🟢 ${chalk.bold(station.name)} (${chalk.underlined("#${station.id}")}${selected ? ', selected' : ''})",
        );
        print(
          "   📍 ${chalk.italic("${station.latitude}, ${station.longitude}")}",
        );
      }
      if (stations.isEmpty) {
        print(
          chalk.italic.dim(
            "There are no weather stations connected currently!",
          ),
        );
      }
    } on DioException catch (e) {
      if (e.response != null) {
        final error = Error.fromJson(e.response!.data);
        print(
          chalk.red(
            "⚠️  Failed to fetch stations: ${error.message} (${error.code})",
          ),
        );
      } else {
        print(
          chalk.red(
            "⚠️  Failed to fetch stations: Daemon didn't respond! Is the daemon running?",
          ),
        );
      }
    }
    exit(0);
  }
}

class StationSelectCommand extends Command<int> {
  @override
  String get description => "Selects a station for the following commands.";

  @override
  String get name => "select";

  @override
  FutureOr<int>? run() async {
    final stationsApi = daemonClient.getStationApi();

    late final Station selectedStation;
    try {
      final response = await stationsApi.stationsAll();
      final stations = response.data;
      if (stations!.isEmpty) {
        print(
          chalk.italic.dim(
            "There are no weather stations connected currently!",
          ),
        );
        exit(0);
      }
      final selected = Select(
        prompt: "Please select a weather station",
        options: stations
            .map(
              (s) => "${chalk.bold(s.name)} (${chalk.underline("#${s.id}")})",
            )
            .toList(),
      ).interact();
      selectedStation = stations[selected];
    } on DioException catch (e) {
      if (e.response != null) {
        final error = Error.fromJson(e.response!.data);
        print(
          chalk.red(
            "⚠️  Failed to fetch stations: ${error.message} (${error.code})",
          ),
        );
        exit(0);
      } else {
        print(
          chalk.red(
            "⚠️  Failed to fetch stations: Daemon didn't respond! Is the daemon running?",
          ),
        );
        exit(0);
      }
    }
    cliConfig.selectedStationId = selectedStation.id.toInt();
    cliConfig.saveToFile();
    reset();
    exit(0);
  }
}

class StationConnnectCommand extends Command<int> {
  @override
  String get description => "Connects to a station to get sensor live data.";

  @override
  String get name => "connect";

  @override
  FutureOr<int>? run() async {
    if (cliConfig.selectedStationId == null) {
      print(
        chalk.red(
          "⚠️  No station selected! Run ${chalk.italic("owvi station select")} to select a station.",
        ),
      );
      exit(0);
    }
    final baseUrl = OwvisionDaemonClientDart.basePath.replaceFirst(
      "http",
      "ws",
    );
    final uri = Uri.parse(
      '$baseUrl/stations/${cliConfig.selectedStationId}/live',
    );
    final channel = IOWebSocketChannel.connect(
      uri,
      headers: {"Authorization": "Bearer ${cliConfig.apiToken}"},
    );

    final sigintSub = ProcessSignal.sigint.watch().listen((signal) async {
      await channel.sink.close();
      exit(0);
    });

    try {
      await channel.ready;
    } catch (e) {
      print(chalk.red("⚠️  Connection issue: $e"));
      exit(0);
    }
    print(
      chalk.dim.italic(
        "Connected to station. Press ${chalk.bold("q")} to stop listening to updates.",
      ),
    );

    final view = LiveView();
    channel.stream.listen(
      (message) {
        final Map<String, dynamic> response = jsonDecode(message);
        view.update(StationLiveState.fromJson(response));
      },
      onError: (error) {
        print(chalk.red("⚠️  Connection issue: ${error.toString()}"));
        sigintSub.cancel();
      },
      onDone: () {
        sigintSub.cancel();
      },
      cancelOnError: true,
    );

    stdin.listen((data) {
      if (data.contains('q'.codeUnitAt(0))) {
        exit(0);
      }
    });
    return 0;
  }
}

class LiveView {
  bool _initialized = false;

  void update(StationLiveState state) {
    final sensorStates = state.entries.toList();
    // 1. Gehe zurück zum Anfang des vorherigen Blocks
    if (_initialized && sensorStates.isNotEmpty) {
      stdout.write('\x1b[${sensorStates.length}A');
    }

    // 2. Schreibe jede Zeile neu und lösche den alten Rest der Zeile
    for (var sensorStateEntry in sensorStates) {
      late final String currentValue;
      late final String lastUpdateTime;

      final state = sensorStateEntry.value;
      if (state == null) {
        currentValue = "-";
        lastUpdateTime = "";
      } else {
        currentValue = state.value.format();
        final timeAgo = DateTime.now().difference(state.createdAt);
        lastUpdateTime = chalk.dim(" (${formatDuration(timeAgo)} ago)");
      }
      stdout.writeln(
        '\x1b[2K🟢  ${chalk.bold(sensorStateEntry.key)}: ${chalk.italic(currentValue)}$lastUpdateTime',
      ); // \x1b[2K löscht die Zeile
    }

    _initialized = true;
  }
}
