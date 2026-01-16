import 'dart:async';
import 'dart:io';

import 'package:args/command_runner.dart';
import 'package:chalkdart/chalkstrings.dart';
import 'package:interact/interact.dart';
import 'package:logging/logging.dart';
import 'package:recorder/cli/entry.dart';
import 'package:recorder/cli/ping_daemon.dart';
import 'package:shared/current_version.dart';
import 'package:shared/logger/logger.dart';
import 'package:shared/pretty_print.dart';
import 'package:shared/service.dart';
import '../../locator.dart';
import '../../services/recorder_service.dart';

class InitCommand extends Command<int> {
  @override
  String get description => "Initializes the owvision recorder.";

  @override
  String get name => "init";

  InitCommand() {
    argParser.addFlag(
      "temporary",
      abbr: "t",
      help:
          "Runs the recorder only temporary without registering a service. ${chalk.italic("Not recommended.")}",
      defaultsTo: false,
    );
  }

  @override
  FutureOr<int> run() async {
    final bool runTemporary = argResults!['temporary'];
    if (!runTemporary) {
      recorderConfig.daemonGrpcHost = Input(
        prompt: "Please confirm the daemon's hostname (it's ip or domain)",
        defaultValue: recorderConfig.daemonGrpcHost,
      ).interact();
      recorderConfig.trustSelfSignedCertificate = Confirm(
        prompt: "Do you want to trust self signed certificates?",
        defaultValue: false,
      ).interact();
      recorderConfig.daemonGrpcPort =
          int.tryParse(
            Input(
              prompt: "Please confirm the daemon's grpc port",
              defaultValue: recorderConfig.daemonGrpcPort.toString(),
            ).interact(),
          ) ??
          recorderConfig.daemonGrpcPort;
      recorderConfig.daemonGrpcToken = Input(
        prompt:
            "Please enter your recorder access token (run ${chalk.italic("owvi gentoken")} to generate one)",
      ).interact();
      await recorderConfig.saveToFile();
      print(
        chalk.bold.dim("Testing connection to owvision daemon. Do not quit..."),
      );
      final success = await pingDaemon();
      if (success) {
        print(chalk.green("✅ Connection test succeeded! Starting service..."));
      } else {
        print(
          chalk.red(
            "⚠️ Connection test failed! Is your api token correct? Is your daemon running and visible in your network? Retry using ${chalk.italic("owrec reset && owrec init")}.",
          ),
        );
        exit(1);
      }
      await SystemCtlService.create(
        name: "ow_recorder",
        description: "owvision recorder",
      );
      PrettyPrinter.outputFn = (str) => print(chalk.green.bold(str));
      PrettyPrinter.output(
        Box(([
          Text(r"  _____      ___ __ ___  ___"),
          Text(r" / _ \ \ /\ / / '__/ _ \/ __|"),
          Text(r"| (_) \ V  V /| | |  __/ (__ "),
          Text(r" \___/ \_/\_/ |_|  \___|\___|"),
          Text(r"............................."),
        ])),
      );
      print(
        chalk.bold.dim("v$currentVersion is running as background service."),
      );
      exit(0);
    } else {
      logger.level = Level.ALL;
      configureDependencies();
      final service = getIt<RecorderService>();
      await service.start();
    }

    return 0;
  }
}
