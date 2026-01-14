import 'dart:math';

import 'package:shared/units/convert.dart';

class WindSpeed {
  static final kmh = Unit.usingRatioAndOffset(
    "kmh",
    1 / 3.6,
    0,
    "km/h",
    " kilometer per hour",
    " kilometers per hour",
  );

  static final ms = Unit.usingRatioAndOffset(
    "ms",
    1,
    0,
    "m/s",
    " meter per second",
    " meters per second",
  );

  static final bft = Unit(
    "bft",
    (valueInBft) {
      if (valueInBft < 0) {
        return 0.0;
      }
      return 0.836 * pow(valueInBft, 1.5);
    },
    (valueInMs) {
      return pow(valueInMs / 0.836, 2 / 3).toDouble();
    },
    "Bft",
    " Beaufort",
    " Beaufort",
  );

  static final mph = Unit.usingRatioAndOffset(
    "mph",
    0.44704,
    0,
    "mi/h",
    " mile per hour",
    " miles per hour",
  );

  static final kn = Unit.usingRatioAndOffset(
    "kn",
    1852 / 3600,
    0,
    "kn",
    " knot",
    " knots",
  );
}
