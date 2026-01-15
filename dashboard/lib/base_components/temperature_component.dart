import 'dart:ui';

import 'package:dashboard/base_components/live_base_component.dart';
import 'package:dashboard/base_components/simple_live_component.dart';
import 'package:dashboard/features/live/live_view.dart';
import 'package:flutter/material.dart';
import 'package:shared/units/temperature.dart';

Color temperatureColor(double? value) {
  if (value == null) {
    return Color.fromARGB(255, 90, 90, 90);
  } else {
    if (value < -35) {
      return Color.fromARGB(255, 155, 61, 179);
    } else if (value < -30) {
      return Color.fromARGB(255, 145, 40, 194);
    } else if (value < -25) {
      return Color.fromARGB(255, 115, 43, 197);
    } else if (value < -20) {
      return Color.fromARGB(255, 88, 44, 189);
    } else if (value < -15) {
      return Color.fromARGB(255, 52, 62, 199);
    } else if (value < -10) {
      return Color.fromARGB(255, 27, 75, 180);
    } else if (value < -5) {
      return Color.fromARGB(255, 12, 117, 216);
    } else if (value < 0) {
      return Color.fromARGB(255, 19, 147, 179);
    } else if (value < 5) {
      return Color.fromARGB(255, 20, 167, 147);
    } else if (value < 10) {
      return Color.fromARGB(255, 23, 175, 69);
    } else if (value < 15) {
      return Color.fromARGB(255, 57, 150, 34);
    } else if (value < 20) {
      return Color.fromARGB(255, 156, 148, 35);
    } else if (value < 25) {
      return Color.fromARGB(255, 216, 128, 12);
    } else if (value < 30) {
      return Color.fromARGB(255, 216, 94, 12);
    } else if (value < 35) {
      return Color.fromARGB(255, 192, 17, 17);
    } else if (value < 40) {
      return Color.fromARGB(255, 216, 12, 56);
    } else if (value < 45) {
      return Color.fromARGB(255, 216, 12, 90);
    } else if (value < 50) {
      return Color.fromARGB(255, 189, 22, 86);
    } else {
      return Color.fromARGB(255, 145, 26, 109);
    }
  }
}

class TemperatureComponent extends StatelessWidget {
  final SensorAndState? _temperature;

  const TemperatureComponent(this._temperature, {super.key});

  @override
  Widget build(BuildContext context) {
    return SimpleLiveComponent(
      _temperature,
      "Temperature",
      temperatureColor(
        _temperature?.state?.value.to(Temperature.celsius).value,
      ),
      Icons.thermostat,
    );
  }
}
