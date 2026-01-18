// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'sensor_state.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

SensorState _$SensorStateFromJson(Map<String, dynamic> json) => SensorState(
  value: json['value'] == null
      ? null
      : Convertible.fromJson(json['value'] as Map<String, dynamic>),
  createdAt: const DateTimeEpochConverter().fromJson(
    json['createdAt'] as String,
  ),
  interval: const DurationConverter().fromJson(
    (json['interval'] as num).toInt(),
  ),
);

Map<String, dynamic> _$SensorStateToJson(SensorState instance) =>
    <String, dynamic>{
      'value': ?instance.value,
      'createdAt': const DateTimeEpochConverter().toJson(instance.createdAt),
      'interval': const DurationConverter().toJson(instance.interval),
    };
