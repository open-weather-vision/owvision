import 'package:args/command_runner.dart';
import 'package:chalkdart/chalkstrings.dart';
import 'package:recorder/cli/commands/authenticate.dart';
import 'package:recorder/cli/commands/config.dart';
import 'package:recorder/cli/commands/reset.dart';
import 'package:recorder/cli/commands/init.dart';
import 'package:recorder/cli/commands/status.dart';
import 'package:shared/logger/logger.dart';
import 'package:shared/models/recorder_config.dart';
import 'package:logging/logging.dart';

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
