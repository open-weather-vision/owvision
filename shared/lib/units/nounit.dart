import 'package:shared/units/convert.dart';

class NoUnit {
  static final groupName = "just";

  static final none = Unit.usingRatioAndOffset(
    "none",
    1.0,
    0,
    "",
    "",
    "",
    group: NoUnit.groupName,
  );
}
