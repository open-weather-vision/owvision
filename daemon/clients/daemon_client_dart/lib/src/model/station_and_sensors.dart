//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:owvision_daemon_client_dart/src/model/weather_station.dart';
import 'package:owvision_daemon_client_dart/src/model/sensor.dart';
import 'package:copy_with_extension/copy_with_extension.dart';
import 'package:json_annotation/json_annotation.dart';

part 'station_and_sensors.g.dart';


@CopyWith()
@JsonSerializable(
  checked: true,
  createToJson: true,
  disallowUnrecognizedKeys: false,
  explicitToJson: true,
)
class StationAndSensors {
  /// Returns a new [StationAndSensors] instance.
  StationAndSensors({

    required  this.info,

    required  this.sensors,
  });

  @JsonKey(
    
    name: r'info',
    required: true,
    includeIfNull: false,
  )


  final WeatherStation info;



  @JsonKey(
    
    name: r'sensors',
    required: true,
    includeIfNull: false,
  )


  final List<Sensor> sensors;





    @override
    bool operator ==(Object other) => identical(this, other) || other is StationAndSensors &&
      other.info == info &&
      other.sensors == sensors;

    @override
    int get hashCode =>
        info.hashCode +
        sensors.hashCode;

  factory StationAndSensors.fromJson(Map<String, dynamic> json) => _$StationAndSensorsFromJson(json);

  Map<String, dynamic> toJson() => _$StationAndSensorsToJson(this);

  @override
  String toString() {
    return toJson().toString();
  }

}

