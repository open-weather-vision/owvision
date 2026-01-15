// This is a generated file - do not edit.
//
// Generated from recorder.proto.

// @dart = 3.3

// ignore_for_file: annotate_overrides, camel_case_types, comment_references
// ignore_for_file: constant_identifier_names
// ignore_for_file: curly_braces_in_flow_control_structures
// ignore_for_file: deprecated_member_use_from_same_package, library_prefixes
// ignore_for_file: non_constant_identifier_names, prefer_relative_imports
// ignore_for_file: unused_import

import 'dart:convert' as $convert;
import 'dart:core' as $core;
import 'dart:typed_data' as $typed_data;

@$core.Deprecated('Use pingMessageDescriptor instead')
const PingMessage$json = {
  '1': 'PingMessage',
  '2': [
    {'1': 'randomId', '3': 1, '4': 1, '5': 3, '10': 'randomId'},
  ],
};

/// Descriptor for `PingMessage`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List pingMessageDescriptor = $convert
    .base64Decode('CgtQaW5nTWVzc2FnZRIaCghyYW5kb21JZBgBIAEoA1IIcmFuZG9tSWQ=');

@$core.Deprecated('Use getStationRequestDescriptor instead')
const GetStationRequest$json = {
  '1': 'GetStationRequest',
  '2': [
    {'1': 'stationId', '3': 1, '4': 1, '5': 3, '10': 'stationId'},
  ],
};

/// Descriptor for `GetStationRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List getStationRequestDescriptor = $convert.base64Decode(
    'ChFHZXRTdGF0aW9uUmVxdWVzdBIcCglzdGF0aW9uSWQYASABKANSCXN0YXRpb25JZA==');

@$core.Deprecated('Use updateSensorsRequestDescriptor instead')
const UpdateSensorsRequest$json = {
  '1': 'UpdateSensorsRequest',
  '2': [
    {
      '1': 'updates',
      '3': 1,
      '4': 3,
      '5': 11,
      '6': '.recorder.UpdateSensorRequest',
      '10': 'updates'
    },
  ],
};

/// Descriptor for `UpdateSensorsRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List updateSensorsRequestDescriptor = $convert.base64Decode(
    'ChRVcGRhdGVTZW5zb3JzUmVxdWVzdBI3Cgd1cGRhdGVzGAEgAygLMh0ucmVjb3JkZXIuVXBkYX'
    'RlU2Vuc29yUmVxdWVzdFIHdXBkYXRlcw==');

@$core.Deprecated('Use updateSensorRequestDescriptor instead')
const UpdateSensorRequest$json = {
  '1': 'UpdateSensorRequest',
  '2': [
    {'1': 'sensorId', '3': 1, '4': 1, '5': 3, '10': 'sensorId'},
    {
      '1': 'newState',
      '3': 2,
      '4': 1,
      '5': 11,
      '6': '.recorder.SensorState',
      '10': 'newState'
    },
    {'1': 'updateId', '3': 3, '4': 1, '5': 3, '10': 'updateId'},
  ],
};

/// Descriptor for `UpdateSensorRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List updateSensorRequestDescriptor = $convert.base64Decode(
    'ChNVcGRhdGVTZW5zb3JSZXF1ZXN0EhoKCHNlbnNvcklkGAEgASgDUghzZW5zb3JJZBIxCghuZX'
    'dTdGF0ZRgCIAEoCzIVLnJlY29yZGVyLlNlbnNvclN0YXRlUghuZXdTdGF0ZRIaCgh1cGRhdGVJ'
    'ZBgDIAEoA1IIdXBkYXRlSWQ=');

@$core.Deprecated('Use updateSensorsResponseDescriptor instead')
const UpdateSensorsResponse$json = {
  '1': 'UpdateSensorsResponse',
  '2': [
    {'1': 'errors', '3': 1, '4': 3, '5': 9, '10': 'errors'},
    {'1': 'processed', '3': 2, '4': 3, '5': 3, '10': 'processed'},
  ],
};

