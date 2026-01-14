import 'package:shared/units/convert.dart';

class Pressure {
  static final hpa = Unit.usingRatioAndOffset(
    "hpa",
    1,
    0,
    "hPa",
    " Hectopascal",
    " Hectopascals",
  );

  static final inhg = Unit.usingRatioAndOffset(
    "inhg",
    33.86389,
    0,
    "inHg",
    " Inch of Mercury",
    " Inches of Mercury",
  );
}
