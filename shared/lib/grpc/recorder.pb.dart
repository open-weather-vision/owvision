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

import 'package:fixnum/fixnum.dart' as $fixnum;
import 'package:protobuf/protobuf.dart' as $pb;

export 'package:protobuf/protobuf.dart' show GeneratedMessageGenericExtensions;

class PingMessage extends $pb.GeneratedMessage {
  factory PingMessage({
    $fixnum.Int64? randomId,
  }) {
    final result = create();
    if (randomId != null) result.randomId = randomId;
    return result;
  }

  PingMessage._();

  factory PingMessage.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory PingMessage.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'PingMessage',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'recorder'),
      createEmptyInstance: create)
    ..aInt64(1, _omitFieldNames ? '' : 'randomId', protoName: 'randomId')
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  PingMessage clone() => deepCopy();
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  PingMessage copyWith(void Function(PingMessage) updates) =>
      super.copyWith((message) => updates(message as PingMessage))
          as PingMessage;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static PingMessage create() => PingMessage._();
  @$core.override
  PingMessage createEmptyInstance() => create();
  @$core.pragma('dart2js:noInline')
  static PingMessage getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<PingMessage>(create);
  static PingMessage? _defaultInstance;

  @$pb.TagNumber(1)
  $fixnum.Int64 get randomId => $_getI64(0);
  @$pb.TagNumber(1)
  set randomId($fixnum.Int64 value) => $_setInt64(0, value);
  @$pb.TagNumber(1)
  $core.bool hasRandomId() => $_has(0);
  @$pb.TagNumber(1)
  void clearRandomId() => $_clearField(1);
}

class GetStationRequest extends $pb.GeneratedMessage {
  factory GetStationRequest({
    $fixnum.Int64? stationId,
  }) {
    final result = create();
    if (stationId != null) result.stationId = stationId;
    return result;
  }

  GetStationRequest._();

  factory GetStationRequest.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory GetStationRequest.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'GetStationRequest',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'recorder'),
      createEmptyInstance: create)
    ..aInt64(1, _omitFieldNames ? '' : 'stationId', protoName: 'stationId')
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  GetStationRequest clone() => deepCopy();
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  GetStationRequest copyWith(void Function(GetStationRequest) updates) =>
      super.copyWith((message) => updates(message as GetStationRequest))
          as GetStationRequest;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static GetStationRequest create() => GetStationRequest._();
  @$core.override
  GetStationRequest createEmptyInstance() => create();
  @$core.pragma('dart2js:noInline')
  static GetStationRequest getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<GetStationRequest>(create);
  static GetStationRequest? _defaultInstance;

  @$pb.TagNumber(1)
  $fixnum.Int64 get stationId => $_getI64(0);
  @$pb.TagNumber(1)
  set stationId($fixnum.Int64 value) => $_setInt64(0, value);
  @$pb.TagNumber(1)
  $core.bool hasStationId() => $_has(0);
  @$pb.TagNumber(1)
  void clearStationId() => $_clearField(1);
}

class UpdateSensorsRequest extends $pb.GeneratedMessage {
  factory UpdateSensorsRequest({
    $core.Iterable<UpdateSensorRequest>? updates,
  }) {
    final result = create();
    if (updates != null) result.updates.addAll(updates);
    return result;
  }

  UpdateSensorsRequest._();

  factory UpdateSensorsRequest.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory UpdateSensorsRequest.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'UpdateSensorsRequest',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'recorder'),
      createEmptyInstance: create)
    ..pPM<UpdateSensorRequest>(1, _omitFieldNames ? '' : 'updates',
        subBuilder: UpdateSensorRequest.create)
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  UpdateSensorsRequest clone() => deepCopy();
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  UpdateSensorsRequest copyWith(void Function(UpdateSensorsRequest) updates) =>
      super.copyWith((message) => updates(message as UpdateSensorsRequest))
          as UpdateSensorsRequest;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static UpdateSensorsRequest create() => UpdateSensorsRequest._();
  @$core.override
  UpdateSensorsRequest createEmptyInstance() => create();
  @$core.pragma('dart2js:noInline')
  static UpdateSensorsRequest getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<UpdateSensorsRequest>(create);
  static UpdateSensorsRequest? _defaultInstance;

  @$pb.TagNumber(1)
  $pb.PbList<UpdateSensorRequest> get updates => $_getList(0);
}

