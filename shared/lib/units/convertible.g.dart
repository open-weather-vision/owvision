// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'convertible.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Convertible _$ConvertibleFromJson(Map<String, dynamic> json) => Convertible(
  (json['value'] as num).toDouble(),
  const UnitJsonConverter().fromJson(json['unit'] as String),
);

Map<String, dynamic> _$ConvertibleToJson(Convertible instance) =>
    <String, dynamic>{
      'unit': const UnitJsonConverter().toJson(instance.unit),
      'value': instance.value,
    };
