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

import 'package:grpc/service_api.dart' as $grpc;
import 'package:protobuf/protobuf.dart' as $pb;

import 'recorder.pb.dart' as $0;

export 'recorder.pb.dart';

@$pb.GrpcServiceName('recorder.DaemonService')
class DaemonServiceClient extends $grpc.Client {
  /// The hostname for this service.
  static const $core.String defaultHost = '';

  /// OAuth scopes needed for the client.
  static const $core.List<$core.String> oauthScopes = [
    '',
  ];

  DaemonServiceClient(super.channel, {super.options, super.interceptors});

  $grpc.ResponseFuture<$0.Station> createStation(
    $0.StationDefinition request, {
    $grpc.CallOptions? options,
  }) {
    return $createUnaryCall(_$createStation, request, options: options);
  }

  $grpc.ResponseFuture<$0.Station> getStation(
    $0.GetStationRequest request, {
    $grpc.CallOptions? options,
  }) {
    return $createUnaryCall(_$getStation, request, options: options);
  }

  $grpc.ResponseFuture<$0.Station> updateStation(
    $0.UpdateStationRequest request, {
    $grpc.CallOptions? options,
  }) {
    return $createUnaryCall(_$updateStation, request, options: options);
  }

  $grpc.ResponseFuture<$0.UpdateSensorsResponse> updateSensors(
    $0.UpdateSensorsRequest request, {
    $grpc.CallOptions? options,
  }) {
    return $createUnaryCall(_$updateSensors, request, options: options);
  }

  $grpc.ResponseFuture<$0.PingMessage> ping(
    $0.PingMessage request, {
    $grpc.CallOptions? options,
  }) {
    return $createUnaryCall(_$ping, request, options: options);
  }

  // method descriptors

  static final _$createStation =
      $grpc.ClientMethod<$0.StationDefinition, $0.Station>(
          '/recorder.DaemonService/CreateStation',
          ($0.StationDefinition value) => value.writeToBuffer(),
          $0.Station.fromBuffer);
  static final _$getStation =
      $grpc.ClientMethod<$0.GetStationRequest, $0.Station>(
          '/recorder.DaemonService/GetStation',
          ($0.GetStationRequest value) => value.writeToBuffer(),
          $0.Station.fromBuffer);
  static final _$updateStation =
      $grpc.ClientMethod<$0.UpdateStationRequest, $0.Station>(
          '/recorder.DaemonService/UpdateStation',
          ($0.UpdateStationRequest value) => value.writeToBuffer(),
          $0.Station.fromBuffer);
  static final _$updateSensors =
      $grpc.ClientMethod<$0.UpdateSensorsRequest, $0.UpdateSensorsResponse>(
          '/recorder.DaemonService/UpdateSensors',
          ($0.UpdateSensorsRequest value) => value.writeToBuffer(),
          $0.UpdateSensorsResponse.fromBuffer);
  static final _$ping = $grpc.ClientMethod<$0.PingMessage, $0.PingMessage>(
      '/recorder.DaemonService/Ping',
      ($0.PingMessage value) => value.writeToBuffer(),
      $0.PingMessage.fromBuffer);
}

@$pb.GrpcServiceName('recorder.DaemonService')
abstract class DaemonServiceBase extends $grpc.Service {
  $core.String get $name => 'recorder.DaemonService';

