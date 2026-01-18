import 'dart:developer' as dev;

class Log {
  static void warn(String msg) => dev.log(msg, level: 900, name: 'WARN ⚠️');
  static void error(String msg) => dev.log(msg, level: 1000, name: 'ERR ❌');
  static void info(String msg) => dev.log(msg, level: 500, name: 'INFO ℹ️');
}