class UpdateSensorRequest extends $pb.GeneratedMessage {
  factory UpdateSensorRequest({
    $fixnum.Int64? sensorId,
    SensorState? newState,
    $fixnum.Int64? updateId,
  }) {
    final result = create();
    if (sensorId != null) result.sensorId = sensorId;
    if (newState != null) result.newState = newState;
    if (updateId != null) result.updateId = updateId;
    return result;
  }

  UpdateSensorRequest._();

  factory UpdateSensorRequest.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory UpdateSensorRequest.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'UpdateSensorRequest',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'recorder'),
      createEmptyInstance: create)
    ..aInt64(1, _omitFieldNames ? '' : 'sensorId', protoName: 'sensorId')
    ..aOM<SensorState>(2, _omitFieldNames ? '' : 'newState',
        protoName: 'newState', subBuilder: SensorState.create)
    ..aInt64(3, _omitFieldNames ? '' : 'updateId', protoName: 'updateId')
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  UpdateSensorRequest clone() => deepCopy();
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  UpdateSensorRequest copyWith(void Function(UpdateSensorRequest) updates) =>
      super.copyWith((message) => updates(message as UpdateSensorRequest))
          as UpdateSensorRequest;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static UpdateSensorRequest create() => UpdateSensorRequest._();
  @$core.override
  UpdateSensorRequest createEmptyInstance() => create();
  @$core.pragma('dart2js:noInline')
  static UpdateSensorRequest getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<UpdateSensorRequest>(create);
  static UpdateSensorRequest? _defaultInstance;

  @$pb.TagNumber(1)
  $fixnum.Int64 get sensorId => $_getI64(0);
  @$pb.TagNumber(1)
  set sensorId($fixnum.Int64 value) => $_setInt64(0, value);
  @$pb.TagNumber(1)
  $core.bool hasSensorId() => $_has(0);
  @$pb.TagNumber(1)
  void clearSensorId() => $_clearField(1);

  @$pb.TagNumber(2)
  SensorState get newState => $_getN(1);
  @$pb.TagNumber(2)
  set newState(SensorState value) => $_setField(2, value);
  @$pb.TagNumber(2)
  $core.bool hasNewState() => $_has(1);
  @$pb.TagNumber(2)
  void clearNewState() => $_clearField(2);
  @$pb.TagNumber(2)
  SensorState ensureNewState() => $_ensure(1);

  @$pb.TagNumber(3)
  $fixnum.Int64 get updateId => $_getI64(2);
  @$pb.TagNumber(3)
  set updateId($fixnum.Int64 value) => $_setInt64(2, value);
  @$pb.TagNumber(3)
  $core.bool hasUpdateId() => $_has(2);
  @$pb.TagNumber(3)
  void clearUpdateId() => $_clearField(3);
}

class UpdateSensorsResponse extends $pb.GeneratedMessage {
  factory UpdateSensorsResponse({
    $core.Iterable<$core.String>? errors,
    $core.Iterable<$fixnum.Int64>? processed,
  }) {
    final result = create();
    if (errors != null) result.errors.addAll(errors);
    if (processed != null) result.processed.addAll(processed);
    return result;
  }

  UpdateSensorsResponse._();

  factory UpdateSensorsResponse.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory UpdateSensorsResponse.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'UpdateSensorsResponse',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'recorder'),
      createEmptyInstance: create)
    ..pPS(1, _omitFieldNames ? '' : 'errors')
    ..p<$fixnum.Int64>(
        2, _omitFieldNames ? '' : 'processed', $pb.PbFieldType.K6)
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  UpdateSensorsResponse clone() => deepCopy();
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  UpdateSensorsResponse copyWith(
          void Function(UpdateSensorsResponse) updates) =>
      super.copyWith((message) => updates(message as UpdateSensorsResponse))
          as UpdateSensorsResponse;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static UpdateSensorsResponse create() => UpdateSensorsResponse._();
  @$core.override
  UpdateSensorsResponse createEmptyInstance() => create();
  @$core.pragma('dart2js:noInline')
  static UpdateSensorsResponse getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<UpdateSensorsResponse>(create);
  static UpdateSensorsResponse? _defaultInstance;

  @$pb.TagNumber(1)
  $pb.PbList<$core.String> get errors => $_getList(0);

  @$pb.TagNumber(2)
  $pb.PbList<$fixnum.Int64> get processed => $_getList(1);
}

class UpdateStationRequest extends $pb.GeneratedMessage {
  factory UpdateStationRequest({
    $fixnum.Int64? stationId,
    StationDefinition? definition,
  }) {
    final result = create();
    if (stationId != null) result.stationId = stationId;
    if (definition != null) result.definition = definition;
    return result;
  }

