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
    return LiveBaseComponent(
      [
        Positioned.fill(
          top: 40,
          child: SvgPicture.asset('assets/svgs/water2.svg', fit: BoxFit.fill),
        ),
        Positioned(
          top: 50,
          right: 35,
          child: Row(
            textBaseline: TextBaseline.ideographic,
            crossAxisAlignment: CrossAxisAlignment.baseline,
            children: [
              Text(
                _precipationAcc?.state?.value.value.toString() ?? "",
                style: TextStyle(
                  fontSize: 55,
                  fontWeight: FontWeight.w600,
                  color: Colors.white,
                ),
              ),
              SizedBox(width: 5),
              Text(
                _precipationAcc?.state?.value.unit.shortName ?? "",
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
      label:
          "Precipation${formatDurationSimple(_precipationInterval ?? Duration(minutes: 15))}", // TODO: Remove fallback
      padding: EdgeInsets.all(0),
      borderWidth: 0,
      color: Color.fromARGB(255, 77, 175, 255),
      labelColor: Color.fromARGB(150, 0, 0, 0),
      labelIcon: Icon(Icons.water_drop_sharp, size: 14),
    );
  }
}
