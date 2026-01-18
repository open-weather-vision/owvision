import 'package:json_annotation/json_annotation.dart';
import 'package:shared/units/convert.dart';
import 'package:shared/units/humidity.dart';
import 'package:shared/units/length.dart';
import 'package:shared/units/nounit.dart';
import 'package:shared/units/precipation.dart';
import 'package:shared/units/precipation_rate.dart';
import 'package:shared/units/pressure.dart';
import 'package:shared/units/temperature.dart';
import 'package:shared/units/wind_direction.dart';
import 'package:shared/units/wind_speed.dart';

part 'sensor.g.dart';

@JsonSerializable()
class Sensor {
  final int id;
  final int stationId;
  final SensorElement element;
  final String name;
  final int recordIntervalSeconds;
  final int historyIntervalSeconds;

  @UnitJsonConverter()
  final Unit storageUnit;

  const Sensor({
    required this.id,
    required this.name,
    required this.stationId,
    required this.element,
    required this.storageUnit,
    required this.recordIntervalSeconds,
    required this.historyIntervalSeconds,
  });

  factory Sensor.create({
    required String name,
    required SensorElement element,
    required Unit storageUnit,
    required int recordIntervalSeconds,
    required int historyIntervalSeconds,
  }) {
    return Sensor(
      element: element,
      storageUnit: storageUnit,
      name: name,
      id: -1,
      stationId: -1,
      recordIntervalSeconds: recordIntervalSeconds,
      historyIntervalSeconds: historyIntervalSeconds,
    );
  }

  factory Sensor.fromJson(Map<String, dynamic> json) => _$SensorFromJson(json);

  Map<String, dynamic> toJson() => _$SensorToJson(this);
}

// Make sure to update the typespec specification and the the station-interface-ts support package when this changes
enum SensorElement {
  temperature(type: ElementType.instant, label: "Temperature"),
  precipationAccumulated(type: ElementType.accumulated, label: "Precipation"),
  precipationRate(type: ElementType.instant, label: "Precipation rate"),
  pressure(type: ElementType.instant, label: "Pressure"),
  windSpeed(type: ElementType.instant, label: "Wind speed"),
  windDirection(type: ElementType.instant, label: "Wind direction"),
  humidity(type: ElementType.instant, label: "Humidity"),
  snowHeight(type: ElementType.instant, label: "Snow height"),
  weatherCode(type: ElementType.instant, label: "Weather");

  final ElementType type;
  final String label;

  const SensorElement({required this.type, required this.label});

  static Unit defaultUnit({required SensorElement element}) {
    switch (element) {
      case precipationAccumulated:
        return Precipitation.mm;
      case precipationRate:
        return PrecipitationRate.mmph;
      case snowHeight:
        return Length.cm;
      case pressure:
        return Pressure.hpa;
      case temperature:
        return Temperature.celsius;
      case windSpeed:
        return WindSpeed.kmh;
      case windDirection:
        return WindDirection.degrees;
      case humidity:
        return Humidity.percent;
      case weatherCode:
        return NoUnit.none;
    }
  }
}

enum ElementType { instant, accumulated }
