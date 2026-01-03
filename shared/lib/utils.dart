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

  return "$home/.owvision/";
}

Future<void> runShellCommand(
  String command,
  List<String> options, {
  String cwd = ".",
  bool forwardOutput = true,
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
  await runCommand.exitCode;
}
