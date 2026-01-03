// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'station_and_sensors.dart';

// **************************************************************************
// CopyWithGenerator
// **************************************************************************

abstract class _$StationAndSensorsCWProxy {
  StationAndSensors station(Station station);

  StationAndSensors sensors(List<Sensor> sensors);

  /// Creates a new instance with the provided field values.
  /// Passing `null` to a nullable field nullifies it, while `null` for a non-nullable field is ignored. To update a single field use `StationAndSensors(...).copyWith.fieldName(value)`.
  ///
  /// Example:
  /// ```dart
  /// StationAndSensors(...).copyWith(id: 12, name: "My name")
  /// ```
  StationAndSensors call({Station station, List<Sensor> sensors});
}

/// Callable proxy for `copyWith` functionality.
/// Use as `instanceOfStationAndSensors.copyWith(...)` or call `instanceOfStationAndSensors.copyWith.fieldName(value)` for a single field.
class _$StationAndSensorsCWProxyImpl implements _$StationAndSensorsCWProxy {
  const _$StationAndSensorsCWProxyImpl(this._value);

  final StationAndSensors _value;

  @override
  StationAndSensors station(Station station) => call(station: station);

  @override
  StationAndSensors sensors(List<Sensor> sensors) => call(sensors: sensors);

  @override
  /// Creates a new instance with the provided field values.
  /// Passing `null` to a nullable field nullifies it, while `null` for a non-nullable field is ignored. To update a single field use `StationAndSensors(...).copyWith.fieldName(value)`.
  ///
  /// Example:
  /// ```dart
  /// StationAndSensors(...).copyWith(id: 12, name: "My name")
  /// ```
  StationAndSensors call({
    Object? station = const $CopyWithPlaceholder(),
    Object? sensors = const $CopyWithPlaceholder(),
  }) {
    return StationAndSensors(
      station: station == const $CopyWithPlaceholder() || station == null
          ? _value.station
          // ignore: cast_nullable_to_non_nullable
          : station as Station,
      sensors: sensors == const $CopyWithPlaceholder() || sensors == null
          ? _value.sensors
          // ignore: cast_nullable_to_non_nullable
          : sensors as List<Sensor>,
    );
  }
}

extension $StationAndSensorsCopyWith on StationAndSensors {
  /// Returns a callable class used to build a new instance with modified fields.
  /// Example: `instanceOfStationAndSensors.copyWith(...)` or `instanceOfStationAndSensors.copyWith.fieldName(...)`.
  // ignore: library_private_types_in_public_api
  _$StationAndSensorsCWProxy get copyWith =>
      _$StationAndSensorsCWProxyImpl(this);
}

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

StationAndSensors _$StationAndSensorsFromJson(Map<String, dynamic> json) =>
    $checkedCreate('StationAndSensors', json, ($checkedConvert) {
      $checkKeys(json, requiredKeys: const ['station', 'sensors']);
      final val = StationAndSensors(
        station: $checkedConvert(
          'station',
          (v) => Station.fromJson(v as Map<String, dynamic>),
        ),
        sensors: $checkedConvert(
          'sensors',
          (v) => (v as List<dynamic>)
              .map((e) => Sensor.fromJson(e as Map<String, dynamic>))
              .toList(),
        ),
      );
      return val;
    });

Map<String, dynamic> _$StationAndSensorsToJson(StationAndSensors instance) =>
    <String, dynamic>{
      'station': instance.station.toJson(),
      'sensors': instance.sensors.map((e) => e.toJson()).toList(),
    };
