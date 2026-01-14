import 'package:json_annotation/json_annotation.dart';

import '../units/convertible.dart';

part 'sensor_state.g.dart';

@JsonSerializable()
class SensorState {
  final Convertible value;

  @DateTimeEpochConverter()
  final DateTime createdAt;

  @DurationConverter()
  final Duration? interval;

  const SensorState({
    required this.value,
    required this.createdAt,
    required this.interval,
  });

  @override
  String toString() {
    return "${value.format()} (from: $createdAt, interval: ${interval.toString()})";
  }

  factory SensorState.fromJson(Map<String, dynamic> json) =>
      _$SensorStateFromJson(json);

  Map<String, dynamic> toJson() => _$SensorStateToJson(this);
}

class DateTimeEpochConverter implements JsonConverter<DateTime, String> {
  const DateTimeEpochConverter();

  @override
  DateTime fromJson(String json) => DateTime.parse(json);

  @override
  String toJson(DateTime object) => object.toIso8601String();
}

class DurationConverter implements JsonConverter<Duration, int> {
  const DurationConverter();

  @override
  Duration fromJson(int json) => Duration(milliseconds: json);

  @override
  int toJson(Duration object) => object.inMilliseconds;
}