  UpdateStationRequest._();

  factory UpdateStationRequest.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory UpdateStationRequest.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'UpdateStationRequest',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'recorder'),
      createEmptyInstance: create)
    ..aInt64(1, _omitFieldNames ? '' : 'stationId', protoName: 'stationId')
    ..aOM<StationDefinition>(2, _omitFieldNames ? '' : 'definition',
        subBuilder: StationDefinition.create)
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  UpdateStationRequest clone() => deepCopy();
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  UpdateStationRequest copyWith(void Function(UpdateStationRequest) updates) =>
      super.copyWith((message) => updates(message as UpdateStationRequest))
          as UpdateStationRequest;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static UpdateStationRequest create() => UpdateStationRequest._();
  @$core.override
  UpdateStationRequest createEmptyInstance() => create();
  @$core.pragma('dart2js:noInline')
  static UpdateStationRequest getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<UpdateStationRequest>(create);
  static UpdateStationRequest? _defaultInstance;

  @$pb.TagNumber(1)
  $fixnum.Int64 get stationId => $_getI64(0);
  @$pb.TagNumber(1)
  set stationId($fixnum.Int64 value) => $_setInt64(0, value);
  @$pb.TagNumber(1)
  $core.bool hasStationId() => $_has(0);
  @$pb.TagNumber(1)
  void clearStationId() => $_clearField(1);

  @$pb.TagNumber(2)
  StationDefinition get definition => $_getN(1);
  @$pb.TagNumber(2)
  set definition(StationDefinition value) => $_setField(2, value);
  @$pb.TagNumber(2)
  $core.bool hasDefinition() => $_has(1);
  @$pb.TagNumber(2)
  void clearDefinition() => $_clearField(2);
  @$pb.TagNumber(2)
  StationDefinition ensureDefinition() => $_ensure(1);
}

class GetStationDefinitionRequest extends $pb.GeneratedMessage {
  factory GetStationDefinitionRequest() => create();

  GetStationDefinitionRequest._();

  factory GetStationDefinitionRequest.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory GetStationDefinitionRequest.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'GetStationDefinitionRequest',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'recorder'),
      createEmptyInstance: create)
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  GetStationDefinitionRequest clone() => deepCopy();
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  GetStationDefinitionRequest copyWith(
          void Function(GetStationDefinitionRequest) updates) =>
      super.copyWith(
              (message) => updates(message as GetStationDefinitionRequest))
          as GetStationDefinitionRequest;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static GetStationDefinitionRequest create() =>
      GetStationDefinitionRequest._();
  @$core.override
  GetStationDefinitionRequest createEmptyInstance() => create();
  @$core.pragma('dart2js:noInline')
  static GetStationDefinitionRequest getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<GetStationDefinitionRequest>(create);
  static GetStationDefinitionRequest? _defaultInstance;
}

class StationDefinition extends $pb.GeneratedMessage {
  factory StationDefinition({
    $core.String? name,
    $core.Iterable<SensorDefinition>? sensors,
    $core.double? longitude,
    $core.double? latitude,
    $core.int? version,
  }) {
    final result = create();
    if (name != null) result.name = name;
    if (sensors != null) result.sensors.addAll(sensors);
    if (longitude != null) result.longitude = longitude;
    if (latitude != null) result.latitude = latitude;
    if (version != null) result.version = version;
    return result;
  }

  StationDefinition._();

