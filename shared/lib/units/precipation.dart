import 'package:shared/units/convert.dart';

class Precipitation {
  static final mm = Unit.usingRatioAndOffset(
    "mm",
    1.0,
    0,
    "mm",
    " Millimeter",
    " Millimeters",
  );

  static final inch = Unit.usingRatioAndOffset(
    "inch",
    25.4,
    0,
    "in",
    " Inch",
    " Inches",
  );

  static final lpm2 = Unit.usingRatioAndOffset(
    "lpm2",
    1.0,
    0,
    "l/m²",
    " Liter per square meter",
    " Liters per square meter",
  );

  static List<Unit> units() {
    return [inch, lpm2, mm];
  }
}
