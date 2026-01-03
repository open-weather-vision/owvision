import 'dart:async';
import 'dart:io';

import 'package:args/command_runner.dart';
import 'package:chalkdart/chalkdart.dart';
import 'package:shared/current_version.dart';

import '../../workspace_manager.dart';

class BuildCommand extends Command<int> {
  @override
  String get description => "Builds to a certain version.";

  @override
  String get name => "build";

  BuildCommand() {
    argParser.addFlag(
      "yes",
      abbr: "y",
      help: "Build using current version",
      defaultsTo: false,
    );
  }

  @override
  FutureOr<int> run() async {
    final buildUsingCurrentVersion = argResults!['yes'];

    var version = currentVersion;
    if (!buildUsingCurrentVersion) {
      stdout.write(chalk.bold.green("Please enter the version code: "));
      version = stdin.readLineSync() ?? currentVersion;
      _updateCurrentVersion(version);
    }
    print(chalk.green("Building version v$version..."));

    await WorkspaceManager().update(version);

    return 0;
  }
}

void _updateCurrentVersion(String version) {
  final versionFile = File("./shared/lib/current_version.dart");
  final updatedContent = versionFile.readAsStringSync().replaceFirst(
    RegExp(r'"[^"]*"'),
    "\"$version\"",
  );
  versionFile.writeAsStringSync(updatedContent);
  print("Updated current_version.dart file!");
}
