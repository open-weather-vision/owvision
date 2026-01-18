// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'sensor_history.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

SensorHistory _$SensorHistoryFromJson(Map<String, dynamic> json) =>
    SensorHistory(
      json['sensorName'] as String,
      json['unitId'] as String,
      (json['history'] as List<dynamic>)
          .map((e) => HistoryRecord.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$SensorHistoryToJson(SensorHistory instance) =>
    <String, dynamic>{
      'sensorName': instance.sensorName,
      'unitId': instance.unitId,
      'history': instance.history,
    };
