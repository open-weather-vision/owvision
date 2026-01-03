// This is a generated file - do not edit.
//
// Generated from recorder.proto.

// @dart = 3.3

// ignore_for_file: annotate_overrides, camel_case_types, comment_references
// ignore_for_file: constant_identifier_names
// ignore_for_file: curly_braces_in_flow_control_structures
// ignore_for_file: deprecated_member_use_from_same_package, library_prefixes
// ignore_for_file: non_constant_identifier_names, prefer_relative_imports

import 'dart:async' as $async;
import 'dart:core' as $core;

import 'package:protobuf/protobuf.dart' as $pb;

import 'recorder.pb.dart' as $0;
import 'recorder.pbjson.dart';

export 'recorder.pb.dart';

abstract class RemoteRecorderServiceBase extends $pb.GeneratedService {
  $async.Future<$0.DefineStationResponse> getStation(
      $pb.ServerContext ctx, $0.GetStationRequest request);
  $async.Future<$0.DefineStationResponse> defineStation(
      $pb.ServerContext ctx, $0.DefineStationRequest request);
  $async.Future<$0.UpdateSensorResponse> updateSensor(
      $pb.ServerContext ctx, $0.UpdateSensorRequest request);

  $pb.GeneratedMessage createRequest($core.String methodName) {
    switch (methodName) {
      case 'GetStation':
        return $0.GetStationRequest();
      case 'DefineStation':
        return $0.DefineStationRequest();
      case 'UpdateSensor':
        return $0.UpdateSensorRequest();
      default:
        throw $core.ArgumentError('Unknown method: $methodName');
    }
  }

  $async.Future<$pb.GeneratedMessage> handleCall($pb.ServerContext ctx,
      $core.String methodName, $pb.GeneratedMessage request) {
    switch (methodName) {
      case 'GetStation':
        return getStation(ctx, request as $0.GetStationRequest);
      case 'DefineStation':
        return defineStation(ctx, request as $0.DefineStationRequest);
      case 'UpdateSensor':
        return updateSensor(ctx, request as $0.UpdateSensorRequest);
      default:
        throw $core.ArgumentError('Unknown method: $methodName');
    }
  }

  $core.Map<$core.String, $core.dynamic> get $json =>
      RemoteRecorderServiceBase$json;
  $core.Map<$core.String, $core.Map<$core.String, $core.dynamic>>
      get $messageJson => RemoteRecorderServiceBase$messageJson;
}

abstract class LocalRecorderServiceBase extends $pb.GeneratedService {
  $async.Future<$0.DefineStationResponse> defineStation(
      $pb.ServerContext ctx, $0.DefineStationRequest request);
  $async.Future<$0.UpdateSensorResponse> updateSensor(
      $pb.ServerContext ctx, $0.UpdateSensorRequest request);

  $pb.GeneratedMessage createRequest($core.String methodName) {
    switch (methodName) {
      case 'DefineStation':
        return $0.DefineStationRequest();
      case 'UpdateSensor':
        return $0.UpdateSensorRequest();
      default:
        throw $core.ArgumentError('Unknown method: $methodName');
    }
  }

  $async.Future<$pb.GeneratedMessage> handleCall($pb.ServerContext ctx,
      $core.String methodName, $pb.GeneratedMessage request) {
    switch (methodName) {
      case 'DefineStation':
        return defineStation(ctx, request as $0.DefineStationRequest);
      case 'UpdateSensor':
        return updateSensor(ctx, request as $0.UpdateSensorRequest);
      default:
        throw $core.ArgumentError('Unknown method: $methodName');
    }
  }

  $core.Map<$core.String, $core.dynamic> get $json =>
      LocalRecorderServiceBase$json;
  $core.Map<$core.String, $core.Map<$core.String, $core.dynamic>>
      get $messageJson => LocalRecorderServiceBase$messageJson;
}
