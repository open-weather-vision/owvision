import 'dart:developer' as dev;
import 'package:flutter/foundation.dart';

class Log {
  static void warn(String msg) {
    dev.log(msg, level: 900, name: 'WARN ⚠️');
    debugPrint('WARN ⚠️: $msg');
  }

  static void error(String msg) {
    dev.log(msg, level: 1000, name: 'ERR ❌');
    debugPrint('ERR ❌: $msg');
  }

  static void info(String msg) {
    dev.log(msg, level: 500, name: 'INFO ℹ️');
    debugPrint('INFO ℹ️: $msg');
  }
}
