//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:copy_with_extension/copy_with_extension.dart';
import 'package:json_annotation/json_annotation.dart';

part 'history_record.g.dart';


@CopyWith()
@JsonSerializable(
  checked: true,
  createToJson: true,
  disallowUnrecognizedKeys: false,
  explicitToJson: true,
)
class HistoryRecord {
  /// Returns a new [HistoryRecord] instance.
  HistoryRecord({

     this.value,

    required  this.createdAt,
  });

  @JsonKey(
    
    name: r'value',
    required: false,
    includeIfNull: false,
  )


  final double? value;



  @JsonKey(
    
    name: r'createdAt',
    required: true,
    includeIfNull: false,
  )


  final DateTime createdAt;





    @override
    bool operator ==(Object other) => identical(this, other) || other is HistoryRecord &&
      other.value == value &&
      other.createdAt == createdAt;

    @override
    int get hashCode =>
        value.hashCode +
        createdAt.hashCode;

  factory HistoryRecord.fromJson(Map<String, dynamic> json) => _$HistoryRecordFromJson(json);

  Map<String, dynamic> toJson() => _$HistoryRecordToJson(this);

  @override
  String toString() {
    return toJson().toString();
  }

}

