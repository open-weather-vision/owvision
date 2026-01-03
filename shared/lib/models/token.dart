import 'package:json_annotation/json_annotation.dart';
import 'package:shared/models/token_role.dart';

part "token.g.dart";

@JsonSerializable()
class Token {
  final String token;
  TokenRole role;

  Token({required this.token, required this.role});

  factory Token.fromJson(Map<String, dynamic> json) => _$TokenFromJson(json);

  Map<String, dynamic> toJson() => _$TokenToJson(this);
}
