import 'dart:io';

import 'package:open_meteo/open_meteo.dart';
import 'package:shared/logger/logger.dart';
import 'package:shared/weather_code.dart';

void main(List<String> args) async {
  final _openMeteo = WeatherApi(userAgent: "owvision_recorder");
  logger.info("Requesting current weather from open meteo...");
  final response = await _openMeteo.request(
    locations: {OpenMeteoLocation(latitude: 23, longitude: 11)},
    current: {WeatherCurrent.weather_code},
  );
  final value =
      response.segments[0].currentData[WeatherCurrent.weather_code]!.value;
  print(weatherCodeToString(value));
  exit(0);
}
