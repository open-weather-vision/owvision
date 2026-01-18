import 'package:json_annotation/json_annotation.dart';

part 'station_info.g.dart';

@JsonSerializable()
class StationInfo {
  final int id;
  final String name;
  final double longitude;
  final double latitude;
  final DateTime createdAt;
  final int version;

  StationInfo({
    required this.id,
    required this.name,
    required this.longitude,
    required this.latitude,
    required this.createdAt,
    required this.version,
  });

  factory StationInfo.create({
    required String name,
    required double longitude,
    required double latitude,
    required int version,
  }) {
    return StationInfo(
      id: -1,
      name: name,
      longitude: longitude,
      latitude: latitude,
      createdAt: DateTime.now(),
      version: version,
    );
  }

  @override
  String toString() {
    return "(id=$id, name=$name, longitude=$longitude, latitude=$latitude, createdAt=$createdAt)";
  }

  // Factory-Konstruktor für JSON -> Objekt
  factory StationInfo.fromJson(Map<String, dynamic> json) =>
      _$StationInfoFromJson(json);

  // Methode für Objekt -> JSON
  Map<String, dynamic> toJson() => _$StationInfoToJson(this);
}
