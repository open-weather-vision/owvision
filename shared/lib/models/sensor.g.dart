// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'sensor.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Sensor _$SensorFromJson(Map<String, dynamic> json) => Sensor(
  id: (json['id'] as num).toInt(),
  name: json['name'] as String,
  stationId: (json['stationId'] as num).toInt(),
  element: $enumDecode(_$SensorElementEnumMap, json['element']),
  storageUnit: const UnitJsonConverter().fromJson(
    json['storageUnit'] as String,
  ),
  recordIntervalSeconds: (json['recordIntervalSeconds'] as num).toInt(),
);

Map<String, dynamic> _$SensorToJson(Sensor instance) => <String, dynamic>{
  'id': instance.id,
  'stationId': instance.stationId,
  'element': _$SensorElementEnumMap[instance.element]!,
  'name': instance.name,
  'recordIntervalSeconds': instance.recordIntervalSeconds,
  'storageUnit': const UnitJsonConverter().toJson(instance.storageUnit),
};

const _$SensorElementEnumMap = {
  SensorElement.precipationAccumulated: 'precipationAccumulated',
  SensorElement.precipationRate: 'precipationRate',
  SensorElement.snowHeight: 'snowHeight',
  SensorElement.pressure: 'pressure',
  SensorElement.temperature: 'temperature',
  SensorElement.windSpeed: 'windSpeed',
  SensorElement.windDirection: 'windDirection',
  SensorElement.humidity: 'humidity',
  SensorElement.weatherCode: 'weatherCode',
};
