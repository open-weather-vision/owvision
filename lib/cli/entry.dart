import 'package:args/command_runner.dart';
import 'package:owvision/cli/commands/build.dart';
import 'package:owvision/cli/commands/compile.dart';

Future<void> cliEntry(List<String> arguments) async {
  final runner = CommandRunner<int>(
    'manager',
    'CLI for building and publishing',
  );

  runner.addCommand(BuildCommand());
  runner.addCommand(CompileCommand());

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
