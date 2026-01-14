import 'dart:async';
import 'dart:io';

import 'package:args/command_runner.dart';
import 'package:chalkdart/chalkstrings.dart';
import 'package:daemon/cli/cli_config.dart';
import 'package:shared/models/daemon_config.dart';
import 'package:shared/service.dart';
import 'package:shared/utils.dart';

class ResetCommand extends Command<int> {
  @override
  String get description =>
      "Resets the daemon service (drops all data). If a systemctl service is running it is stopped and disabled.";

  @override
  String get name => "reset";

  @override
  FutureOr<int> run() async {
    if (Platform.isLinux) {
      await SystemCtlService("ow_daemon").remove();
      await runShellCommand("sudo", ["caddy", "stop"]);
    }
    await CliConfig.removeConfigFile();
    await DaemonConfig.removeConfigFile();
    try {
      File("${getOwvisionHomeDirectory()}/data.sqlite").deleteSync();
    } catch (_) {}
    print(chalk.green("✅ Successfully resetted daemon."));
    exit(0);
  }
}
