import 'dart:async';
import 'dart:io';

import 'package:args/command_runner.dart';
import 'package:chalkdart/chalkstrings.dart';
import 'package:shared/format_duration.dart';

import '../../models/recorder_status.dart';

class StatusCommand extends Command<int> {
  @override
  String get description =>
      "Checks if the weather station interface and the daemon are currently reachable.";

  @override
  String get name => "status";

  @override
  FutureOr<int> run() async {
    final status = RecorderStatus.fromFileSync();

    final latestStationPingAgo = status.latestStationConnection != null
        ? " (${formatDuration(DateTime.now().difference(status.latestStationConnection!))} ago)"
        : "";
    final latestDaemonPingAgo = status.latestDaemonConnection != null
        ? " (${formatDuration(DateTime.now().difference(status.latestDaemonConnection!))} ago)"
        : "";
    print(
      "Weather station: ${chalk.bold(status.stationConnected ? chalk.green("connected") : chalk.red("disconnected"))}${chalk.dim(latestStationPingAgo)}",
    );
    print(
      "Daemon: ${chalk.bold(status.daemonConnected ? chalk.green("connected") : chalk.red("disconnected"))}${chalk.dim(latestDaemonPingAgo)}",
    );

    exit(0);
  }
}