  DaemonServiceBase() {
    $addMethod($grpc.ServiceMethod<$0.StationDefinition, $0.Station>(
        'CreateStation',
        createStation_Pre,
        false,
        false,
        ($core.List<$core.int> value) => $0.StationDefinition.fromBuffer(value),
        ($0.Station value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$0.GetStationRequest, $0.Station>(
        'GetStation',
        getStation_Pre,
        false,
        false,
        ($core.List<$core.int> value) => $0.GetStationRequest.fromBuffer(value),
        ($0.Station value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$0.UpdateStationRequest, $0.Station>(
        'UpdateStation',
        updateStation_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $0.UpdateStationRequest.fromBuffer(value),
        ($0.Station value) => value.writeToBuffer()));
    $addMethod(
        $grpc.ServiceMethod<$0.UpdateSensorsRequest, $0.UpdateSensorsResponse>(
            'UpdateSensors',
            updateSensors_Pre,
            false,
            false,
            ($core.List<$core.int> value) =>
                $0.UpdateSensorsRequest.fromBuffer(value),
            ($0.UpdateSensorsResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$0.PingMessage, $0.PingMessage>(
        'Ping',
        ping_Pre,
        false,
        false,
        ($core.List<$core.int> value) => $0.PingMessage.fromBuffer(value),
        ($0.PingMessage value) => value.writeToBuffer()));
  }

  $async.Future<$0.Station> createStation_Pre($grpc.ServiceCall $call,
      $async.Future<$0.StationDefinition> $request) async {
    return createStation($call, await $request);
  }

  $async.Future<$0.Station> createStation(
      $grpc.ServiceCall call, $0.StationDefinition request);

  $async.Future<$0.Station> getStation_Pre($grpc.ServiceCall $call,
      $async.Future<$0.GetStationRequest> $request) async {
    return getStation($call, await $request);
  }

  $async.Future<$0.Station> getStation(
      $grpc.ServiceCall call, $0.GetStationRequest request);

  $async.Future<$0.Station> updateStation_Pre($grpc.ServiceCall $call,
      $async.Future<$0.UpdateStationRequest> $request) async {
    return updateStation($call, await $request);
  }

  $async.Future<$0.Station> updateStation(
      $grpc.ServiceCall call, $0.UpdateStationRequest request);

  $async.Future<$0.UpdateSensorsResponse> updateSensors_Pre(
      $grpc.ServiceCall $call,
      $async.Future<$0.UpdateSensorsRequest> $request) async {
    return updateSensors($call, await $request);
  }

  $async.Future<$0.UpdateSensorsResponse> updateSensors(
      $grpc.ServiceCall call, $0.UpdateSensorsRequest request);

  $async.Future<$0.PingMessage> ping_Pre(
      $grpc.ServiceCall $call, $async.Future<$0.PingMessage> $request) async {
    return ping($call, await $request);
  }

  $async.Future<$0.PingMessage> ping(
      $grpc.ServiceCall call, $0.PingMessage request);
}

@$pb.GrpcServiceName('recorder.StationInterface')
class StationInterfaceClient extends $grpc.Client {
  /// The hostname for this service.
  static const $core.String defaultHost = '';

  /// OAuth scopes needed for the client.
  static const $core.List<$core.String> oauthScopes = [
    '',
  ];

  StationInterfaceClient(super.channel, {super.options, super.interceptors});

  $grpc.ResponseFuture<$0.StationDefinition> getStationDefinition(
    $0.GetStationDefinitionRequest request, {
    $grpc.CallOptions? options,
  }) {
    return $createUnaryCall(_$getStationDefinition, request, options: options);
  }

  $grpc.ResponseFuture<$0.SensorState> getSensorState(
    $0.GetSensorStateRequest request, {
    $grpc.CallOptions? options,
  }) {
    return $createUnaryCall(_$getSensorState, request, options: options);
  }

  // method descriptors

  static final _$getStationDefinition =
      $grpc.ClientMethod<$0.GetStationDefinitionRequest, $0.StationDefinition>(
          '/recorder.StationInterface/GetStationDefinition',
          ($0.GetStationDefinitionRequest value) => value.writeToBuffer(),
          $0.StationDefinition.fromBuffer);
  static final _$getSensorState =
      $grpc.ClientMethod<$0.GetSensorStateRequest, $0.SensorState>(
          '/recorder.StationInterface/GetSensorState',
          ($0.GetSensorStateRequest value) => value.writeToBuffer(),
          $0.SensorState.fromBuffer);
}

@$pb.GrpcServiceName('recorder.StationInterface')
abstract class StationInterfaceServiceBase extends $grpc.Service {
  $core.String get $name => 'recorder.StationInterface';

  StationInterfaceServiceBase() {
    $addMethod($grpc.ServiceMethod<$0.GetStationDefinitionRequest,
            $0.StationDefinition>(
        'GetStationDefinition',
        getStationDefinition_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $0.GetStationDefinitionRequest.fromBuffer(value),
        ($0.StationDefinition value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$0.GetSensorStateRequest, $0.SensorState>(
        'GetSensorState',
        getSensorState_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $0.GetSensorStateRequest.fromBuffer(value),
        ($0.SensorState value) => value.writeToBuffer()));
  }

  $async.Future<$0.StationDefinition> getStationDefinition_Pre(
      $grpc.ServiceCall $call,
      $async.Future<$0.GetStationDefinitionRequest> $request) async {
    return getStationDefinition($call, await $request);
  }

  $async.Future<$0.StationDefinition> getStationDefinition(
      $grpc.ServiceCall call, $0.GetStationDefinitionRequest request);

  $async.Future<$0.SensorState> getSensorState_Pre($grpc.ServiceCall $call,
      $async.Future<$0.GetSensorStateRequest> $request) async {
    return getSensorState($call, await $request);
  }

  $async.Future<$0.SensorState> getSensorState(
      $grpc.ServiceCall call, $0.GetSensorStateRequest request);
}
