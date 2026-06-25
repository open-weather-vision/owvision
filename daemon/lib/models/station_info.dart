import 'package:json_annotation/json_annotation.dart';

part 'station_info.g.dart';

@JsonSerializable()
class StationInfo {
  final String uuid;
  final String? name;
  final double? longitude;
  final double? latitude;
  final String interfaceName;
  final DateTime createdAt;
  final bool configured;

  StationInfo({
    required this.uuid,
    required this.name,
    required this.longitude,
    required this.latitude,
    required this.createdAt,
    required this.configured,
    required this.interfaceName,
  });

  factory StationInfo.createConfigured({
    required String id,
    required String name,
    required double longitude,
    required double latitude,
    required String interfaceName,
  }) {
    return StationInfo(
      uuid: id,
      name: name,
      longitude: longitude,
      latitude: latitude,
      createdAt: DateTime.now(),
      configured: true,
      interfaceName: interfaceName,
    );
  }

  factory StationInfo.createUnconfigured({
    required String id,
    required String interfaceName,
  }) {
    return StationInfo(
      uuid: id,
      name: null,
      longitude: null,
      latitude: null,
      interfaceName: interfaceName,
      createdAt: DateTime.now(),
      configured: false,
    );
  }

  @override
  String toString() {
    return "(id=$uuid, name=$name, longitude=$longitude, latitude=$latitude, interfaceName=$interfaceName, createdAt=$createdAt, configured=$configured)";
  }

  // Factory-Konstruktor für JSON -> Objekt
  factory StationInfo.fromJson(Map<String, dynamic> json) =>
      _$StationInfoFromJson(json);

  // Methode für Objekt -> JSON
  Map<String, dynamic> toJson() => _$StationInfoToJson(this);
}
