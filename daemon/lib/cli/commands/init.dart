import 'dart:async';
import 'dart:io';

import 'package:chalkdart/chalkstrings.dart';
import 'package:daemon/cli/entry.dart';
import 'package:interact/interact.dart';
import 'package:logging/logging.dart';
import 'package:owvision_daemon_client_dart/owvision_daemon_client_dart.dart';
import 'package:shared/current_version.dart';
import 'package:shared/logger/logger.dart';
import 'package:shared/models/daemon_config.dart';
import 'package:shared/pretty_print.dart';
import 'package:shared/service.dart';
import 'package:shared/utils.dart';

import '../../locator.dart';
import '../../services/caddy_service.dart';
import '../../services/live_sensor_state_service.dart';
import '../../services/live_service.dart';
import '../../services/rest_api_service.dart';
import '../../services/token_service.dart';
import 'package:args/command_runner.dart';

class RunCommand extends Command<int> {
  @override
  String get description => "Initializes the owvision daemon.";

  @override
  String get name => "init";

  RunCommand() {
    argParser.addFlag(
      "temporary",
      abbr: "t",
      help:
          "Runs the daemon only temporary. ${chalk.italic("Not recommended.")}",
      defaultsTo: false,
    );
  }

  @override
  FutureOr<int> run() async {
    final bool runTemporary = argResults?['temporary'];
    if (runTemporary) {
      logger.level = Level.ALL;
      // load injectable services
      configureDependencies();

      // start grpc live service
      final liveService = getIt<LiveService>();
      liveService.enableLogs();
      await liveService.start();

      // start rest api
      final restApi = getIt<RestApiService>();
      await restApi.start();

      // configure caddy
      final caddyService = getIt<CaddyService>();
      caddyService.tryToConfigure();

      // start tracking stations state in ram
      final liveSensorStateService = getIt<LiveSensorStateService>();
      await liveSensorStateService.start();

      // start generating tokens if there are none
      final tokenService = getIt<TokenService>();
      await tokenService.insertInitializationTokenIfThereIsNone();

      return 0;
    } else {
      final installDependencies = Confirm(
        prompt:
            "Do you want to try to automatically install required dependencies? (sqlite3, libsqlite3-dev, caddy)",
        defaultValue: true,
      ).interact();
      if (installDependencies) {
        if (Platform.isLinux) {
          await runShellCommand("sudo", [
            "apt",
            "install",
            "-y",
            "sqlite3",
            "libsqlite3-dev",
            "caddy",
          ]);

          await runShellCommand("sudo", ["caddy", "start"]);
        } else {
          print(
            chalk.yellow(
              "⚠️ Installing dependencies automatically is not supported on ${Platform.operatingSystem}. Make sure you have them installed.",
            ),
          );
          final continueInit = Confirm(
            prompt: "Do you want to continue?",
            defaultValue: false,
          ).interact();
          if (!continueInit) {
            exit(0);
          }
        }
      }

      final option = Select(
        prompt: "Which option fits your situation?",
        options: [
          "I own a public domain, that is already configured to point to the static public ip address of my server. ${chalk.dim("(recommended)")}",
          "I do not own a domain, but my server has a publicly visible static ip address.",
          "I only want the daemon to be visible in my local network.",
        ],
      ).interact();

      final daemonConfig = DaemonConfig.fromFileSync();
      if (option == 0) {
        print(
          chalk.dim(
            "owvision will automatically handle the management of TLS certificates using ${chalk.italic("caddy")}.",
          ),
        );
        final domain = Input(
          prompt: "Please enter your domain's name",
          defaultValue: "example.com",
        ).interact();

        daemonConfig.publicHostName = domain;
      } else if (option == 1) {
        print(
          chalk.dim(
            "owvision will use a self signed caddy certificate for TLS.",
          ),
        );
        final ipAddress = Input(
          prompt: "Please enter your public ip",
          defaultValue: "10.23.102.12",
        ).interact();

        daemonConfig.publicHostName = ipAddress;
      } else {
        daemonConfig.publicHostName = "127.0.0.1";
      }
      await daemonConfig.saveToFile();

      final service = await SystemCtlService.register(
        description: "owvision daemon",
        name: "ow_daemon",
      );
      if (service == null) {
        exit(0);
      }

      final tmpDaemonClient = OwvisionDaemonClientDart(
        basePathOverride: OwvisionDaemonClientDart.basePath,
      );
      tmpDaemonClient.setBearerAuth("BearerAuth", "%12345678%");
      final api = tmpDaemonClient.getTokenApi();

      print(chalk.yellow.italic("⌛ Waiting for daemon to run. Do not quit!"));
      await Future.delayed(Duration(seconds: 5));
      var authenticated = false;
      final maxTries = 10;
      var tries = 0;
      while (!authenticated && tries < maxTries) {
        try {
          await Future.delayed(Duration(seconds: 1));
          final response = await api.tokensGenerate(role: TokenRole.admin);
          cliConfig.apiToken = response.data!;
          cliConfig.save();
          authenticated = true;
        } catch (e) {
          tries++;
        }
      }

      if (!authenticated) {
        print(
          chalk.red(
            "⚠️  Failed to initialize daemon. Try running ${chalk.italic("owvi reset && owvi init")}.",
          ),
        );
      } else {
        PrettyPrinter.outputFn = (str) => print(chalk.green.bold(str));
        PrettyPrinter.output(
          Box(([
            Text(r"  _____      ____   ___"),
            Text(r" / _ \ \ /\ / /\ \ / / |"),
            Text(r"| (_) \ V  V /  \ V /| |"),
            Text(r" \___/ \_/\_/    \_/ |_|"),
            Text(r"......................."),
          ])),
        );
        print(
          chalk.bold.dim(
            "daemon v$currentVersion is running as background service.",
          ),
        );
        print(
          chalk.italic.yellow(
            "🌍 Make sure following ports are not blocked by your firewall: tcp/80, tcp/443, tcp/${daemonConfig.grpcPublicPort}, tcp/${daemonConfig.restApiPublicPort}",
          ),
        );
      }
      exit(0);
    }
  }
}
