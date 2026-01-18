// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'error_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ErrorResponse _$ErrorResponseFromJson(Map<String, dynamic> json) =>
    ErrorResponse(
      $enumDecode(_$ErrorCodeEnumMap, json['code']),
      json['message'] as String,
    );

Map<String, dynamic> _$ErrorResponseToJson(ErrorResponse instance) =>
    <String, dynamic>{
      'code': _$ErrorCodeEnumMap[instance.code]!,
      'message': instance.message,
    };

const _$ErrorCodeEnumMap = {
  ErrorCode.unauthorized: 'unauthorized',
  ErrorCode.notFound: 'notFound',
  ErrorCode.badRequest: 'badRequest',
  ErrorCode.internalError: 'internalError',
};
