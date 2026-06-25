// This is a generated file - do not edit.
//
// Generated from recorder.proto.

// @dart = 3.3

// ignore_for_file: annotate_overrides, camel_case_types, comment_references
// ignore_for_file: constant_identifier_names
// ignore_for_file: curly_braces_in_flow_control_structures
// ignore_for_file: deprecated_member_use_from_same_package, library_prefixes
// ignore_for_file: non_constant_identifier_names, prefer_relative_imports

import 'dart:core' as $core;

import 'package:protobuf/protobuf.dart' as $pb;

class RecordIntervalConfigurationType extends $pb.ProtobufEnum {
  static const RecordIntervalConfigurationType NOT_CONFIGURABLE =
      RecordIntervalConfigurationType._(
          0, _omitEnumNames ? '' : 'NOT_CONFIGURABLE');
  static const RecordIntervalConfigurationType FULLY_CONFIGURABLE =
      RecordIntervalConfigurationType._(
          1, _omitEnumNames ? '' : 'FULLY_CONFIGURABLE');
  static const RecordIntervalConfigurationType MULTIPLE_OF_DEFAULT =
      RecordIntervalConfigurationType._(
          2, _omitEnumNames ? '' : 'MULTIPLE_OF_DEFAULT');

  static const $core.List<RecordIntervalConfigurationType> values =
      <RecordIntervalConfigurationType>[
    NOT_CONFIGURABLE,
    FULLY_CONFIGURABLE,
    MULTIPLE_OF_DEFAULT,
  ];

  static final $core.List<RecordIntervalConfigurationType?> _byValue =
      $pb.ProtobufEnum.$_initByValueList(values, 2);
  static RecordIntervalConfigurationType? valueOf($core.int value) =>
      value < 0 || value >= _byValue.length ? null : _byValue[value];

  const RecordIntervalConfigurationType._(super.value, super.name);
}

const $core.bool _omitEnumNames =
    $core.bool.fromEnvironment('protobuf.omit_enum_names');
