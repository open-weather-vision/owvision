// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'station_and_sensors.dart';

// **************************************************************************
// CopyWithGenerator
// **************************************************************************

abstract class _$StationAndSensorsCWProxy {
  StationAndSensors info(WeatherStation info);

  StationAndSensors sensors(List<Sensor> sensors);

  /// Creates a new instance with the provided field values.
  /// Passing `null` to a nullable field nullifies it, while `null` for a non-nullable field is ignored. To update a single field use `StationAndSensors(...).copyWith.fieldName(value)`.
  ///
  /// Example:
  /// ```dart
  /// StationAndSensors(...).copyWith(id: 12, name: "My name")
  /// ```
  StationAndSensors call({WeatherStation info, List<Sensor> sensors});
}

/// Callable proxy for `copyWith` functionality.
/// Use as `instanceOfStationAndSensors.copyWith(...)` or call `instanceOfStationAndSensors.copyWith.fieldName(value)` for a single field.
class _$StationAndSensorsCWProxyImpl implements _$StationAndSensorsCWProxy {
  const _$StationAndSensorsCWProxyImpl(this._value);

  final StationAndSensors _value;

  @override
  StationAndSensors info(WeatherStation info) => call(info: info);

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
    Object? info = const $CopyWithPlaceholder(),
    Object? sensors = const $CopyWithPlaceholder(),
  }) {
    return StationAndSensors(
      info: info == const $CopyWithPlaceholder() || info == null
          ? _value.info
          // ignore: cast_nullable_to_non_nullable
          : info as WeatherStation,
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
      $checkKeys(json, requiredKeys: const ['info', 'sensors']);
      final val = StationAndSensors(
        info: $checkedConvert(
          'info',
          (v) => WeatherStation.fromJson(v as Map<String, dynamic>),
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
      'info': instance.info.toJson(),
      'sensors': instance.sensors.map((e) => e.toJson()).toList(),
    };
