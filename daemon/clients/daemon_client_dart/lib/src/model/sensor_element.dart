//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:json_annotation/json_annotation.dart';


enum SensorElement {
      @JsonValue(r'precipitationAccumulated')
      precipitationAccumulated(r'precipitationAccumulated'),
      @JsonValue(r'precipitationRate')
      precipitationRate(r'precipitationRate'),
      @JsonValue(r'snowHeight')
      snowHeight(r'snowHeight'),
      @JsonValue(r'pressure')
      pressure(r'pressure'),
      @JsonValue(r'temperature')
      temperature(r'temperature'),
      @JsonValue(r'windSpeed')
      windSpeed(r'windSpeed'),
      @JsonValue(r'windDirection')
      windDirection(r'windDirection'),
      @JsonValue(r'humidity')
      humidity(r'humidity'),
      @JsonValue(r'weatherCode')
      weatherCode(r'weatherCode'),
      @JsonValue(r'dewPoint')
      dewPoint(r'dewPoint'),
      @JsonValue(r'windChill')
      windChill(r'windChill');

  const SensorElement(this.value);

  final String value;

  @override
  String toString() => value;
}
