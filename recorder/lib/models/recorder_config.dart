import 'dart:convert';
import 'dart:io';

import 'package:json_annotation/json_annotation.dart';
import 'package:shared/logger/logger.dart';
import 'package:shared/utils.dart';

part 'recorder_config.g.dart';

@JsonSerializable()
class RecorderConfig {
  static final _recorderConfigFile = File(
    "${getOwvisionHomeDirectory()}/recorder_config.json",
  );

  int interfaceGrpcPort;
  String interfaceGrpcHost;
  int daemonGrpcPort;
  String daemonGrpcHost;
  String daemonGrpcToken;
  bool trustSelfSignedCertificate;
  int? stationId;
  bool enableVirtualWeatherConditionSensor;

  RecorderConfig({
    required this.interfaceGrpcHost,
    required this.interfaceGrpcPort,
    required this.daemonGrpcHost,
    required this.daemonGrpcPort,
    required this.daemonGrpcToken,
    required this.trustSelfSignedCertificate,
    required this.enableVirtualWeatherConditionSensor,
    this.stationId,
  });

  static RecorderConfig fromFileSync() {
    logger.info("Reading recorder config from file");
    late final RecorderConfig config;
    try {
      config = RecorderConfig.fromJson(
        jsonDecode(_recorderConfigFile.readAsStringSync()),
      );
      logger.info("Read recorder config: ${config.toString()}");
    } catch (e) {
      config = RecorderConfig(
        interfaceGrpcHost: "127.0.0.1",
        interfaceGrpcPort: 50051,
        daemonGrpcHost: "0.0.0.0",
        daemonGrpcPort: 8081,
        daemonGrpcToken: "",
        trustSelfSignedCertificate: false,
        enableVirtualWeatherConditionSensor: true,
      );
      logger.warning(
        "Failed to read recorder config. Falling back to defaults: $config",
      );
      config.saveToFile().catchError(
        (e) =>
            logger.warning("Failed to save recorder config in background: $e"),
      );
    }
    return config;
  }

  factory RecorderConfig.fromJson(Map<String, dynamic> json) =>
      _$RecorderConfigFromJson(json);

  Future<void> saveToFile() async {
    if (!await _recorderConfigFile.exists()) {
      await _recorderConfigFile.create(recursive: true);
    }
    await _recorderConfigFile.writeAsString(jsonEncode(toJson()));
  }

  static Future<void> removeConfigFile() async {
    try {
      await _recorderConfigFile.delete();
    } catch (_) {}
  }

  @override
  String toString() {
    return "(interfaceGrpcHost=$interfaceGrpcHost, interfaceGrpcPort=$interfaceGrpcPort, daemonGrpcHost=$daemonGrpcHost, daemonGrpcPort=$daemonGrpcPort, daemonGrpcToken=$daemonGrpcToken, stationId=$stationId, allowSelfSignedCertificate=$trustSelfSignedCertificate, enableVirtualWeatherConditionSensor=$enableVirtualWeatherConditionSensor)";
  }

  Map<String, dynamic> toJson() => _$RecorderConfigToJson(this);
}
