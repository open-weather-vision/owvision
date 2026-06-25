// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'station_info.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

StationInfo _$StationInfoFromJson(Map<String, dynamic> json) => StationInfo(
  uuid: json['uuid'] as String,
  name: json['name'] as String?,
  longitude: (json['longitude'] as num?)?.toDouble(),
  latitude: (json['latitude'] as num?)?.toDouble(),
  createdAt: DateTime.parse(json['createdAt'] as String),
  configured: json['configured'] as bool,
  interfaceName: json['interfaceName'] as String,
);

Map<String, dynamic> _$StationInfoToJson(StationInfo instance) =>
    <String, dynamic>{
      'uuid': instance.uuid,
      'name': instance.name,
      'longitude': instance.longitude,
      'latitude': instance.latitude,
      'interfaceName': instance.interfaceName,
      'createdAt': instance.createdAt.toIso8601String(),
      'configured': instance.configured,
    };
