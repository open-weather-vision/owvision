import 'dart:async';
import 'dart:io';

import 'package:args/command_runner.dart';
import 'package:chalkdart/chalkstrings.dart';
import 'package:daemon/cli/entry.dart';
import 'package:shared/service.dart';

class RestartCommand extends Command<int> {
  @override
  String get description => "Restarts the daemon service.";

  @override
  String get name => "restart";

  @override
  FutureOr<int> run() async {
    if (!Platform.isLinux) {
      print(chalk.red("⚠️  Service commands are only supported on linux."));
      exit(1);
    }
    final service = SystemCtlService(daemonServiceName);
    final result = await service.restart();
    if (result) {
      print(
        "✅ Successfully restarted service ${chalk.italic(daemonServiceName)}!",
      );
    } else {
      print(chalk.red("⚠️ Failed to restart service."));
    }
    return 0;
  }
}
