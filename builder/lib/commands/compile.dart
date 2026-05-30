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

  CompileCommand() {
    argParser.addMultiOption(
      "lin-archs",
      help: "The linux architectures to compile for.",
      defaultsTo: ["arm64", "arm", "x64"],
    );
    argParser.addMultiOption(
      "win-archs",
      help: "The windows architectures to compile for.",
      defaultsTo: ["x64"],
    );
  }

  @override
  FutureOr<int> run() async {
    List<String> linArchs =
        argResults?["lin-archs"]?.cast<String>() ?? ["arm64", "arm", "x64"];
    List<String> winArchs = argResults?["win-archs"]?.cast<String>() ?? ["x64"];

    if (linArchs.length == 1 && linArchs[0] == "") {
      linArchs = [];
    }

    if (winArchs.length == 1 && winArchs[0] == "") {
      winArchs = [];
    }

    await WorkspaceBuilder().compile(linuxArchs: linArchs, winArchs: winArchs);
    return 0;
  }
}
