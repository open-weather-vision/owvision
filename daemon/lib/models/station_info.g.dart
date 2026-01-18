// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'station_info.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

StationInfo _$StationInfoFromJson(Map<String, dynamic> json) => StationInfo(
  id: (json['id'] as num).toInt(),
  name: json['name'] as String,
  longitude: (json['longitude'] as num).toDouble(),
  latitude: (json['latitude'] as num).toDouble(),
  createdAt: DateTime.parse(json['createdAt'] as String),
  version: (json['version'] as num).toInt(),
);

Map<String, dynamic> _$StationInfoToJson(StationInfo instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'longitude': instance.longitude,
      'latitude': instance.latitude,
      'createdAt': instance.createdAt.toIso8601String(),
      'version': instance.version,
    };
