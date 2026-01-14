import 'dart:async';
import 'dart:io';

import 'package:args/command_runner.dart';
import 'package:chalkdart/chalkstrings.dart';
import 'package:daemon/cli/entry.dart';

class ConfigCommand extends Command<int> {
  @override
  String get description => "Change the cli configuration.";

  @override
  String get name => "config";

  ConfigCommand() {
    addSubcommand(HostCommand());
  }
}

class HostCommand extends Command<int> {
  @override
  String get description => "Set/get the daemon's hostname.";

  @override
  String get name => "host";

  HostCommand() {
    argParser.addOption("set", abbr: "s", help: "Sets the daemon's hostname.");
  }

  @override
  FutureOr<int> run() async {
    final String? hostName = argResults?['set'];
    if (hostName != null) {
      cliConfig.daemonHost = hostName;
      cliConfig.saveToFile();
    }
    print(
      chalk.green(
        "${chalk.bold("host")}=${chalk.italic(cliConfig.daemonHost)}",
      ),
    );
    exit(0);
  }
}
