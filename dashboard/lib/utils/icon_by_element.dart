import 'package:flutter/material.dart';
import 'package:material_symbols_icons/symbols.dart';
import 'package:shared/models/sensor.dart';

IconData iconByElement(SensorElement? element) {
  if (element == null) {
    return Symbols.error;
  }
  switch (element) {
    case SensorElement.humidity:
      return Symbols.humidity_percentage;
    case SensorElement.temperature:
      return Icons.thermostat;
    case SensorElement.precipationAccumulated:
      return Icons.water_drop;
    case SensorElement.precipationRate:
      return Symbols.rainy_light;
    case SensorElement.snowHeight:
      return Symbols.ac_unit;
    case SensorElement.pressure:
      return Symbols.compress;
    case SensorElement.windSpeed:
      return Symbols.air;
    case SensorElement.windDirection:
      return Symbols.explore;
    case SensorElement.weatherCode:
      return Symbols.cloud_circle;
  }
}
