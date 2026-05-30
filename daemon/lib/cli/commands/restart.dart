import 'dart:async';
import 'dart:io';

import 'package:args/command_runner.dart';
import 'package:chalkdart/chalkstrings.dart';
import 'package:daemon/cli/entry.dart';
import 'package:shared/service.dart';
import 'package:shared/utils.dart';

class RestartCommand extends Command<int> {
  @override
  String get description => "Restarts the daemon service.";

  @override
  String get name => "restart";

  @override
  FutureOr<int> run() async {
    await requireAdminOnWindows();
    final service = BackgroundService(daemonServiceName);
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
