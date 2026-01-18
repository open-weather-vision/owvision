import 'package:json_annotation/json_annotation.dart';
import 'package:shared/models/sensor.dart';

import 'station_info.dart';

part 'station_and_sensors.g.dart';

@JsonSerializable()
class StationAndSensors {
  final StationInfo info;
  final List<Sensor> sensors;

  StationAndSensors({required this.info, required this.sensors});

  factory StationAndSensors.fromJson(Map<String, dynamic> json) =>
      _$StationAndSensorsFromJson(json);

  Map<String, dynamic> toJson() => _$StationAndSensorsToJson(this);
}
