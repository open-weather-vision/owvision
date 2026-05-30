import 'package:args/command_runner.dart';
import 'package:chalkdart/chalkstrings.dart';
import 'package:daemon/cli/cli_config.dart';
import 'package:daemon/cli/commands/authenticate.dart';
import 'package:daemon/cli/commands/config.dart';
import 'package:daemon/cli/commands/gentoken.dart';
import 'package:daemon/cli/commands/reset.dart';
import 'package:daemon/cli/commands/init.dart';
import 'package:daemon/cli/commands/restart.dart';
import 'package:daemon/cli/commands/station.dart';
import 'package:daemon/cli/commands/status.dart';
import 'package:daemon/cli/commands/update.dart';
import 'package:logging/logging.dart';
import 'package:owvision_daemon_client_dart/owvision_daemon_client_dart.dart';
import 'package:shared/logger/logger.dart';
import 'package:shared/current_version.dart';

const daemonServiceName = "ow_daemon";
final cliConfig = CliConfig();
final daemonClient = OwvisionDaemonClientDart(
  basePathOverride: cliConfig.daemonHost,
);

Future<void> cliEntry(List<String> arguments) async {
  if (arguments.contains('--version') || arguments.contains('-v')) {
    print(currentVersion);
    return;
  }

  logger.level = Level.OFF;
  if (cliConfig.apiToken != null) {
    daemonClient.setBearerAuth("BearerAuth", cliConfig.apiToken!);
  }

  final runner = CommandRunner<int>('owvi', 'CLI for the owvision daemon')
    ..argParser.addFlag(
      'version',
      abbr: 'v',
      help: 'Print the current version.',
      negatable: false,
    )
    ..addCommand(RunCommand())
    ..addCommand(StationCommand())
    ..addCommand(AuthenticateCommand())
    ..addCommand(ConfigCommand())
    ..addCommand(ResetCommand())
    ..addCommand(GenerateTokenCommand())
    ..addCommand(StatusCommand())
    ..addCommand(UpdateCommand())
    ..addCommand(RestartCommand());

  try {
    await runner.run(arguments);
  } on UsageException catch (e) {
    print(chalk.red(e.message));
    print(e.usage);
    return;
  } catch (e) {
    print(chalk.red(e.toString()));
    return;
  }
}
