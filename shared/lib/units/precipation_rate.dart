import 'package:shared/units/convert.dart';

class PrecipitationRate {
  static final groupName = "prec_rate";

  static final mmph = Unit.usingRatioAndOffset(
    "mmph",
    1.0,
    0,
    "mm/h",
    " Millimeter per hour",
    " Millimeters per hour",
    group: PrecipitationRate.groupName,
  );

  static final inph = Unit.usingRatioAndOffset(
    "inph",
    25.4,
    0,
    "in/h",
    " Inch per hour",
    " Inches per hour",
    group: PrecipitationRate.groupName,
  );

  static List<Unit> units() {
    return [mmph, inph];
  }
}
