import 'dart:math' as math;

import 'package:shared/units/convert.dart';
import 'package:shared/units/convertible.dart'; // Für PI benötigt

class WindDirection {
  static final degrees = Unit.usingRatioAndOffset(
    "degrees",
    1.0,
    0.0,
    "°",
    " Degree",
    " Degrees",
  );

  static final radians = Unit.usingRatioAndOffset(
    "radians",
    180 / math.pi,
    0.0,
    "rad",
    " Radian",
    " Radians",
  );

  static String toWindCategory({required Convertible value}) {
    double degrees = value.to(WindDirection.degrees).value;

    degrees = degrees % 360;
    if (degrees < 0) degrees += 360;

    const directions = [
      "N",
      "NNE",
      "NE",
      "ENE",
      "E",
      "ESE",
      "SE",
      "SSE",
      "S",
      "SSW",
      "SW",
      "WSW",
      "W",
      "WNW",
      "NW",
      "NNW",
    ];
    int index = (degrees / 22.5).round() % 16;

    return directions[index];
  }
}
