import 'package:dashboard/base_components/label_component.dart';
import 'package:dashboard/base_components/live_base_component.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:intl/intl.dart';
import 'package:owvision_daemon_client_dart/owvision_daemon_client_dart.dart';
import 'package:shared/models/sensor_state.dart';

import 'package:sunrise_sunset_calc/sunrise_sunset_calc.dart';

bool isDaytime(double lat, double lng, DateTime utcTime) {
  var results = getSunriseSunset(lat, lng, Duration(hours: 0), utcTime);

  DateTime sunrise = results.sunrise;
  DateTime sunset = results.sunset;

  return utcTime.isAfter(sunrise) && utcTime.isBefore(sunset);
}

class ConnectedStationComponent extends StatelessWidget {
  final Station? _station;
  final DateTime? latestUpdateTime;
  final SensorState? currentConditions;
  final bool reconnecting;
  late final bool dayTime;

  ConnectedStationComponent(
    this._station, {
    this.currentConditions,
    this.latestUpdateTime,
    required this.reconnecting,
    super.key,
  }) {
    dayTime =
        _station?.latitude != null &&
        _station?.longitude != null &&
        latestUpdateTime != null &&
        isDaytime(_station!.latitude, _station.longitude, latestUpdateTime!);
  }

  @override
  Widget build(BuildContext context) {
    final weatherCode = currentConditions?.value.value.toInt().toString();
    return LiveBaseComponent(
      [
        Positioned(
          top: 0,
          bottom: 0,
          right: 32,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                _station?.name ?? "",
                style: TextStyle(
                  fontSize: 30,
                  fontWeight: FontWeight.w600,
                  color: Colors.white,
                ),
              ),
              Text(
                "${_station?.latitude.toStringAsFixed(2) ?? ""}  ${_station?.longitude.toStringAsFixed(2) ?? ""}",
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.w500),
              ),
              SizedBox(height: 40),
              Row(
                spacing: 5,
                children: [
                  Container(
                    padding: EdgeInsets.symmetric(vertical: 2, horizontal: 7),
                    decoration: BoxDecoration(
                      color: reconnecting
                          ? Color.fromARGB(255, 228, 132, 76)
                          : Color.fromARGB(255, 76, 228, 109),
                      borderRadius: BorderRadius.circular(6),
                      border: null,
                    ),
                    child: Row(
                      spacing: 5,
                      children: [
                        SpinKitDoubleBounce(
                          size: 8,
                          color: reconnecting
                              ? Color.fromARGB(255, 73, 43, 8)
                              : Color.fromARGB(255, 19, 73, 8),
                          duration: Duration(seconds: 4),
                        ),

                        Text(
                          reconnecting ? "Reconnecting..." : "Live",
                          style: TextStyle(
                            color: reconnecting
                                ? Color.fromARGB(255, 73, 43, 8)
                                : Color.fromARGB(255, 19, 73, 8),
                            fontSize: 12,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                  ),
                  LabelComponent(
                    labelText: latestUpdateTime != null
                        ? DateFormat(
                            DateFormat.HOUR24_MINUTE,
                          ).format(latestUpdateTime!)
                        : null,
                    labelWidget: latestUpdateTime == null
                        ? SpinKitThreeBounce(
                            size: 15,
                            color: Colors.white,
                            duration: Duration(seconds: 2),
                          )
                        : null,
                    margin: EdgeInsets.all(0),
                    padding: EdgeInsets.symmetric(vertical: 3, horizontal: 7),
                    labelColor: Color.fromARGB(180, 0, 0, 0),
                  ),
                ],
              ),
            ],
          ),
        ),
        Positioned(
          bottom: 0,
          top: 0,
          left: 30,
          child: weatherCode != null
              ? SvgPicture.asset(
                  "assets/svgs/weather/$weatherCode-${dayTime ? "day" : "night"}.svg",
                  width: 90,
                )
              : Text(""),
        ),
      ],
      connected: true,
      height: 200,
      label: null,
      padding: EdgeInsets.all(0),
      borderWidth: 0,
      color: const Color.fromARGB(255, 52, 53, 53),
      backgroundImage: weatherCode != null
          ? DecorationImage(
              fit: BoxFit.cover,
              opacity: 0.2,
              image: AssetImage(
                "assets/imgs/weather/$weatherCode-${dayTime ? "day" : "night"}.jpg",
              ),
            )
          : null,
    );
  }
}
