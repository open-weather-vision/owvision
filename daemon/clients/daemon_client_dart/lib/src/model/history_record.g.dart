// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'history_record.dart';

// **************************************************************************
// CopyWithGenerator
// **************************************************************************

abstract class _$HistoryRecordCWProxy {
  HistoryRecord value(double? value);

  HistoryRecord createdAt(DateTime createdAt);

  /// Creates a new instance with the provided field values.
  /// Passing `null` to a nullable field nullifies it, while `null` for a non-nullable field is ignored. To update a single field use `HistoryRecord(...).copyWith.fieldName(value)`.
  ///
  /// Example:
  /// ```dart
  /// HistoryRecord(...).copyWith(id: 12, name: "My name")
  /// ```
  HistoryRecord call({double? value, DateTime createdAt});
}

/// Callable proxy for `copyWith` functionality.
/// Use as `instanceOfHistoryRecord.copyWith(...)` or call `instanceOfHistoryRecord.copyWith.fieldName(value)` for a single field.
class _$HistoryRecordCWProxyImpl implements _$HistoryRecordCWProxy {
  const _$HistoryRecordCWProxyImpl(this._value);

  final HistoryRecord _value;

  @override
  HistoryRecord value(double? value) => call(value: value);

  @override
  HistoryRecord createdAt(DateTime createdAt) => call(createdAt: createdAt);

  @override
  /// Creates a new instance with the provided field values.
  /// Passing `null` to a nullable field nullifies it, while `null` for a non-nullable field is ignored. To update a single field use `HistoryRecord(...).copyWith.fieldName(value)`.
  ///
  /// Example:
  /// ```dart
  /// HistoryRecord(...).copyWith(id: 12, name: "My name")
  /// ```
  HistoryRecord call({
    Object? value = const $CopyWithPlaceholder(),
    Object? createdAt = const $CopyWithPlaceholder(),
  }) {
    return HistoryRecord(
      value: value == const $CopyWithPlaceholder()
          ? _value.value
          // ignore: cast_nullable_to_non_nullable
          : value as double?,
      createdAt: createdAt == const $CopyWithPlaceholder() || createdAt == null
          ? _value.createdAt
          // ignore: cast_nullable_to_non_nullable
          : createdAt as DateTime,
    );
  }
}

extension $HistoryRecordCopyWith on HistoryRecord {
  /// Returns a callable class used to build a new instance with modified fields.
  /// Example: `instanceOfHistoryRecord.copyWith(...)` or `instanceOfHistoryRecord.copyWith.fieldName(...)`.
  // ignore: library_private_types_in_public_api
  _$HistoryRecordCWProxy get copyWith => _$HistoryRecordCWProxyImpl(this);
}

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

HistoryRecord _$HistoryRecordFromJson(Map<String, dynamic> json) =>
    $checkedCreate('HistoryRecord', json, ($checkedConvert) {
      $checkKeys(json, requiredKeys: const ['createdAt']);
      final val = HistoryRecord(
        value: $checkedConvert('value', (v) => (v as num?)?.toDouble()),
        createdAt: $checkedConvert(
          'createdAt',
          (v) => DateTime.parse(v as String),
        ),
      );
      return val;
    });

Map<String, dynamic> _$HistoryRecordToJson(HistoryRecord instance) =>
    <String, dynamic>{
      'value': ?instance.value,
      'createdAt': instance.createdAt.toIso8601String(),
    };