  factory StationDefinition.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory StationDefinition.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'StationDefinition',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'recorder'),
      createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'name')
    ..pPM<SensorDefinition>(2, _omitFieldNames ? '' : 'sensors',
        subBuilder: SensorDefinition.create)
    ..aD(3, _omitFieldNames ? '' : 'longitude')
    ..aD(4, _omitFieldNames ? '' : 'latitude')
    ..aI(5, _omitFieldNames ? '' : 'version')
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  StationDefinition clone() => deepCopy();
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  StationDefinition copyWith(void Function(StationDefinition) updates) =>
      super.copyWith((message) => updates(message as StationDefinition))
          as StationDefinition;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static StationDefinition create() => StationDefinition._();
  @$core.override
  StationDefinition createEmptyInstance() => create();
  @$core.pragma('dart2js:noInline')
  static StationDefinition getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<StationDefinition>(create);
  static StationDefinition? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get name => $_getSZ(0);
  @$pb.TagNumber(1)
  set name($core.String value) => $_setString(0, value);
  @$pb.TagNumber(1)
  $core.bool hasName() => $_has(0);
  @$pb.TagNumber(1)
  void clearName() => $_clearField(1);

  @$pb.TagNumber(2)
  $pb.PbList<SensorDefinition> get sensors => $_getList(1);

  @$pb.TagNumber(3)
  $core.double get longitude => $_getN(2);
  @$pb.TagNumber(3)
  set longitude($core.double value) => $_setDouble(2, value);
  @$pb.TagNumber(3)
  $core.bool hasLongitude() => $_has(2);
  @$pb.TagNumber(3)
  void clearLongitude() => $_clearField(3);

  @$pb.TagNumber(4)
  $core.double get latitude => $_getN(3);
  @$pb.TagNumber(4)
  set latitude($core.double value) => $_setDouble(3, value);
  @$pb.TagNumber(4)
  $core.bool hasLatitude() => $_has(3);
  @$pb.TagNumber(4)
  void clearLatitude() => $_clearField(4);

  @$pb.TagNumber(5)
  $core.int get version => $_getIZ(4);
  @$pb.TagNumber(5)
  set version($core.int value) => $_setSignedInt32(4, value);
  @$pb.TagNumber(5)
  $core.bool hasVersion() => $_has(4);
  @$pb.TagNumber(5)
  void clearVersion() => $_clearField(5);
}

class SensorDefinition extends $pb.GeneratedMessage {
  factory SensorDefinition({
    $core.String? name,
    $core.String? element,
    $fixnum.Int64? recordIntervalSeconds,
    $fixnum.Int64? historyIntervalSeconds,
  }) {
    final result = create();
    if (name != null) result.name = name;
    if (element != null) result.element = element;
    if (recordIntervalSeconds != null)
      result.recordIntervalSeconds = recordIntervalSeconds;
    if (historyIntervalSeconds != null)
      result.historyIntervalSeconds = historyIntervalSeconds;
    return result;
  }

  SensorDefinition._();

  factory SensorDefinition.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory SensorDefinition.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'SensorDefinition',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'recorder'),
      createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'name')
    ..aOS(2, _omitFieldNames ? '' : 'element')
    ..aInt64(3, _omitFieldNames ? '' : 'recordIntervalSeconds',
        protoName: 'recordIntervalSeconds')
    ..aInt64(4, _omitFieldNames ? '' : 'historyIntervalSeconds',
        protoName: 'historyIntervalSeconds')
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  SensorDefinition clone() => deepCopy();
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  SensorDefinition copyWith(void Function(SensorDefinition) updates) =>
      super.copyWith((message) => updates(message as SensorDefinition))
          as SensorDefinition;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static SensorDefinition create() => SensorDefinition._();
  @$core.override
  SensorDefinition createEmptyInstance() => create();
  @$core.pragma('dart2js:noInline')
  static SensorDefinition getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<SensorDefinition>(create);
  static SensorDefinition? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get name => $_getSZ(0);
  @$pb.TagNumber(1)
  set name($core.String value) => $_setString(0, value);
  @$pb.TagNumber(1)
  $core.bool hasName() => $_has(0);
  @$pb.TagNumber(1)
  void clearName() => $_clearField(1);

  @$pb.TagNumber(2)
  $core.String get element => $_getSZ(1);
  @$pb.TagNumber(2)
  set element($core.String value) => $_setString(1, value);
  @$pb.TagNumber(2)
  $core.bool hasElement() => $_has(1);
  @$pb.TagNumber(2)
  void clearElement() => $_clearField(2);

  @$pb.TagNumber(3)
  $fixnum.Int64 get recordIntervalSeconds => $_getI64(2);
  @$pb.TagNumber(3)
  set recordIntervalSeconds($fixnum.Int64 value) => $_setInt64(2, value);
  @$pb.TagNumber(3)
  $core.bool hasRecordIntervalSeconds() => $_has(2);
  @$pb.TagNumber(3)
  void clearRecordIntervalSeconds() => $_clearField(3);

  @$pb.TagNumber(4)
  $fixnum.Int64 get historyIntervalSeconds => $_getI64(3);
  @$pb.TagNumber(4)
  set historyIntervalSeconds($fixnum.Int64 value) => $_setInt64(3, value);
  @$pb.TagNumber(4)
  $core.bool hasHistoryIntervalSeconds() => $_has(3);
  @$pb.TagNumber(4)
  void clearHistoryIntervalSeconds() => $_clearField(4);
}

