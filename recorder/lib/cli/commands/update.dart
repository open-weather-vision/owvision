import 'dart:async';
import 'dart:io';
import 'package:args/command_runner.dart';
import 'dart:ffi';

import 'package:chalkdart/chalkdart.dart';
import 'package:http/http.dart' as http;
import 'package:interact/interact.dart';
import 'package:path/path.dart';
import 'package:recorder/cli/entry.dart';
import 'package:shared/pretty_print.dart';
import 'package:shared/service.dart';
import 'package:shared/utils.dart';

class UpdateCommand extends Command<int> {
  @override
  String get description => "Updates owrec to the latest version.";

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
    print("⏳ Downloading latest version ($arch)...");
    final newBinary = File(
      'owrec${Platform.isWindows
          ? ".exe"
          : Platform.isLinux
          ? "_tmp"
          : ""}',
    );

    final res = await http.get(
      Uri.parse(
        'https://github.com/open-weather-vision/owvision/releases/latest/download/owrec_$arch',
      ),
    );
    await newBinary.writeAsBytes(res.bodyBytes);
    print("✅ Downloaded latest binary to ${newBinary.absolute.path}!");
    if (Platform.isLinux) {
      await runShellCommand("sudo", [
        "chmod",
        "+x",
        newBinary.path,
      ], onCommandFail: FailAction.throwException);
      final recorder = SystemCtlService(recorderServiceName);
      final executablePath = await recorder.getExecutablePath();
      if (executablePath == null) {
        print(
          chalk.red(
            "⚠️  Failed to get current executable path. Failed to upgrade.",
          ),
        );
        exit(1);
      }
      final wasRunning = await recorder.isActive();
      if (wasRunning) {
        await recorder.stop();
        print("✅ Stopped service");
      }
      final oldBinary = File(executablePath);
      await oldBinary.delete();
      print("✅ Deleted old binary");
      await newBinary.copy(oldBinary.path);
      await newBinary.delete();
      print("✅ Replaced with new binary");
      if (wasRunning) {
        final started = await recorder.start();
        if (started) {
          print("✅ Restarted service");
        } else {
          print(chalk.red("⚠️  Failed to restart service."));
          exit(1);
        }
      }
      PrettyPrinter.outputFn = print;
      PrettyPrinter.output(
        Box([
          Text(
            chalk.green(
              "Upgraded ${chalk.bold("owrec")} to the latest version!",
            ),
          ),
        ]),
      );
      exit(0);
    }
    return 0;
  }
}
