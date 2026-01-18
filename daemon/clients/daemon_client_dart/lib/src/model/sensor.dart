//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:owvision_daemon_client_dart/src/model/sensor_element.dart';
import 'package:copy_with_extension/copy_with_extension.dart';
import 'package:json_annotation/json_annotation.dart';

part 'sensor.g.dart';


@CopyWith()
@JsonSerializable(
  checked: true,
  createToJson: true,
  disallowUnrecognizedKeys: false,
  explicitToJson: true,
)
class Sensor {
  /// Returns a new [Sensor] instance.
  Sensor({

    required  this.id,

    required  this.element,

    required  this.name,

    required  this.recordIntervalSeconds,

    required  this.historyIntervalSeconds,
  });

  @JsonKey(
    
    name: r'id',
    required: true,
    includeIfNull: false,
  )


  final int id;



  @JsonKey(
    
    name: r'element',
    required: true,
    includeIfNull: false,
  )


  final SensorElement element;



  @JsonKey(
    
    name: r'name',
    required: true,
    includeIfNull: false,
  )


  final String name;



  @JsonKey(
    
    name: r'recordIntervalSeconds',
    required: true,
    includeIfNull: false,
  )


  final int recordIntervalSeconds;



  @JsonKey(
    
    name: r'historyIntervalSeconds',
    required: true,
    includeIfNull: false,
  )


  final int historyIntervalSeconds;





    @override
    bool operator ==(Object other) => identical(this, other) || other is Sensor &&
      other.id == id &&
      other.element == element &&
      other.name == name &&
      other.recordIntervalSeconds == recordIntervalSeconds &&
      other.historyIntervalSeconds == historyIntervalSeconds;

    @override
    int get hashCode =>
        id.hashCode +
        element.hashCode +
        name.hashCode +
        recordIntervalSeconds.hashCode +
        historyIntervalSeconds.hashCode;

  factory Sensor.fromJson(Map<String, dynamic> json) => _$SensorFromJson(json);

  Map<String, dynamic> toJson() => _$SensorToJson(this);

  @override
  String toString() {
    return toJson().toString();
  }

}

