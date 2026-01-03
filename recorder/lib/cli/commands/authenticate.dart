import 'dart:async';
import 'dart:io';

import 'package:args/command_runner.dart';
import 'package:interact/interact.dart';
import 'package:recorder/cli/entry.dart';

class AuthenticateCommand extends Command<int> {
  @override
  String get description => "Sets the api token to use for authentication.";

  @override
  String get name => "authenticate";

  @override
  FutureOr<int> run() async {
    recorderConfig.daemonGrpcToken = Input(
      prompt: "Please enter your access token",
    ).interact();
    await recorderConfig.saveToFile();
    print("✅ Successfully configured token!");
    exit(0);
  }
}
