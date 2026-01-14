// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'recorder_status.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

RecorderStatus _$RecorderStatusFromJson(Map<String, dynamic> json) =>
    RecorderStatus(
      daemonConnected: json['daemonConnected'] as bool,
      stationConnected: json['stationConnected'] as bool,
      latestStationConnection: json['latestStationConnection'] == null
          ? null
          : DateTime.parse(json['latestStationConnection'] as String),
      latestDaemonConnection: json['latestDaemonConnection'] == null
          ? null
          : DateTime.parse(json['latestDaemonConnection'] as String),
    );

Map<String, dynamic> _$RecorderStatusToJson(
  RecorderStatus instance,
) => <String, dynamic>{
  'daemonConnected': instance.daemonConnected,
  'stationConnected': instance.stationConnected,
  'latestDaemonConnection': instance.latestDaemonConnection?.toIso8601String(),
  'latestStationConnection': instance.latestStationConnection
      ?.toIso8601String(),
};
