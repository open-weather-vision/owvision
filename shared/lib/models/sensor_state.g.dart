// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'sensor_state.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

SensorState _$SensorStateFromJson(Map<String, dynamic> json) => SensorState(
  value: Convertible.fromJson(json['value'] as Map<String, dynamic>),
  createdAt: const DateTimeEpochConverter().fromJson(
    json['createdAt'] as String,
  ),
  interval: _$JsonConverterFromJson<int, Duration>(
    json['interval'],
    const DurationConverter().fromJson,
  ),
);

Map<String, dynamic> _$SensorStateToJson(SensorState instance) =>
    <String, dynamic>{
      'value': instance.value,
      'createdAt': const DateTimeEpochConverter().toJson(instance.createdAt),
      'interval': ?_$JsonConverterToJson<int, Duration>(
        instance.interval,
        const DurationConverter().toJson,
      ),
    };

Value? _$JsonConverterFromJson<Json, Value>(
  Object? json,
  Value? Function(Json json) fromJson,
) => json == null ? null : fromJson(json as Json);

Json? _$JsonConverterToJson<Json, Value>(
  Value? value,
  Json? Function(Value value) toJson,
) => value == null ? null : toJson(value);
