import 'dart:async';
import 'dart:io';

import 'package:args/command_runner.dart';
import 'package:chalkdart/chalkstrings.dart';
import 'package:recorder/cli/entry.dart';

class ConfigCommand extends Command<int> {
  @override
  String get description => "Change the recorder configuration.";

  @override
  String get name => "config";

  ConfigCommand() {
    addSubcommand(HostCommand());
  }
}

class HostCommand extends Command<int> {
  @override
  String get description => "Set/get the interface's hostname.";

  @override
  String get name => "interface_host";

  HostCommand() {
    argParser.addOption(
      "set",
      abbr: "s",
      help: "Sets the interface's hostname.",
    );
  }

  @override
  FutureOr<int> run() async {
    final String? hostName = argResults?['set'];
    if (hostName != null) {
      recorderConfig.interfaceGrpcHost = hostName;
      await recorderConfig.saveToFile();
    }
    print(
      chalk.green(
        "${chalk.bold("interface_host")}=${chalk.italic(recorderConfig.interfaceGrpcHost)}",
      ),
    );
    exit(0);
  }
}
