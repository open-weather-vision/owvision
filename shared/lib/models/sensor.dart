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

  @UnitJsonConverter()
  final Unit storageUnit;

  const Sensor({
    required this.id,
    required this.name,
    required this.stationId,
    required this.element,
    required this.storageUnit,
    required this.recordIntervalSeconds,
  });

  factory Sensor.create({
    required String name,
    required SensorElement element,
    required Unit storageUnit,
    required int recordIntervalSeconds,
  }) {
    return Sensor(
      element: element,
      storageUnit: storageUnit,
      name: name,
      id: -1,
      stationId: -1,
      recordIntervalSeconds: recordIntervalSeconds,
    );
  }

  factory Sensor.fromJson(Map<String, dynamic> json) => _$SensorFromJson(json);

  Map<String, dynamic> toJson() => _$SensorToJson(this);
}

enum SensorElement {
  precipationAccumulated(type: ElementType.accumulated),
  precipationRate(type: ElementType.instant),
  snowHeight(type: ElementType.instant),
  pressure(type: ElementType.instant),
  temperature(type: ElementType.instant),
  windSpeed(type: ElementType.instant),
  windDirection(type: ElementType.instant),
  humidity(type: ElementType.instant),
  weatherCode(type: ElementType.instant);

  final ElementType type;

  const SensorElement({required this.type});

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
