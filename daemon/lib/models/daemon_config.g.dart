// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'daemon_config.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

DaemonConfig _$DaemonConfigFromJson(Map<String, dynamic> json) => DaemonConfig(
  grpcPublicPort: (json['grpcPublicPort'] as num).toInt(),
  grpcLocalPort: (json['grpcLocalPort'] as num).toInt(),
  restApiPublicPort: (json['restApiPublicPort'] as num).toInt(),
  restApiLocalPort: (json['restApiLocalPort'] as num).toInt(),
  production: json['production'] as bool,
  publicHostName: json['publicHostName'] as String,
  version: (json['version'] as num).toInt(),
  initialized: json['initialized'] as bool,
);

Map<String, dynamic> _$DaemonConfigToJson(DaemonConfig instance) =>
    <String, dynamic>{
      'grpcLocalPort': instance.grpcLocalPort,
      'restApiLocalPort': instance.restApiLocalPort,
      'grpcPublicPort': instance.grpcPublicPort,
      'restApiPublicPort': instance.restApiPublicPort,
      'production': instance.production,
      'publicHostName': instance.publicHostName,
      'initialized': instance.initialized,
      'version': instance.version,
    };
