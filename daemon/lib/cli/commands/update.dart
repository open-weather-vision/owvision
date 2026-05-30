import 'dart:async';
import 'dart:io';
import 'package:args/command_runner.dart';
import 'dart:ffi';

import 'package:chalkdart/chalkdart.dart';
import 'package:http/http.dart' as http;
import 'package:interact/interact.dart';
import 'package:path/path.dart';
import 'package:shared/utils.dart';

class UpdateCommand extends Command<int> {
  @override
  String get description => "Updates owvi to the latest version.";

  @override
  String get name => "update";

  @override
  FutureOr<int> run() async {
    String arch = Abi.current()
        .toString()
        .replaceFirst("windows", "win")
        .replaceFirst("linux", "lin")
        .replaceFirst("_", "");
    const supportedArchitectures = ["winx64", "linx64", "linarm", "linarm64"];
    if (!supportedArchitectures.contains(arch)) {
      print(
        chalk.red("Couldn't automatically infer your system's architecture."),
      );
      arch =
          supportedArchitectures[Select(
            prompt: "Please select your system's arch",
            options: supportedArchitectures,
          ).interact()];
    }
    String ext = Platform.isWindows ? ".exe" : "";
    String installerName = 'owvi_installer_$arch$ext';

    print("⏳ Downloading updater ($installerName)...");
    final tempDir = Directory.systemTemp.createTempSync('owvi_update_');
    final installerFile = File(join(tempDir.path, installerName));

    try {
      final res = await http.get(
        Uri.parse(
          'https://github.com/open-weather-vision/owvision/releases/latest/download/$installerName',
        ),
      );

      if (res.statusCode != 200 && res.statusCode != 302) {
        print(
          chalk.red("⚠️  Failed to download updater. HTTP ${res.statusCode}"),
        );
        exit(1);
      }
      await installerFile.writeAsBytes(res.bodyBytes);
      print("✅ Downloaded updater!");

      if (!Platform.isWindows) {
        await runShellCommand("chmod", [
          "+x",
          installerFile.path,
        ], onCommandFail: FailAction.throwException);
      }

      print("🚀 Starting updater...\n");
      await runShellCommand(
        installerFile.path,
        [],
        interactive: true,
        onCommandFail: FailAction.exit,
      );
    } finally {
      try {
        if (installerFile.existsSync()) installerFile.deleteSync();
        if (tempDir.existsSync()) tempDir.deleteSync();
      } catch (_) {}
    }
    return 0;
  }
}
