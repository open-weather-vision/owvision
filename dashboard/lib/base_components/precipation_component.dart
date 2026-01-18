import 'package:dashboard/base_components/live_base_component.dart';
import 'package:dashboard/features/live/live_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:shared/format_duration.dart';

class PrecipationComponent extends StatelessWidget {
  final SensorAndState? _precipationRate;
  final SensorAndState? _precipationAcc;
  late final Duration? _precipationInterval;

  PrecipationComponent(
    this._precipationAcc,
    this._precipationRate, {
    super.key,
  }) {
    if (_precipationAcc != null && _precipationAcc.state != null) {
      _precipationInterval = _precipationAcc.state?.interval;
    } else {
      _precipationInterval = null;
    }
  }

  @override
  Widget build(BuildContext context) {
    final lightMode = Theme.of(context).brightness == Brightness.light;
    return LiveBaseComponent(
      [
        Positioned.fill(
          top: 40,
          child: Container(
            clipBehavior: Clip.hardEdge,
            decoration: BoxDecoration(borderRadius: BorderRadius.circular(10)),
            child: SvgPicture.asset(
              'assets/svgs/water2.svg',
              fit: BoxFit.fill,
              colorFilter: lightMode
                  ? null
                  : ColorFilter.mode(
                      const Color.fromARGB(255, 31, 68, 99),
                      BlendMode.srcIn,
                    ),
            ),
          ),
        ),
        Positioned(
          top: 50,
          right: 35,
          child: Row(
            textBaseline: TextBaseline.ideographic,
            crossAxisAlignment: CrossAxisAlignment.baseline,
            children: [
              if (_precipationAcc?.state?.value != null)
                Text(
                  _precipationAcc!.state!.value!.value.toStringAsFixed(1),
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
                _precipationAcc?.state?.value?.unit.shortName ?? "",
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
      height: 145,
      connected: _precipationAcc?.state?.value != null,
      borderColor: (Theme.of(context).brightness == Brightness.dark
          ? Colors.white.withAlpha(60)
          : Colors.transparent),
      label:
          "Precipation${_precipationInterval != null ? formatDurationSimple(_precipationInterval) : ""}",
      padding: EdgeInsets.all(0),
      color: Color.fromARGB(255, 77, 175, 255),
      labelColor: Color.fromARGB(150, 0, 0, 0),
      labelIcon: Icon(Icons.water_drop_sharp, size: 14, color: Colors.white),
    );
  }
}
