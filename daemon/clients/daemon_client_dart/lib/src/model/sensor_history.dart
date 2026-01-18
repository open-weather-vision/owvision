//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:owvision_daemon_client_dart/src/model/history_record.dart';
import 'package:copy_with_extension/copy_with_extension.dart';
import 'package:json_annotation/json_annotation.dart';

part 'sensor_history.g.dart';


@CopyWith()
@JsonSerializable(
  checked: true,
  createToJson: true,
  disallowUnrecognizedKeys: false,
  explicitToJson: true,
)
class SensorHistory {
  /// Returns a new [SensorHistory] instance.
  SensorHistory({

    required  this.sensorName,

    required  this.unitId,

    required  this.history,
  });

  @JsonKey(
    
    name: r'sensorName',
    required: true,
    includeIfNull: false,
  )


  final String sensorName;



  @JsonKey(
    
    name: r'unitId',
    required: true,
    includeIfNull: false,
  )


  final String unitId;



  @JsonKey(
    
    name: r'history',
    required: true,
    includeIfNull: false,
  )


  final List<HistoryRecord> history;





    @override
    bool operator ==(Object other) => identical(this, other) || other is SensorHistory &&
      other.sensorName == sensorName &&
      other.unitId == unitId &&
      other.history == history;

    @override
    int get hashCode =>
        sensorName.hashCode +
        unitId.hashCode +
        history.hashCode;

  factory SensorHistory.fromJson(Map<String, dynamic> json) => _$SensorHistoryFromJson(json);

  Map<String, dynamic> toJson() => _$SensorHistoryToJson(this);

  @override
  String toString() {
    return toJson().toString();
  }

}

