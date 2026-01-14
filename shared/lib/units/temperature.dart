import 'package:shared/units/convert.dart';

class Temperature {
  static final celsius = Unit.usingRatioAndOffset(
    "celsius",
    1,
    273.15,
    "°C",
    "° Celsius",
    "° Celsius",
  );

  static final kelvin = Unit.usingRatioAndOffset(
    "kelvin",
    1,
    0,
    "K",
    " Kelvin",
    " Kelvin",
  );

  static final fahrenheit = Unit(
    "fahrenheit",
    (v) => (v - 32) * (5 / 9) + 273.15,
    (v) => (v - 273.15) * (9 / 5) + 32,
    "°F",
    "° Fahrenheit",
    "° Fahrenheit",
  );
}
