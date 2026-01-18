import 'package:dashboard/base_components/simple_live_component.dart';
import 'package:dashboard/features/live/live_view.dart';
import 'package:flutter/material.dart';
import 'package:shared/units/pressure.dart';

Color pressureColor(double? value) {
  if (value == null) {
    return Color.fromARGB(255, 90, 90, 90);
  } else {
    if (value < 1013.25) {
      return Color.fromARGB(255, 61, 108, 179);
    } else {
      return Color.fromARGB(255, 179, 79, 61);
    }
  }
}

class PressureComponent extends StatelessWidget {
  final SensorAndState? _pressure;

  const PressureComponent(this._pressure, {super.key});

  @override
  Widget build(BuildContext context) {
    return SimpleLiveComponent(
      _pressure,
      pressureColor(_pressure?.state?.value?.to(Pressure.hpa).value),
    );
  }
}
