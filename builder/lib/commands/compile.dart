import 'dart:async';

import 'package:args/command_runner.dart';

import '../workspace_builder.dart';

/// Compiles owvision, outputs the binaries to the build folder.
class CompileCommand extends Command<int> {
  @override
  String get description =>
      "Compiles owvision, outputs the binaries to the build folder.";

  @override
  String get name => "compile";

  @override
  FutureOr<int> run() async {
    await WorkspaceBuilder().compile();
    return 0;
  }
}
