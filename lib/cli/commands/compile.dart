import 'dart:async';

import 'package:args/command_runner.dart';

import '../../workspace_manager.dart';

class CompileCommand extends Command<int> {
  @override
  String get description => "Compile recorder and daemon binaries.";

  @override
  String get name => "compile";

  @override
  FutureOr<int> run() async {
    await WorkspaceManager().compile();
    return 0;
  }
}
