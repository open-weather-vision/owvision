//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:copy_with_extension/copy_with_extension.dart';
import 'package:json_annotation/json_annotation.dart';

part 'station.g.dart';


@CopyWith()
@JsonSerializable(
  checked: true,
  createToJson: true,
  disallowUnrecognizedKeys: false,
  explicitToJson: true,
)
class Station {
  /// Returns a new [Station] instance.
  Station({

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
    bool operator ==(Object other) => identical(this, other) || other is Station &&
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

  factory Station.fromJson(Map<String, dynamic> json) => _$StationFromJson(json);

  Map<String, dynamic> toJson() => _$StationToJson(this);

  @override
  String toString() {
    return toJson().toString();
  }

}

