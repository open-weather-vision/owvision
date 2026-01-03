//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:json_annotation/json_annotation.dart';


enum TokenRole {
      @JsonValue(r'admin')
      admin(r'admin'),
      @JsonValue(r'recorder')
      recorder(r'recorder'),
      @JsonValue(r'viewer')
      viewer(r'viewer');

  const TokenRole(this.value);

  final String value;

  @override
  String toString() => value;
}
