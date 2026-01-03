import 'package:json_annotation/json_annotation.dart';

part 'station.g.dart';

@JsonSerializable()
class Station {
  final int id;
  final String name;
  final double longitude;
  final double latitude;
  final DateTime createdAt;

  Station({
    required this.id,
    required this.name,
    required this.longitude,
    required this.latitude,
    required this.createdAt,
  });

  factory Station.create({
    required String name,
    required double longitude,
    required double latitude,
  }) {
    return Station(
      id: -1,
      name: name,
      longitude: longitude,
      latitude: latitude,
      createdAt: DateTime.now(),
    );
  }

  @override
  String toString() {
    return "(id=$id, name=$name, longitude=$longitude, latitude=$latitude, createdAt=$createdAt)";
  }

  // Factory-Konstruktor für JSON -> Objekt
  factory Station.fromJson(Map<String, dynamic> json) =>
      _$StationFromJson(json);

  // Methode für Objekt -> JSON
  Map<String, dynamic> toJson() => _$StationToJson(this);
}
