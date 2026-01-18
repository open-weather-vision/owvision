import 'package:json_annotation/json_annotation.dart';
import 'package:shared/units/convert.dart';

part 'convertible.g.dart';

@JsonSerializable()
class Convertible {
  @UnitJsonConverter()
  Unit unit;
  double value;

  Convertible(this.value, this.unit);

  Convertible to(Unit newUnit) {
    if (newUnit.group != unit.group) {
      throw Exception(
        "Cannot convert from unit '${unit.shortName}' to '${newUnit.shortName}'!",
      );
    }
    double valueInBaseUnit = unit.toBaseUnit(value);
    value = newUnit.fromBaseUnit(valueInBaseUnit);
    unit = newUnit;
    return this;
  }

  @override
  String toString() {
    return "$value${unit.shortName}";
  }

  String format({
    int precision = 2,
    FormatLength formatLength = FormatLength.short,
  }) {
    String unit;
    if (formatLength == FormatLength.short) {
      unit = this.unit.shortName;
    } else {
      unit = value == 1 ? this.unit.longNameSg : this.unit.longNamePl;
    }
    return "${value.toStringAsFixed(2)}$unit";
  }

  factory Convertible.fromJson(Map<String, dynamic> json) =>
      _$ConvertibleFromJson(json);

  Map<String, dynamic> toJson() => _$ConvertibleToJson(this);
}
