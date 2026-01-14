// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'station.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Station _$StationFromJson(Map<String, dynamic> json) => Station(
  id: (json['id'] as num).toInt(),
  name: json['name'] as String,
  longitude: (json['longitude'] as num).toDouble(),
  latitude: (json['latitude'] as num).toDouble(),
  createdAt: DateTime.parse(json['createdAt'] as String),
);

Map<String, dynamic> _$StationToJson(Station instance) => <String, dynamic>{
  'id': instance.id,
  'name': instance.name,
  'longitude': instance.longitude,
  'latitude': instance.latitude,
  'createdAt': instance.createdAt.toIso8601String(),
};
