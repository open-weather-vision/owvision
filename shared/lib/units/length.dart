import 'package:shared/units/convert.dart';

class Length {
  static final groupName = "length";

  static final m = Unit.usingRatioAndOffset(
    "m",
    1.0,
    0,
    "m",
    " Meter",
    " Meters",
    group: Length.groupName,
  );

  static final cm = Unit.usingRatioAndOffset(
    "cm",
    0.01,
    0,
    "cm",
    " Centimeter",
    " Centimeters",
    group: Length.groupName,
  );

  static final ft = Unit.usingRatioAndOffset(
    "ft",
    0.3048,
    0,
    "ft",
    " Foot",
    " Feet",
    group: Length.groupName,
  );

  static final inch = Unit.usingRatioAndOffset(
    "in",
    0.0254,
    0,
    "in",
    " Inch",
    " Inches",
    group: Length.groupName,
  );

  static List<Unit> units() {
    return [inch, ft, m, cm];
  }
}
