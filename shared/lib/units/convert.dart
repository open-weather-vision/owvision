import 'package:json_annotation/json_annotation.dart';
import "package:shared/units/convertible.dart";
import "package:shared/units/nounit.dart";
import "package:shared/units/precipation.dart";
import "package:shared/units/precipation_rate.dart";
import "package:shared/units/wind_direction.dart";
import "humidity.dart";
import "length.dart";
import "pressure.dart";
import "temperature.dart";
import "wind_speed.dart";

class Unit {
  final double Function(double) toBaseUnit;
  final double Function(double) fromBaseUnit;
  final String id;
  final String shortName;
  final String longNameSg;
  final String longNamePl;
  final String group;

  static final Map<String, Unit> units = _mapUnits([
    ...Humidity.units(),
    ...Length.units(),
    ...PrecipitationRate.units(),
    ...Precipitation.units(),
    ...Pressure.units(),
    ...Temperature.units(),
    ...WindDirection.units(),
    ...WindSpeed.units(),
    NoUnit.none,
  ]);

  static Map<String, Unit> _mapUnits(List<Unit> units) => {
    for (final u in units) u.id: u,
  };

  const Unit(
    this.id,
    this.toBaseUnit,
    this.fromBaseUnit,
    this.shortName,
    this.longNameSg,
    this.longNamePl, {
    required this.group,
  });

  factory Unit.usingRatioAndOffset(
    String id,
    double baseRatio,
    double baseOffset,
    String shortName,
    String longNameSg,
    String longNamePl, {
    required String group,
  }) {
    return Unit(
      id,
      (v) => v * baseRatio + baseOffset,
      (v) => (v - baseOffset) / baseRatio,
      shortName,
      longNameSg,
      longNamePl,
      group: group,
    );
  }

  factory Unit.fromId(String id) {
    if (!units.containsKey(id)) {
      throw Exception("Invalid unit id '$id'!");
    }
    return units[id]!;
  }
}

class UnitJsonConverter implements JsonConverter<Unit, String> {
  const UnitJsonConverter();

  @override
  Unit fromJson(String json) {
    return Unit.fromId(json);
  }

  @override
  String toJson(Unit object) {
    return object.id;
  }
}

enum FormatLength { short, long }

Convertible convert(double value, Unit unit) {
  return Convertible(value, unit);
}
