//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:copy_with_extension/copy_with_extension.dart';
import 'package:json_annotation/json_annotation.dart';

part 'weather_station.g.dart';


@CopyWith()
@JsonSerializable(
  checked: true,
  createToJson: true,
  disallowUnrecognizedKeys: false,
  explicitToJson: true,
)
class WeatherStation {
  /// Returns a new [WeatherStation] instance.
  WeatherStation({

    required  this.id,

    required  this.name,

    required  this.longitude,

    required  this.latitude,

    required  this.createdAt,
  });

  @JsonKey(
    
    name: r'id',
    required: true,
    includeIfNull: false,
  )


  final int id;



  @JsonKey(
    
    name: r'name',
    required: true,
    includeIfNull: false,
  )


  final String name;



  @JsonKey(
    
    name: r'longitude',
    required: true,
    includeIfNull: false,
  )


  final double longitude;



  @JsonKey(
    
    name: r'latitude',
    required: true,
    includeIfNull: false,
  )


  final double latitude;



  @JsonKey(
    
    name: r'createdAt',
    required: true,
    includeIfNull: false,
  )


  final String createdAt;





    @override
    bool operator ==(Object other) => identical(this, other) || other is WeatherStation &&
      other.id == id &&
      other.name == name &&
      other.longitude == longitude &&
      other.latitude == latitude &&
      other.createdAt == createdAt;

    @override
    int get hashCode =>
        id.hashCode +
        name.hashCode +
        longitude.hashCode +
        latitude.hashCode +
        createdAt.hashCode;

  factory WeatherStation.fromJson(Map<String, dynamic> json) => _$WeatherStationFromJson(json);

  Map<String, dynamic> toJson() => _$WeatherStationToJson(this);

  @override
  String toString() {
    return toJson().toString();
  }

}

