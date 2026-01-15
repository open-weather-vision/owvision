// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'sensor.dart';

// **************************************************************************
// CopyWithGenerator
// **************************************************************************

abstract class _$SensorCWProxy {
  Sensor id(int id);

  Sensor element(SensorElement element);

  Sensor name(String name);

  /// Creates a new instance with the provided field values.
  /// Passing `null` to a nullable field nullifies it, while `null` for a non-nullable field is ignored. To update a single field use `Sensor(...).copyWith.fieldName(value)`.
  ///
  /// Example:
  /// ```dart
  /// Sensor(...).copyWith(id: 12, name: "My name")
  /// ```
  Sensor call({int id, SensorElement element, String name});
}

/// Callable proxy for `copyWith` functionality.
/// Use as `instanceOfSensor.copyWith(...)` or call `instanceOfSensor.copyWith.fieldName(value)` for a single field.
class _$SensorCWProxyImpl implements _$SensorCWProxy {
  const _$SensorCWProxyImpl(this._value);

  final Sensor _value;

  @override
  Sensor id(int id) => call(id: id);

  @override
  Sensor element(SensorElement element) => call(element: element);

  @override
  Sensor name(String name) => call(name: name);

  @override
  /// Creates a new instance with the provided field values.
  /// Passing `null` to a nullable field nullifies it, while `null` for a non-nullable field is ignored. To update a single field use `Sensor(...).copyWith.fieldName(value)`.
  ///
  /// Example:
  /// ```dart
  /// Sensor(...).copyWith(id: 12, name: "My name")
  /// ```
  Sensor call({
    Object? id = const $CopyWithPlaceholder(),
    Object? element = const $CopyWithPlaceholder(),
    Object? name = const $CopyWithPlaceholder(),
  }) {
    return Sensor(
      id: id == const $CopyWithPlaceholder() || id == null
          ? _value.id
          // ignore: cast_nullable_to_non_nullable
          : id as int,
      element: element == const $CopyWithPlaceholder() || element == null
          ? _value.element
          // ignore: cast_nullable_to_non_nullable
          : element as SensorElement,
      name: name == const $CopyWithPlaceholder() || name == null
          ? _value.name
          // ignore: cast_nullable_to_non_nullable
          : name as String,
    );
  }
}

extension $SensorCopyWith on Sensor {
  /// Returns a callable class used to build a new instance with modified fields.
  /// Example: `instanceOfSensor.copyWith(...)` or `instanceOfSensor.copyWith.fieldName(...)`.
  // ignore: library_private_types_in_public_api
  _$SensorCWProxy get copyWith => _$SensorCWProxyImpl(this);
}

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Sensor _$SensorFromJson(Map<String, dynamic> json) =>
    $checkedCreate('Sensor', json, ($checkedConvert) {
      $checkKeys(json, requiredKeys: const ['id', 'element', 'name']);
      final val = Sensor(
        id: $checkedConvert('id', (v) => (v as num).toInt()),
        element: $checkedConvert(
          'element',
          (v) => $enumDecode(_$SensorElementEnumMap, v),
        ),
        name: $checkedConvert('name', (v) => v as String),
      );
      return val;
    });

Map<String, dynamic> _$SensorToJson(Sensor instance) => <String, dynamic>{
  'id': instance.id,
  'element': _$SensorElementEnumMap[instance.element]!,
  'name': instance.name,
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
