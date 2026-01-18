import 'package:args/command_runner.dart';
import 'package:chalkdart/chalkstrings.dart';
import 'package:shared/logger/logger.dart';
import 'package:logging/logging.dart';

import '../models/recorder_config.dart';
import 'commands/authenticate.dart';
import 'commands/config.dart';
import 'commands/init.dart';
import 'commands/reset.dart';
import 'commands/status.dart';

var recorderConfig = RecorderConfig.fromFileSync();

Future<void> cliEntry(List<String> arguments) async {
  logger.level = Level.SEVERE;
  final runner = CommandRunner<int>('owrec', 'CLI for the owvision recorder')
    ..addCommand(InitCommand())
    ..addCommand(AuthenticateCommand())
    ..addCommand(ResetCommand())
    ..addCommand(ConfigCommand())
    ..addCommand(StatusCommand());

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