class Station extends $pb.GeneratedMessage {
  factory Station({
    $fixnum.Int64? id,
    $core.Iterable<Sensor>? sensors,
    $core.int? version,
  }) {
    final result = create();
    if (id != null) result.id = id;
    if (sensors != null) result.sensors.addAll(sensors);
    if (version != null) result.version = version;
    return result;
  }

  Station._();

  factory Station.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory Station.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'Station',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'recorder'),
      createEmptyInstance: create)
    ..aInt64(1, _omitFieldNames ? '' : 'id')
    ..pPM<Sensor>(2, _omitFieldNames ? '' : 'sensors',
        subBuilder: Sensor.create)
    ..aI(3, _omitFieldNames ? '' : 'version')
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  Station clone() => deepCopy();
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  Station copyWith(void Function(Station) updates) =>
      super.copyWith((message) => updates(message as Station)) as Station;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static Station create() => Station._();
  @$core.override
  Station createEmptyInstance() => create();
  @$core.pragma('dart2js:noInline')
  static Station getDefault() =>
      _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<Station>(create);
  static Station? _defaultInstance;

  @$pb.TagNumber(1)
  $fixnum.Int64 get id => $_getI64(0);
  @$pb.TagNumber(1)
  set id($fixnum.Int64 value) => $_setInt64(0, value);
  @$pb.TagNumber(1)
  $core.bool hasId() => $_has(0);
  @$pb.TagNumber(1)
  void clearId() => $_clearField(1);

  @$pb.TagNumber(2)
  $pb.PbList<Sensor> get sensors => $_getList(1);

  @$pb.TagNumber(3)
  $core.int get version => $_getIZ(2);
  @$pb.TagNumber(3)
  set version($core.int value) => $_setSignedInt32(2, value);
  @$pb.TagNumber(3)
  $core.bool hasVersion() => $_has(2);
  @$pb.TagNumber(3)
  void clearVersion() => $_clearField(3);
}

class Sensor extends $pb.GeneratedMessage {
  factory Sensor({
    $fixnum.Int64? id,
    $core.String? name,
    $fixnum.Int64? recordIntervalSeconds,
    $fixnum.Int64? historyIntervalSeconds,
  }) {
    final result = create();
    if (id != null) result.id = id;
    if (name != null) result.name = name;
    if (recordIntervalSeconds != null)
      result.recordIntervalSeconds = recordIntervalSeconds;
    if (historyIntervalSeconds != null)
      result.historyIntervalSeconds = historyIntervalSeconds;
    return result;
  }

  Sensor._();

  factory Sensor.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory Sensor.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'Sensor',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'recorder'),
      createEmptyInstance: create)
    ..aInt64(1, _omitFieldNames ? '' : 'id')
    ..aOS(2, _omitFieldNames ? '' : 'name')
    ..aInt64(3, _omitFieldNames ? '' : 'recordIntervalSeconds',
        protoName: 'recordIntervalSeconds')
    ..aInt64(4, _omitFieldNames ? '' : 'historyIntervalSeconds',
        protoName: 'historyIntervalSeconds')
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  Sensor clone() => deepCopy();
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  Sensor copyWith(void Function(Sensor) updates) =>
      super.copyWith((message) => updates(message as Sensor)) as Sensor;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static Sensor create() => Sensor._();
  @$core.override
  Sensor createEmptyInstance() => create();
  @$core.pragma('dart2js:noInline')
  static Sensor getDefault() =>
      _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<Sensor>(create);
  static Sensor? _defaultInstance;

  @$pb.TagNumber(1)
  $fixnum.Int64 get id => $_getI64(0);
  @$pb.TagNumber(1)
  set id($fixnum.Int64 value) => $_setInt64(0, value);
  @$pb.TagNumber(1)
  $core.bool hasId() => $_has(0);
  @$pb.TagNumber(1)
  void clearId() => $_clearField(1);

  @$pb.TagNumber(2)
  $core.String get name => $_getSZ(1);
  @$pb.TagNumber(2)
  set name($core.String value) => $_setString(1, value);
  @$pb.TagNumber(2)
  $core.bool hasName() => $_has(1);
  @$pb.TagNumber(2)
  void clearName() => $_clearField(2);

  @$pb.TagNumber(3)
  $fixnum.Int64 get recordIntervalSeconds => $_getI64(2);
  @$pb.TagNumber(3)
  set recordIntervalSeconds($fixnum.Int64 value) => $_setInt64(2, value);
  @$pb.TagNumber(3)
  $core.bool hasRecordIntervalSeconds() => $_has(2);
  @$pb.TagNumber(3)
  void clearRecordIntervalSeconds() => $_clearField(3);

  @$pb.TagNumber(4)
  $fixnum.Int64 get historyIntervalSeconds => $_getI64(3);
  @$pb.TagNumber(4)
  set historyIntervalSeconds($fixnum.Int64 value) => $_setInt64(3, value);
  @$pb.TagNumber(4)
  $core.bool hasHistoryIntervalSeconds() => $_has(3);
  @$pb.TagNumber(4)
  void clearHistoryIntervalSeconds() => $_clearField(4);
}

