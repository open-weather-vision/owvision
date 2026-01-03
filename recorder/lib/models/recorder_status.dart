import 'dart:convert';
import 'dart:io';

import 'package:json_annotation/json_annotation.dart';
import 'package:shared/logger/logger.dart';
import 'package:shared/utils.dart';

part 'recorder_status.g.dart';

@JsonSerializable()
class RecorderStatus {
  static final _recorderStatusFile = File(
    "${getOwvisionHomeDirectory()}/recorder_status.json",
  );

  bool daemonConnected;
  bool stationConnected;
  DateTime? latestDaemonConnection;
  DateTime? latestStationConnection;

  RecorderStatus({
    required this.daemonConnected,
    required this.stationConnected,
    required this.latestStationConnection,
    required this.latestDaemonConnection,
  });

  static RecorderStatus fromFileSync() {
    logger.info("Reading recorder status from file");
    late final RecorderStatus config;
    try {
      config = RecorderStatus.fromJson(
        jsonDecode(_recorderStatusFile.readAsStringSync()),
      );
      logger.info("Read recorder config: ${config.toString()}");
    } catch (e) {
      config = RecorderStatus(
        daemonConnected: false,
        stationConnected: false,
        latestDaemonConnection: null,
        latestStationConnection: null,
      );
      logger.warning(
        "Failed to read recorder status. Falling back to defaults: $config",
      );
      config.saveToFile().catchError(
        (e) =>
            logger.warning("Failed to save recorder status in background: $e"),
      );
    }
    return config;
  }

  factory RecorderStatus.fromJson(Map<String, dynamic> json) =>
      _$RecorderStatusFromJson(json);

  Future<void> saveToFile() async {
    await _recorderStatusFile.writeAsString(jsonEncode(toJson()));
  }

  static Future<void> removeConfigFile() async {
    try {
      await _recorderStatusFile.delete();
    } catch (_) {}
  }

  @override
  String toString() {
    return "(daemonConnected=$daemonConnected, stationConnected=$stationConnected, latestDaemonConnection=$latestDaemonConnection, latestStationConnection=$latestStationConnection)";
  }

  Map<String, dynamic> toJson() => _$RecorderStatusToJson(this);
}
