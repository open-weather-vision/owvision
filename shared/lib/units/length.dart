import 'package:shared/units/convert.dart';

class Length {
  static final m = Unit.usingRatioAndOffset(
    "m",
    1.0,
    0,
    "m",
    " Meter",
    " Meters",
  );

  static final cm = Unit.usingRatioAndOffset(
    "cm",
    0.01,
    0,
    "cm",
    " Centimeter",
    " Centimeters",
  );

  static final ft = Unit.usingRatioAndOffset(
    "ft",
    0.3048,
    0,
    "ft",
    " Foot",
    " Feet",
  );

  static final inch = Unit.usingRatioAndOffset(
    "in",
    0.0254,
    0,
    "in",
    " Inch",
    " Inches",
  );
}
