// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'station_and_sensors.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

StationAndSensors _$StationAndSensorsFromJson(Map<String, dynamic> json) =>
    StationAndSensors(
      info: StationInfo.fromJson(json['info'] as Map<String, dynamic>),
      sensors: (json['sensors'] as List<dynamic>)
          .map((e) => Sensor.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$StationAndSensorsToJson(StationAndSensors instance) =>
    <String, dynamic>{'info': instance.info, 'sensors': instance.sensors};
