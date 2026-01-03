// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'recorder_config.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

RecorderConfig _$RecorderConfigFromJson(Map<String, dynamic> json) =>
    RecorderConfig(
      interfaceGrpcHost: json['interfaceGrpcHost'] as String,
      interfaceGrpcPort: (json['interfaceGrpcPort'] as num).toInt(),
      daemonGrpcHost: json['daemonGrpcHost'] as String,
      daemonGrpcPort: (json['daemonGrpcPort'] as num).toInt(),
      daemonGrpcToken: json['daemonGrpcToken'] as String,
      trustSelfSignedCertificate: json['allowSelfSignedCertificate'] as bool,
      active: json['active'] as bool,
      stationId: (json['stationId'] as num?)?.toInt(),
    );

Map<String, dynamic> _$RecorderConfigToJson(RecorderConfig instance) =>
    <String, dynamic>{
      'interfaceGrpcPort': instance.interfaceGrpcPort,
      'interfaceGrpcHost': instance.interfaceGrpcHost,
      'daemonGrpcPort': instance.daemonGrpcPort,
      'daemonGrpcHost': instance.daemonGrpcHost,
      'daemonGrpcToken': instance.daemonGrpcToken,
      'allowSelfSignedCertificate': instance.trustSelfSignedCertificate,
      'stationId': ?instance.stationId,
      'active': instance.active,
    };
