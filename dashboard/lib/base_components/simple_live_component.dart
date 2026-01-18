import 'package:dashboard/base_components/live_base_component.dart';
import 'package:dashboard/features/live/live_view.dart';
import 'package:dashboard/utils/icon_by_element.dart';
import 'package:flutter/material.dart';
import 'package:shared/models/sensor.dart' as shared;

class SimpleLiveComponent extends StatelessWidget {
  final SensorAndState? _sensor;
  final Color color;

  const SimpleLiveComponent(this._sensor, this.color, {super.key});

  @override
  Widget build(BuildContext context) {
    bool lightMode = Theme.of(context).brightness == Brightness.light;

    final rawElement = _sensor?.sensor.element.value;
    final element = rawElement != null
        ? shared.SensorElement.values.byName(rawElement)
        : null;
    return LiveBaseComponent(
      [
        Positioned(
          top: 50,
          right: 35,
          child: Row(
            textBaseline: TextBaseline.ideographic,
            crossAxisAlignment: CrossAxisAlignment.baseline,
            children: [
              if (_sensor?.state != null && _sensor!.state!.value != null)
                Text(
                  _sensor.state!.value!.value.toStringAsFixed(1),
                  style: TextStyle(
                    fontSize: 55,
                    fontWeight: FontWeight.w600,
                    color: Colors.white,
                  ),
                )
              else
                Row(
                  spacing: 20,
                  children: [
                    Icon(
                      Icons.sensors_off,
                      size: 55,
                      color: const Color.fromARGB(255, 229, 147, 147),
                    ),
                  ],
                ),
              SizedBox(width: 5),
              Text(
                _sensor?.state?.value?.unit.shortName ?? "",
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.normal,
                  color: Colors.white,
                ),
              ),
            ],
          ),
        ),
      ],
      connected: _sensor?.state?.value != null,
      height: 145,
      label: element?.label,
      padding: EdgeInsets.all(0),
      color: color,
      labelColor: Color.fromARGB(150, 0, 0, 0),
      labelIcon: Icon(iconByElement(element), size: 14, color: Colors.white),
    );
  }
}