class GetSensorStateRequest extends $pb.GeneratedMessage {
  factory GetSensorStateRequest({
    $core.String? name,
  }) {
    final result = create();
    if (name != null) result.name = name;
    return result;
  }

  GetSensorStateRequest._();

  factory GetSensorStateRequest.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory GetSensorStateRequest.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'GetSensorStateRequest',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'recorder'),
      createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'name')
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  GetSensorStateRequest clone() => deepCopy();
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  GetSensorStateRequest copyWith(
          void Function(GetSensorStateRequest) updates) =>
      super.copyWith((message) => updates(message as GetSensorStateRequest))
          as GetSensorStateRequest;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static GetSensorStateRequest create() => GetSensorStateRequest._();
  @$core.override
  GetSensorStateRequest createEmptyInstance() => create();
  @$core.pragma('dart2js:noInline')
  static GetSensorStateRequest getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<GetSensorStateRequest>(create);
  static GetSensorStateRequest? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get name => $_getSZ(0);
  @$pb.TagNumber(1)
  set name($core.String value) => $_setString(0, value);
  @$pb.TagNumber(1)
  $core.bool hasName() => $_has(0);
  @$pb.TagNumber(1)
  void clearName() => $_clearField(1);
}

class SensorState extends $pb.GeneratedMessage {
  factory SensorState({
    $core.String? unitId,
    $core.double? value,
    $fixnum.Int64? createdAt,
  }) {
    final result = create();
    if (unitId != null) result.unitId = unitId;
    if (value != null) result.value = value;
    if (createdAt != null) result.createdAt = createdAt;
    return result;
  }

  SensorState._();

  factory SensorState.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory SensorState.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'SensorState',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'recorder'),
      createEmptyInstance: create)
    ..aOS(2, _omitFieldNames ? '' : 'unitId', protoName: 'unitId')
    ..aD(3, _omitFieldNames ? '' : 'value')
    ..aInt64(4, _omitFieldNames ? '' : 'createdAt')
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  SensorState clone() => deepCopy();
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  SensorState copyWith(void Function(SensorState) updates) =>
      super.copyWith((message) => updates(message as SensorState))
          as SensorState;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static SensorState create() => SensorState._();
  @$core.override
  SensorState createEmptyInstance() => create();
  @$core.pragma('dart2js:noInline')
  static SensorState getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<SensorState>(create);
  static SensorState? _defaultInstance;

  @$pb.TagNumber(2)
  $core.String get unitId => $_getSZ(0);
  @$pb.TagNumber(2)
  set unitId($core.String value) => $_setString(0, value);
  @$pb.TagNumber(2)
  $core.bool hasUnitId() => $_has(0);
  @$pb.TagNumber(2)
  void clearUnitId() => $_clearField(2);

  @$pb.TagNumber(3)
  $core.double get value => $_getN(1);
  @$pb.TagNumber(3)
  set value($core.double value) => $_setDouble(1, value);
  @$pb.TagNumber(3)
  $core.bool hasValue() => $_has(1);
  @$pb.TagNumber(3)
  void clearValue() => $_clearField(3);

  @$pb.TagNumber(4)
  $fixnum.Int64 get createdAt => $_getI64(2);
  @$pb.TagNumber(4)
  set createdAt($fixnum.Int64 value) => $_setInt64(2, value);
  @$pb.TagNumber(4)
  $core.bool hasCreatedAt() => $_has(2);
  @$pb.TagNumber(4)
  void clearCreatedAt() => $_clearField(4);
}

const $core.bool _omitFieldNames =
    $core.bool.fromEnvironment('protobuf.omit_field_names');
const $core.bool _omitMessageNames =
    $core.bool.fromEnvironment('protobuf.omit_message_names');
