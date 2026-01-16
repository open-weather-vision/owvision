import 'dart:convert';
import 'dart:io';

import 'package:chalkdart/chalkdart.dart';

String getOwvisionHomeDirectory() {
  String home = "";
  Map<String, String> envVars = Platform.environment;
  if (Platform.isMacOS) {
    home = envVars['HOME']!;
  } else if (Platform.isLinux) {
    home = envVars['HOME']!;
  } else if (Platform.isWindows) {
    home = envVars['UserProfile']!;
  }

  return "$home/.owvision";
}

enum FailAction { throwException, exit, logWarning, silent, exitSilent }

Future<int> runShellCommand(
  String command,
  List<String> options, {
  String cwd = ".",
  bool forwardOutput = true,
  FailAction onCommandFail = FailAction.logWarning,
  void Function()? onError,
}) async {
  final runCommand = await Process.start(
    command,
    options,
    runInShell: true,
    workingDirectory: cwd,
  );
  if (forwardOutput) {
    runCommand.stdout
        .transform(utf8.decoder)
        .forEach((x) => print(chalk.dim(x)));
    runCommand.stderr
        .transform(utf8.decoder)
        .forEach((x) => print(chalk.dim(x)));
  }
  final result = await runCommand.exitCode;
  if (result != 0) {
    if (onError != null) {
      onError();
    } else if (onCommandFail == FailAction.throwException) {
      throw Exception(
        "Command '$command ${options.join(" ")}' failed to execute successfully!",
      );
    } else if (onCommandFail == FailAction.logWarning) {
      print(
        chalk.yellow(
          "⚠️  Command '$command ${options.join(" ")}' failed to execute successfully!",
        ),
      );
    } else if (onCommandFail == FailAction.exit) {
      print(
        chalk.red(
          "⚠️  Command '$command ${options.join(" ")}' failed to execute successfully!",
        ),
      );
      exit(1);
    } else if (onCommandFail == FailAction.exitSilent) {
      exit(1);
    }
  }
  return result;
}

Future<bool> checkIfShellCommandExists(String command) async {
  final exitCode = await runShellCommand(
    "which",
    [command],
    forwardOutput: false,
    onCommandFail: FailAction.silent,
  );

  return exitCode == 0;
}

Future<void> tryToInstallCommandUsingApt(
  String command, {
  bool checkIfExists = true,
}) async {
  if (checkIfExists && await checkIfShellCommandExists(command)) {
    print(chalk.dim("${chalk.bold(command)} is already installed!"));
    return;
  }
  final exitCode = await runShellCommand("sudo", [
    "apt",
    "install",
    "-y",
    command,
  ], onCommandFail: FailAction.silent);
  if (exitCode != 0) {
    print(chalk.red("Cancelled: Failed to install ${chalk.bold(command)}!"));
    exit(1);
  }
}
