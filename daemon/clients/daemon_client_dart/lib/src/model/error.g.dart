// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'error.dart';

// **************************************************************************
// CopyWithGenerator
// **************************************************************************

abstract class _$ErrorCWProxy {
  Error code(ErrorCode code);

  Error message(String message);

  /// Creates a new instance with the provided field values.
  /// Passing `null` to a nullable field nullifies it, while `null` for a non-nullable field is ignored. To update a single field use `Error(...).copyWith.fieldName(value)`.
  ///
  /// Example:
  /// ```dart
  /// Error(...).copyWith(id: 12, name: "My name")
  /// ```
  Error call({ErrorCode code, String message});
}

/// Callable proxy for `copyWith` functionality.
/// Use as `instanceOfError.copyWith(...)` or call `instanceOfError.copyWith.fieldName(value)` for a single field.
class _$ErrorCWProxyImpl implements _$ErrorCWProxy {
  const _$ErrorCWProxyImpl(this._value);

  final Error _value;

  @override
  Error code(ErrorCode code) => call(code: code);

  @override
  Error message(String message) => call(message: message);

  @override
  /// Creates a new instance with the provided field values.
  /// Passing `null` to a nullable field nullifies it, while `null` for a non-nullable field is ignored. To update a single field use `Error(...).copyWith.fieldName(value)`.
  ///
  /// Example:
  /// ```dart
  /// Error(...).copyWith(id: 12, name: "My name")
  /// ```
  Error call({
    Object? code = const $CopyWithPlaceholder(),
    Object? message = const $CopyWithPlaceholder(),
  }) {
    return Error(
      code: code == const $CopyWithPlaceholder() || code == null
          ? _value.code
          // ignore: cast_nullable_to_non_nullable
          : code as ErrorCode,
      message: message == const $CopyWithPlaceholder() || message == null
          ? _value.message
          // ignore: cast_nullable_to_non_nullable
          : message as String,
    );
  }
}

extension $ErrorCopyWith on Error {
  /// Returns a callable class used to build a new instance with modified fields.
  /// Example: `instanceOfError.copyWith(...)` or `instanceOfError.copyWith.fieldName(...)`.
  // ignore: library_private_types_in_public_api
  _$ErrorCWProxy get copyWith => _$ErrorCWProxyImpl(this);
}

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Error _$ErrorFromJson(Map<String, dynamic> json) => $checkedCreate(
  'Error',
  json,
  ($checkedConvert) {
    $checkKeys(json, requiredKeys: const ['code', 'message']);
    final val = Error(
      code: $checkedConvert('code', (v) => $enumDecode(_$ErrorCodeEnumMap, v)),
      message: $checkedConvert('message', (v) => v as String),
    );
    return val;
  },
);

Map<String, dynamic> _$ErrorToJson(Error instance) => <String, dynamic>{
  'code': _$ErrorCodeEnumMap[instance.code]!,
  'message': instance.message,
};

const _$ErrorCodeEnumMap = {
  ErrorCode.unauthorized: 'unauthorized',
  ErrorCode.notFound: 'notFound',
  ErrorCode.internalError: 'internalError',
  ErrorCode.badRequest: 'badRequest',
};