/// Descriptor for `UpdateSensorsResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List updateSensorsResponseDescriptor = $convert.base64Decode(
    'ChVVcGRhdGVTZW5zb3JzUmVzcG9uc2USFgoGZXJyb3JzGAEgAygJUgZlcnJvcnMSHAoJcHJvY2'
    'Vzc2VkGAIgAygDUglwcm9jZXNzZWQ=');

@$core.Deprecated('Use updateStationRequestDescriptor instead')
const UpdateStationRequest$json = {
  '1': 'UpdateStationRequest',
  '2': [
    {'1': 'stationId', '3': 1, '4': 1, '5': 3, '10': 'stationId'},
    {
      '1': 'definition',
      '3': 2,
      '4': 1,
      '5': 11,
      '6': '.recorder.StationDefinition',
      '10': 'definition'
    },
  ],
};

/// Descriptor for `UpdateStationRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List updateStationRequestDescriptor = $convert.base64Decode(
    'ChRVcGRhdGVTdGF0aW9uUmVxdWVzdBIcCglzdGF0aW9uSWQYASABKANSCXN0YXRpb25JZBI7Cg'
    'pkZWZpbml0aW9uGAIgASgLMhsucmVjb3JkZXIuU3RhdGlvbkRlZmluaXRpb25SCmRlZmluaXRp'
    'b24=');

@$core.Deprecated('Use getStationDefinitionRequestDescriptor instead')
const GetStationDefinitionRequest$json = {
  '1': 'GetStationDefinitionRequest',
};

/// Descriptor for `GetStationDefinitionRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List getStationDefinitionRequestDescriptor =
    $convert.base64Decode('ChtHZXRTdGF0aW9uRGVmaW5pdGlvblJlcXVlc3Q=');

@$core.Deprecated('Use stationDefinitionDescriptor instead')
const StationDefinition$json = {
  '1': 'StationDefinition',
  '2': [
    {'1': 'name', '3': 1, '4': 1, '5': 9, '10': 'name'},
    {
      '1': 'sensors',
      '3': 2,
      '4': 3,
      '5': 11,
      '6': '.recorder.SensorDefinition',
      '10': 'sensors'
    },
    {'1': 'longitude', '3': 3, '4': 1, '5': 1, '10': 'longitude'},
    {'1': 'latitude', '3': 4, '4': 1, '5': 1, '10': 'latitude'},
    {'1': 'version', '3': 5, '4': 1, '5': 5, '10': 'version'},
  ],
};

/// Descriptor for `StationDefinition`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List stationDefinitionDescriptor = $convert.base64Decode(
    'ChFTdGF0aW9uRGVmaW5pdGlvbhISCgRuYW1lGAEgASgJUgRuYW1lEjQKB3NlbnNvcnMYAiADKA'
    'syGi5yZWNvcmRlci5TZW5zb3JEZWZpbml0aW9uUgdzZW5zb3JzEhwKCWxvbmdpdHVkZRgDIAEo'
    'AVIJbG9uZ2l0dWRlEhoKCGxhdGl0dWRlGAQgASgBUghsYXRpdHVkZRIYCgd2ZXJzaW9uGAUgAS'
    'gFUgd2ZXJzaW9u');

@$core.Deprecated('Use sensorDefinitionDescriptor instead')
const SensorDefinition$json = {
  '1': 'SensorDefinition',
  '2': [
    {'1': 'name', '3': 1, '4': 1, '5': 9, '10': 'name'},
    {'1': 'element', '3': 2, '4': 1, '5': 9, '10': 'element'},
    {
      '1': 'recordIntervalSeconds',
      '3': 3,
      '4': 1,
      '5': 3,
      '10': 'recordIntervalSeconds'
    },
  ],
};

/// Descriptor for `SensorDefinition`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List sensorDefinitionDescriptor = $convert.base64Decode(
    'ChBTZW5zb3JEZWZpbml0aW9uEhIKBG5hbWUYASABKAlSBG5hbWUSGAoHZWxlbWVudBgCIAEoCV'
    'IHZWxlbWVudBI0ChVyZWNvcmRJbnRlcnZhbFNlY29uZHMYAyABKANSFXJlY29yZEludGVydmFs'
    'U2Vjb25kcw==');

