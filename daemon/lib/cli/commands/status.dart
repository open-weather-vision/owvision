import 'dart:async';
import 'dart:io';

import 'package:args/command_runner.dart';
import 'package:chalkdart/chalkdart.dart';
import 'package:daemon/cli/entry.dart';
import 'package:shared/service.dart';
import 'package:shared/utils.dart';

class StatusCommand extends Command<int> {
  @override
  String get description =>
      "Checks if the daemon service and the caddy service are running.";

  @override
  String get name => "status";

  @override
  FutureOr<int> run() async {
    if (!Platform.isLinux) {
      print(chalk.red("Only supported on linux systems!"));
      exit(1);
    }
    final demonActive = await SystemCtlService(daemonServiceName).isActive();
    final caddyActive =
        await runShellCommand(
          "systemctl",
          ["is-active", "caddy"],
          forwardOutput: false,
          onCommandFail: FailAction.silent,
        ) ==
        0;
    print(
      "${chalk.underline("daemon")}: ${chalk.bold(demonActive ? chalk.green("running") : chalk.red("not running"))}",
    );
    print(
      "${chalk.underline("caddy")}: ${chalk.bold(caddyActive ? chalk.green("running") : chalk.red("not running"))}",
    );
    exit(0);
  }
}
