import 'package:json_annotation/json_annotation.dart';

part "error_response.g.dart";

@JsonSerializable()
class ErrorResponse {
  final ErrorCode code;
  final String message;

  ErrorResponse(this.code, this.message);

  factory ErrorResponse.fromJson(Map<String, dynamic> json) =>
      _$ErrorResponseFromJson(json);

  Map<String, dynamic> toJson() => _$ErrorResponseToJson(this);
}

enum ErrorCode { unauthorized, notFound, badRequest, internalError }
