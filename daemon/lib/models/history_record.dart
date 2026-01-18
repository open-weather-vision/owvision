import 'package:json_annotation/json_annotation.dart';

part 'history_record.g.dart';

@JsonSerializable()
class HistoryRecord {
  final int sensorId;

  final double? value;

  @DateTimeEpochConverter()
  final DateTime createdAt;

  const HistoryRecord({
    required this.value,
    required this.createdAt,
    required this.sensorId,
  });

  @override
  String toString() {
    return "$value (from: $createdAt)";
  }

  factory HistoryRecord.fromJson(Map<String, dynamic> json) =>
      _$HistoryRecordFromJson(json);

  Map<String, dynamic> toJson() => _$HistoryRecordToJson(this);
}

class DateTimeEpochConverter implements JsonConverter<DateTime, String> {
  const DateTimeEpochConverter();

  @override
  DateTime fromJson(String json) => DateTime.parse(json);

  @override
  String toJson(DateTime object) => object.toIso8601String();
}
