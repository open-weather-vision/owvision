import 'dart:async';
import 'dart:io';

import 'package:args/command_runner.dart';
import 'package:chalkdart/chalkstrings.dart';
import 'package:shared/format_duration.dart';
import 'package:shared/utils.dart';

import '../../models/recorder_status.dart';

class StatusCommand extends Command<int> {
  @override
  String get description =>
      "Checks if the weather station interface and the daemon are currently reachable.";

  @override
  String get name => "status";

  @override
  FutureOr<int> run() async {
    final recorderActive =
        await runShellCommand(
          "systemctl",
          ["is-active", "ow_recorder"],
          forwardOutput: false,
          onCommandFail: FailAction.silent,
        ) ==
        0;
    if (recorderActive) {
      final status = RecorderStatus.fromFileSync();
      final latestStationPingAgo = status.latestStationConnection != null
          ? " (${formatDuration(DateTime.now().difference(status.latestStationConnection!))} ago)"
          : "";
      final latestDaemonPingAgo = status.latestDaemonConnection != null
          ? " (${formatDuration(DateTime.now().difference(status.latestDaemonConnection!))} ago)"
          : "";
      final latestOpenMeteoPingAgo = status.latestOpenMeteoConnection != null
          ? " (${formatDuration(DateTime.now().difference(status.latestOpenMeteoConnection!))} ago)"
          : "";
      print(
        "${chalk.underline("Weather station")}: ${chalk.bold(status.stationConnected ? chalk.green("connected") : chalk.red("disconnected"))}${chalk.dim(latestStationPingAgo)}",
      );
      print(
        "${chalk.underline("Daemon")}: ${chalk.bold(status.daemonConnected ? chalk.green("connected") : chalk.red("disconnected"))}${chalk.dim(latestDaemonPingAgo)}",
      );
      print(
        "${chalk.underline("Open meteo")}: ${chalk.bold(status.openMeteoConnected ? chalk.green("connected") : chalk.red("disconnected"))}${chalk.dim(latestOpenMeteoPingAgo)}",
      );
    } else {
      print(chalk.red("${chalk.bold("recorder")} is not running"));
    }

    exit(0);
  }
}
