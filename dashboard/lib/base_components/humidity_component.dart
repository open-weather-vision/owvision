import 'package:dashboard/base_components/simple_live_component.dart';
import 'package:dashboard/features/live/live_view.dart';
import 'package:flutter/material.dart';

class HumidityComponent extends StatelessWidget {
  final SensorAndState? _humidity;

  const HumidityComponent(this._humidity, {super.key});

  @override
  Widget build(BuildContext context) {
    return SimpleLiveComponent(
      _humidity,
      "Humidity",
      Colors.blueGrey,
      Icons.water,
    );
  }
}
