import 'dart:ffi';
import 'dart:io';

import 'package:sqlite3/open.dart';

void fixLibsqlite() {
  if (Platform.isLinux) {
    open.overrideFor(OperatingSystem.linux, () {
      const basePaths = [
        null,
        "/usr/lib/arm-linux-gnueabihf",
        "/usr/lib/x86_64-linux-gnu",
        "/usr/lib/aarch64-linux-gnu",
        "/usr/lib/arm-linux-gnueabihf",
        "/lib/aarch64-linux-gnu",
        "/lib/x86_64-linux-gnu",
        "/usr/lib64/",
        "/usr/lib/",
        "/usr/local/lib/",
      ];
      const names = ["libsqlite3.so.0", "libsqlite3.so"];
      for (final basePath in basePaths) {
        for (final name in names) {
          try {
            return DynamicLibrary.open(
              basePath == null ? name : "$basePath/$name",
            );
          } catch (_) {}
        }
      }
      throw Exception('Failed to find dynamic sqlite3 library!');
    });
  }
}
