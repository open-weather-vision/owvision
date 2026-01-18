import 'package:daemon/models/history_record.dart';
import 'package:json_annotation/json_annotation.dart';

part "sensor_history.g.dart";

@JsonSerializable()
class SensorHistory {
  final String sensorName;
  final String unitId;
  final List<HistoryRecord> history;

  const SensorHistory(this.sensorName, this.unitId, this.history);

  factory SensorHistory.fromJson(Map<String, dynamic> json) =>
      _$SensorHistoryFromJson(json);

  Map<String, dynamic> toJson() => _$SensorHistoryToJson(this);
}
