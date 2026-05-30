import 'dart:async';
import 'dart:io';
import 'package:args/command_runner.dart';
import 'dart:ffi';

import 'package:chalkdart/chalkdart.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:interact/interact.dart';
import 'package:path/path.dart';
import 'package:shared/one_line_output.dart';
import 'package:shared/utils.dart';

class UpdateCommand extends Command<int> {
  UpdateCommand() {
    argParser.addFlag(
      'prerelease',
      help: 'Allow installing the latest prerelease.',
      negatable: false,
    );
  }

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
      set_line(
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

    set_line("⏳ Downloading updater ($installerName)...");
    final tempDir = Directory.systemTemp.createTempSync('owvi_update_');
    final installerFile = File(join(tempDir.path, installerName));

    try {
      bool usePrerelease = argResults?['prerelease'] == true;
      String apiUrl = usePrerelease
          ? 'https://api.github.com/repos/open-weather-vision/owvision/releases'
          : 'https://api.github.com/repos/open-weather-vision/owvision/releases/latest';

      final metaRes = await http.get(
        Uri.parse(apiUrl),
        headers: {'User-Agent': 'owvision-updater'},
      );
      if (metaRes.statusCode != 200) {
        set_line(
          chalk.red(
            "⚠️  Failed to fetch release info. HTTP ${metaRes.statusCode}",
          ),
        );
        exit(1);
      }

      final decoded = jsonDecode(metaRes.body);
      final Map<String, dynamic> releaseData = (decoded is List)
          ? decoded.first
          : decoded;
      final String releaseTag = releaseData['tag_name'].toString();

      final res = await http.get(
        Uri.parse(
          'https://github.com/open-weather-vision/owvision/releases/download/$releaseTag/$installerName',
        ),
      );

      if (res.statusCode != 200 && res.statusCode != 302) {
        set_line(
          chalk.red("⚠️  Failed to download updater. HTTP ${res.statusCode}"),
        );
        exit(1);
      }
      await installerFile.writeAsBytes(res.bodyBytes);
      set_line("✅ Downloaded updater!");

      if (!Platform.isWindows) {
        await runShellCommand(
          "chmod",
          ["+x", installerFile.path],
          onCommandFail: FailAction.throwException,
          forwardOutput: false,
        );
      }

      set_line("🚀 Starting updater...\n");
      final List<String> args = [];
      if (argResults?['prerelease'] == true) {
        args.add('--prerelease');
      }

      await runShellCommand(
        installerFile.path,
        args,
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
