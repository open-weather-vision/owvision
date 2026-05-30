import 'package:args/command_runner.dart';
import 'package:chalkdart/chalkstrings.dart';
import 'package:recorder/cli/commands/restart.dart';
import 'package:recorder/cli/commands/update.dart';
import 'package:shared/logger/logger.dart';
import 'package:shared/current_version.dart';
import 'package:logging/logging.dart';

import '../models/recorder_config.dart';
import 'commands/authenticate.dart';
import 'commands/config.dart';
import 'commands/init.dart';
import 'commands/reset.dart';
import 'commands/status.dart';

const recorderServiceName = "ow_recorder";
var recorderConfig = RecorderConfig.fromFileSync();

Future<void> cliEntry(List<String> arguments) async {
  if (arguments.contains('--version') || arguments.contains('-v')) {
    print(currentVersion);
    return;
  }

  logger.level = Level.SEVERE;
  final runner = CommandRunner<int>('owrec', 'CLI for the owvision recorder')
    ..argParser.addFlag(
      'version',
      abbr: 'v',
      help: 'Print the current version.',
      negatable: false,
    )
    ..addCommand(InitCommand())
    ..addCommand(AuthenticateCommand())
    ..addCommand(ResetCommand())
    ..addCommand(ConfigCommand())
    ..addCommand(StatusCommand())
    ..addCommand(RestartCommand())
    ..addCommand(UpdateCommand());

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
