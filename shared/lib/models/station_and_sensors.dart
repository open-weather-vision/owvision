import 'package:json_annotation/json_annotation.dart';
import 'sensor.dart';
import 'station.dart';

part 'station_and_sensors.g.dart';

@JsonSerializable()
class StationAndSensors {
  final Station station;
  final List<Sensor> sensors;

  StationAndSensors({required this.station, required this.sensors});

  factory StationAndSensors.fromJson(Map<String, dynamic> json) =>
      _$StationAndSensorsFromJson(json);

  Map<String, dynamic> toJson() => _$StationAndSensorsToJson(this);
}
