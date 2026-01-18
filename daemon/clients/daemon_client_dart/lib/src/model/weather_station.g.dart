// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'weather_station.dart';

// **************************************************************************
// CopyWithGenerator
// **************************************************************************

abstract class _$WeatherStationCWProxy {
  WeatherStation id(int id);

  WeatherStation name(String name);

  WeatherStation longitude(double longitude);

  WeatherStation latitude(double latitude);

  WeatherStation createdAt(String createdAt);

  /// Creates a new instance with the provided field values.
  /// Passing `null` to a nullable field nullifies it, while `null` for a non-nullable field is ignored. To update a single field use `WeatherStation(...).copyWith.fieldName(value)`.
  ///
  /// Example:
  /// ```dart
  /// WeatherStation(...).copyWith(id: 12, name: "My name")
  /// ```
  WeatherStation call({
    int id,
    String name,
    double longitude,
    double latitude,
    String createdAt,
  });
}

/// Callable proxy for `copyWith` functionality.
/// Use as `instanceOfWeatherStation.copyWith(...)` or call `instanceOfWeatherStation.copyWith.fieldName(value)` for a single field.
class _$WeatherStationCWProxyImpl implements _$WeatherStationCWProxy {
  const _$WeatherStationCWProxyImpl(this._value);

  final WeatherStation _value;

  @override
  WeatherStation id(int id) => call(id: id);

  @override
  WeatherStation name(String name) => call(name: name);

  @override
  WeatherStation longitude(double longitude) => call(longitude: longitude);

  @override
  WeatherStation latitude(double latitude) => call(latitude: latitude);

  @override
  WeatherStation createdAt(String createdAt) => call(createdAt: createdAt);

  @override
  /// Creates a new instance with the provided field values.
  /// Passing `null` to a nullable field nullifies it, while `null` for a non-nullable field is ignored. To update a single field use `WeatherStation(...).copyWith.fieldName(value)`.
  ///
  /// Example:
  /// ```dart
  /// WeatherStation(...).copyWith(id: 12, name: "My name")
  /// ```
  WeatherStation call({
    Object? id = const $CopyWithPlaceholder(),
    Object? name = const $CopyWithPlaceholder(),
    Object? longitude = const $CopyWithPlaceholder(),
    Object? latitude = const $CopyWithPlaceholder(),
    Object? createdAt = const $CopyWithPlaceholder(),
  }) {
    return WeatherStation(
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

extension $WeatherStationCopyWith on WeatherStation {
  /// Returns a callable class used to build a new instance with modified fields.
  /// Example: `instanceOfWeatherStation.copyWith(...)` or `instanceOfWeatherStation.copyWith.fieldName(...)`.
  // ignore: library_private_types_in_public_api
  _$WeatherStationCWProxy get copyWith => _$WeatherStationCWProxyImpl(this);
}

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

WeatherStation _$WeatherStationFromJson(Map<String, dynamic> json) =>
    $checkedCreate('WeatherStation', json, ($checkedConvert) {
      $checkKeys(
        json,
        requiredKeys: const [
          'id',
          'name',
          'longitude',
          'latitude',
          'createdAt',
        ],
      );
      final val = WeatherStation(
        id: $checkedConvert('id', (v) => (v as num).toInt()),
        name: $checkedConvert('name', (v) => v as String),
        longitude: $checkedConvert('longitude', (v) => (v as num).toDouble()),
        latitude: $checkedConvert('latitude', (v) => (v as num).toDouble()),
        createdAt: $checkedConvert('createdAt', (v) => v as String),
      );
      return val;
    });

Map<String, dynamic> _$WeatherStationToJson(WeatherStation instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'longitude': instance.longitude,
      'latitude': instance.latitude,
      'createdAt': instance.createdAt,
    };
