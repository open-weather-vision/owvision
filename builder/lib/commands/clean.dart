import 'dart:async';

import 'package:args/command_runner.dart';

import '../workspace_builder.dart';

/// Cleans the build files of owvision components.
class CleanCommand extends Command<int> {
  @override
  String get description => "Cleans the build files of owvision components.";

  @override
  String get name => "clean";

  CleanCommand() {}

  @override
  FutureOr<int> run() async {
    await WorkspaceBuilder().clean();
    return 0;
  }
}
