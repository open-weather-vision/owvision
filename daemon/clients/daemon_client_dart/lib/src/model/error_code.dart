//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:json_annotation/json_annotation.dart';


enum ErrorCode {
      @JsonValue(r'unauthorized')
      unauthorized(r'unauthorized'),
      @JsonValue(r'notFound')
      notFound(r'notFound'),
      @JsonValue(r'internalError')
      internalError(r'internalError'),
      @JsonValue(r'badRequest')
      badRequest(r'badRequest');

  const ErrorCode(this.value);

  final String value;

  @override
  String toString() => value;
}
