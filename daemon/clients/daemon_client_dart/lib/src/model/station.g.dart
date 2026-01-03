// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'station.dart';

// **************************************************************************
// CopyWithGenerator
// **************************************************************************

abstract class _$StationCWProxy {
  Station id(int id);

  Station name(String name);

  Station longitude(double longitude);

  Station latitude(double latitude);

  Station createdAt(String createdAt);

  /// Creates a new instance with the provided field values.
  /// Passing `null` to a nullable field nullifies it, while `null` for a non-nullable field is ignored. To update a single field use `Station(...).copyWith.fieldName(value)`.
  ///
  /// Example:
  /// ```dart
  /// Station(...).copyWith(id: 12, name: "My name")
  /// ```
  Station call({
    int id,
    String name,
    double longitude,
    double latitude,
    String createdAt,
  });
}

/// Callable proxy for `copyWith` functionality.
/// Use as `instanceOfStation.copyWith(...)` or call `instanceOfStation.copyWith.fieldName(value)` for a single field.
class _$StationCWProxyImpl implements _$StationCWProxy {
  const _$StationCWProxyImpl(this._value);

  final Station _value;

  @override
  Station id(int id) => call(id: id);

  @override
  Station name(String name) => call(name: name);

  @override
  Station longitude(double longitude) => call(longitude: longitude);

  @override
  Station latitude(double latitude) => call(latitude: latitude);

  @override
  Station createdAt(String createdAt) => call(createdAt: createdAt);

  @override
  /// Creates a new instance with the provided field values.
  /// Passing `null` to a nullable field nullifies it, while `null` for a non-nullable field is ignored. To update a single field use `Station(...).copyWith.fieldName(value)`.
  ///
  /// Example:
  /// ```dart
  /// Station(...).copyWith(id: 12, name: "My name")
  /// ```
  Station call({
    Object? id = const $CopyWithPlaceholder(),
    Object? name = const $CopyWithPlaceholder(),
    Object? longitude = const $CopyWithPlaceholder(),
    Object? latitude = const $CopyWithPlaceholder(),
    Object? createdAt = const $CopyWithPlaceholder(),
  }) {
    return Station(
      id: id == const $CopyWithPlaceholder() || id == null
          ? _value.id
          // ignore: cast_nullable_to_non_nullable
          : id as int,
      name: name == const $CopyWithPlaceholder() || name == null
          ? _value.name
          // ignore: cast_nullable_to_non_nullable
          : name as String,
      longitude: longitude == const $CopyWithPlaceholder() || longitude == null
          ? _value.longitude
          // ignore: cast_nullable_to_non_nullable
          : longitude as double,
      latitude: latitude == const $CopyWithPlaceholder() || latitude == null
          ? _value.latitude
          // ignore: cast_nullable_to_non_nullable
          : latitude as double,
      createdAt: createdAt == const $CopyWithPlaceholder() || createdAt == null
          ? _value.createdAt
          // ignore: cast_nullable_to_non_nullable
          : createdAt as String,
    );
  }
}

extension $StationCopyWith on Station {
  /// Returns a callable class used to build a new instance with modified fields.
  /// Example: `instanceOfStation.copyWith(...)` or `instanceOfStation.copyWith.fieldName(...)`.
  // ignore: library_private_types_in_public_api
  _$StationCWProxy get copyWith => _$StationCWProxyImpl(this);
}

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Station _$StationFromJson(Map<String, dynamic> json) => $checkedCreate(
  'Station',
  json,
  ($checkedConvert) {
    $checkKeys(
      json,
      requiredKeys: const ['id', 'name', 'longitude', 'latitude', 'createdAt'],
    );
    final val = Station(
      id: $checkedConvert('id', (v) => (v as num).toInt()),
      name: $checkedConvert('name', (v) => v as String),
      longitude: $checkedConvert('longitude', (v) => (v as num).toDouble()),
      latitude: $checkedConvert('latitude', (v) => (v as num).toDouble()),
      createdAt: $checkedConvert('createdAt', (v) => v as String),
    );
    return val;
  },
);

Map<String, dynamic> _$StationToJson(Station instance) => <String, dynamic>{
  'id': instance.id,
  'name': instance.name,
  'longitude': instance.longitude,
  'latitude': instance.latitude,
  'createdAt': instance.createdAt,
};
