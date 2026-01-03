// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'token.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Token _$TokenFromJson(Map<String, dynamic> json) => Token(
  token: json['token'] as String,
  role: $enumDecode(_$TokenRoleEnumMap, json['role']),
);

Map<String, dynamic> _$TokenToJson(Token instance) => <String, dynamic>{
  'token': instance.token,
  'role': _$TokenRoleEnumMap[instance.role]!,
};

const _$TokenRoleEnumMap = {
  TokenRole.recorder: 'recorder',
  TokenRole.viewer: 'viewer',
  TokenRole.admin: 'admin',
  TokenRole.initialize: 'initialize',
};
