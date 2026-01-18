// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'sensor_history.dart';

// **************************************************************************
// CopyWithGenerator
// **************************************************************************

abstract class _$SensorHistoryCWProxy {
  SensorHistory sensorName(String sensorName);

  SensorHistory unitId(String unitId);

  SensorHistory history(List<HistoryRecord> history);

  /// Creates a new instance with the provided field values.
  /// Passing `null` to a nullable field nullifies it, while `null` for a non-nullable field is ignored. To update a single field use `SensorHistory(...).copyWith.fieldName(value)`.
  ///
  /// Example:
  /// ```dart
  /// SensorHistory(...).copyWith(id: 12, name: "My name")
  /// ```
  SensorHistory call({
    String sensorName,
    String unitId,
    List<HistoryRecord> history,
  });
}

/// Callable proxy for `copyWith` functionality.
/// Use as `instanceOfSensorHistory.copyWith(...)` or call `instanceOfSensorHistory.copyWith.fieldName(value)` for a single field.
class _$SensorHistoryCWProxyImpl implements _$SensorHistoryCWProxy {
  const _$SensorHistoryCWProxyImpl(this._value);

  final SensorHistory _value;

  @override
  SensorHistory sensorName(String sensorName) => call(sensorName: sensorName);

  @override
  SensorHistory unitId(String unitId) => call(unitId: unitId);

  @override
  SensorHistory history(List<HistoryRecord> history) => call(history: history);

  @override
  /// Creates a new instance with the provided field values.
  /// Passing `null` to a nullable field nullifies it, while `null` for a non-nullable field is ignored. To update a single field use `SensorHistory(...).copyWith.fieldName(value)`.
  ///
  /// Example:
  /// ```dart
  /// SensorHistory(...).copyWith(id: 12, name: "My name")
  /// ```
  SensorHistory call({
    Object? sensorName = const $CopyWithPlaceholder(),
    Object? unitId = const $CopyWithPlaceholder(),
    Object? history = const $CopyWithPlaceholder(),
  }) {
    return SensorHistory(
      sensorName:
          sensorName == const $CopyWithPlaceholder() || sensorName == null
          ? _value.sensorName
          // ignore: cast_nullable_to_non_nullable
          : sensorName as String,
      unitId: unitId == const $CopyWithPlaceholder() || unitId == null
          ? _value.unitId
          // ignore: cast_nullable_to_non_nullable
          : unitId as String,
      history: history == const $CopyWithPlaceholder() || history == null
          ? _value.history
          // ignore: cast_nullable_to_non_nullable
          : history as List<HistoryRecord>,
    );
  }
}

extension $SensorHistoryCopyWith on SensorHistory {
  /// Returns a callable class used to build a new instance with modified fields.
  /// Example: `instanceOfSensorHistory.copyWith(...)` or `instanceOfSensorHistory.copyWith.fieldName(...)`.
  // ignore: library_private_types_in_public_api
  _$SensorHistoryCWProxy get copyWith => _$SensorHistoryCWProxyImpl(this);
}

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

SensorHistory _$SensorHistoryFromJson(Map<String, dynamic> json) =>
    $checkedCreate('SensorHistory', json, ($checkedConvert) {
      $checkKeys(json, requiredKeys: const ['sensorName', 'unitId', 'history']);
      final val = SensorHistory(
        sensorName: $checkedConvert('sensorName', (v) => v as String),
        unitId: $checkedConvert('unitId', (v) => v as String),
        history: $checkedConvert(
          'history',
          (v) => (v as List<dynamic>)
              .map((e) => HistoryRecord.fromJson(e as Map<String, dynamic>))
              .toList(),
        ),
      );
      return val;
    });

Map<String, dynamic> _$SensorHistoryToJson(SensorHistory instance) =>
    <String, dynamic>{
      'sensorName': instance.sensorName,
      'unitId': instance.unitId,
      'history': instance.history.map((e) => e.toJson()).toList(),
    };
