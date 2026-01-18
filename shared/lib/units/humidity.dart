import 'package:shared/units/convert.dart';

class Humidity {
  static final groupName = "humidity";

  static final percent = Unit.usingRatioAndOffset(
    "hum_percent",
    1,
    0,
    "%",
    " percent",
    " percent",
    group: Humidity.groupName,
  );

  static List<Unit> units() {
    return [percent];
  }
}
