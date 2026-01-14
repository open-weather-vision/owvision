import 'dart:async';
import 'dart:io';

import 'package:args/command_runner.dart';
import 'package:daemon/cli/entry.dart';
import 'package:interact/interact.dart';

class AuthenticateCommand extends Command<int> {
  @override
  String get description => "Sets the api token to use for authentication.";

  @override
  String get name => "authenticate";

  @override
  FutureOr<int> run() async {
    cliConfig.apiToken = Input(
      prompt: "Please enter your access token",
    ).interact();
    cliConfig.saveToFile();
    print("✅ Successfully configured token!");
    exit(0);
  }
}
