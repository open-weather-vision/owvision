import 'package:shared/units/convert.dart';

class Pressure {
  static final groupName = "pressure";

  static final hpa = Unit.usingRatioAndOffset(
    "hpa",
    1,
    0,
    "hPa",
    " Hectopascal",
    " Hectopascals",
    group: Pressure.groupName,
  );

  static final inhg = Unit.usingRatioAndOffset(
    "inhg",
    33.86389,
    0,
    "inHg",
    " Inch of Mercury",
    " Inches of Mercury",
    group: Pressure.groupName,
  );

  static List<Unit> units() {
    return [hpa, inhg];
  }
}
