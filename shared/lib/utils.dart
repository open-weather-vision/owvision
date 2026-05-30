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
  bool interactive = false,
  FailAction onCommandFail = FailAction.logWarning,
  bool preferWindowsPowerShell = false,
  bool dimOutput = true,
  void Function()? onError,
}) async {
  late final runCommand;

  if (Platform.isWindows && preferWindowsPowerShell) {
    runCommand = await Process.start(
      "powershell",
      ["-Command", command, ...options],
      workingDirectory: cwd,
      runInShell: true,
      mode: interactive
          ? ProcessStartMode.inheritStdio
          : ProcessStartMode.normal,
    );
  } else {
    runCommand = await Process.start(
      command,
      options,
      workingDirectory: cwd,
      runInShell: true,
      mode: interactive
          ? ProcessStartMode.inheritStdio
          : ProcessStartMode.normal,
    );
  }

  if (forwardOutput && !interactive) {
    runCommand.stdout
        .transform(utf8.decoder)
        .forEach((x) => print(dimOutput ? chalk.dim(x) : x));
    runCommand.stderr
        .transform(utf8.decoder)
        .forEach((x) => print(dimOutput ? chalk.dim(x) : x));
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
  late final int exitCode;
  if (Platform.isWindows) {
    exitCode = await runShellCommand(
      "Get-Command",
      [command],
      forwardOutput: false,
      onCommandFail: FailAction.silent,
      preferWindowsPowerShell: true,
    );
  } else {
    exitCode = await runShellCommand(
      "which",
      [command],
      forwardOutput: false,
      onCommandFail: FailAction.silent,
    );
  }

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

Future<void> tryToInstallCommandUsingWinget(
  String commandName,
  String packageName, {
  bool checkIfExists = true,
}) async {
  if (checkIfExists && await checkIfShellCommandExists(commandName)) {
    print(chalk.dim("${chalk.bold(commandName)} is already installed!"));
    return;
  }
  final exitCode = await runShellCommand(
    "winget",
    ["install", "--id", packageName, "-e", "--silent"],
    onCommandFail: FailAction.silent,
    preferWindowsPowerShell: true,
  );
  if (exitCode != 0) {
    print(
      chalk.red(
        "Cancelled: Failed to install ${chalk.bold(commandName)} (package: ${chalk.italic(packageName)})!",
      ),
    );
    exit(1);
  }
}

Future<void> requireAdminOnWindows() async {
  if (Platform.isWindows) {
    // Under Windows, 'net session' is only successful when running as Admin
    final result = await Process.run('net', ['session']);
    if (result.exitCode != 0) {
      print(
        chalk.yellow(
          "\n⚠️  Administrator privileges are required for this action.",
        ),
      );
      exit(1);
    }
  }
}
