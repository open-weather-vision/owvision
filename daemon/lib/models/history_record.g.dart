// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'history_record.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

HistoryRecord _$HistoryRecordFromJson(Map<String, dynamic> json) =>
    HistoryRecord(
      value: (json['value'] as num?)?.toDouble(),
      createdAt: const DateTimeEpochConverter().fromJson(
        json['createdAt'] as String,
      ),
      sensorId: (json['sensorId'] as num).toInt(),
    );

Map<String, dynamic> _$HistoryRecordToJson(HistoryRecord instance) =>
    <String, dynamic>{
      'sensorId': instance.sensorId,
      'value': instance.value,
      'createdAt': const DateTimeEpochConverter().toJson(instance.createdAt),
    };
