import 'package:shared/units/convert.dart';

class Humidity {
  static final percent = Unit.usingRatioAndOffset(
    "hum_percent",
    1,
    0,
    "%",
    " percent",
    " percent",
  );
}
