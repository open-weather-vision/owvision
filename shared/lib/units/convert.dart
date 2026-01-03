import 'package:json_annotation/json_annotation.dart';
import "package:shared/units/convertible.dart";
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

  static final Map<String, Unit> units = _mapUnits([
    Temperature.fahrenheit,
    Temperature.celsius,
    Temperature.kelvin,
    Humidity.percent,
    Length.cm,
    Length.ft,
    Length.inch,
    Length.m,
    Pressure.hpa,
    Pressure.inhg,
    WindSpeed.bft,
    WindSpeed.kmh,
    WindSpeed.kn,
    WindSpeed.mph,
    WindSpeed.ms,
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
    this.longNamePl,
  );

  factory Unit.usingRatioAndOffset(
    String id,
    double baseRatio,
    double baseOffset,
    String shortName,
    String longNameSg,
    String longNamePl,
  ) {
    return Unit(
      id,
      (v) => v * baseRatio + baseOffset,
      (v) => (v - baseOffset) / baseRatio,
      shortName,
      longNameSg,
      longNamePl,
    );
  }

  factory Unit.fromId(String id) {
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
