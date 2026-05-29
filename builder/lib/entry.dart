import 'package:args/command_runner.dart';
import 'package:builder/commands/clean.dart';
import 'commands/build.dart';
import 'commands/compile.dart';

/// Entry point to the build and compile CLI.
Future<void> cliEntry(List<String> arguments) async {
  final runner = CommandRunner<int>(
    'builder',
    'CLI for building and compiling the owvision software and its components.',
  );
  runner.addCommand(BuildCommand());
  runner.addCommand(CompileCommand());
  runner.addCommand(CleanCommand());

  try {
    await runner.run(arguments);
  } on UsageException catch (e) {
    print(e.message);
    print(e.usage);
    return;
  } catch (e) {
    print(e);
    return;
  }
}