@$core.Deprecated('Use stationDescriptor instead')
const Station$json = {
  '1': 'Station',
  '2': [
    {'1': 'id', '3': 1, '4': 1, '5': 3, '10': 'id'},
    {
      '1': 'sensors',
      '3': 2,
      '4': 3,
      '5': 11,
      '6': '.recorder.Sensor',
      '10': 'sensors'
    },
    {'1': 'version', '3': 3, '4': 1, '5': 5, '10': 'version'},
  ],
};

/// Descriptor for `Station`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List stationDescriptor = $convert.base64Decode(
    'CgdTdGF0aW9uEg4KAmlkGAEgASgDUgJpZBIqCgdzZW5zb3JzGAIgAygLMhAucmVjb3JkZXIuU2'
    'Vuc29yUgdzZW5zb3JzEhgKB3ZlcnNpb24YAyABKAVSB3ZlcnNpb24=');

@$core.Deprecated('Use sensorDescriptor instead')
const Sensor$json = {
  '1': 'Sensor',
  '2': [
    {'1': 'id', '3': 1, '4': 1, '5': 3, '10': 'id'},
    {'1': 'name', '3': 2, '4': 1, '5': 9, '10': 'name'},
    {
      '1': 'recordIntervalSeconds',
      '3': 3,
      '4': 1,
      '5': 3,
      '10': 'recordIntervalSeconds'
    },
  ],
};

/// Descriptor for `Sensor`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List sensorDescriptor = $convert.base64Decode(
    'CgZTZW5zb3ISDgoCaWQYASABKANSAmlkEhIKBG5hbWUYAiABKAlSBG5hbWUSNAoVcmVjb3JkSW'
    '50ZXJ2YWxTZWNvbmRzGAMgASgDUhVyZWNvcmRJbnRlcnZhbFNlY29uZHM=');

@$core.Deprecated('Use getSensorStateRequestDescriptor instead')
const GetSensorStateRequest$json = {
  '1': 'GetSensorStateRequest',
  '2': [
    {'1': 'name', '3': 1, '4': 1, '5': 9, '10': 'name'},
  ],
};

/// Descriptor for `GetSensorStateRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List getSensorStateRequestDescriptor =
    $convert.base64Decode(
        'ChVHZXRTZW5zb3JTdGF0ZVJlcXVlc3QSEgoEbmFtZRgBIAEoCVIEbmFtZQ==');

@$core.Deprecated('Use sensorStateDescriptor instead')
const SensorState$json = {
  '1': 'SensorState',
  '2': [
    {'1': 'unitId', '3': 2, '4': 1, '5': 9, '10': 'unitId'},
    {'1': 'value', '3': 3, '4': 1, '5': 1, '9': 0, '10': 'value', '17': true},
    {'1': 'created_at', '3': 4, '4': 1, '5': 3, '10': 'createdAt'},
    {
      '1': 'intervalStart',
      '3': 5,
      '4': 1,
      '5': 3,
      '9': 1,
      '10': 'intervalStart',
      '17': true
    },
  ],
  '8': [
    {'1': '_value'},
    {'1': '_intervalStart'},
  ],
};

/// Descriptor for `SensorState`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List sensorStateDescriptor = $convert.base64Decode(
    'CgtTZW5zb3JTdGF0ZRIWCgZ1bml0SWQYAiABKAlSBnVuaXRJZBIZCgV2YWx1ZRgDIAEoAUgAUg'
    'V2YWx1ZYgBARIdCgpjcmVhdGVkX2F0GAQgASgDUgljcmVhdGVkQXQSKQoNaW50ZXJ2YWxTdGFy'
    'dBgFIAEoA0gBUg1pbnRlcnZhbFN0YXJ0iAEBQggKBl92YWx1ZUIQCg5faW50ZXJ2YWxTdGFydA'
    '==');
