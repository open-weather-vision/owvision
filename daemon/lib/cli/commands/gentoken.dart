import 'dart:async';
import 'dart:io';

import 'package:args/command_runner.dart';
import 'package:chalkdart/chalkstrings.dart';
import 'package:daemon/cli/entry.dart';
import 'package:dio/dio.dart';
import 'package:interact/interact.dart';
import 'package:owvision_daemon_client_dart/owvision_daemon_client_dart.dart';

class GenerateTokenCommand extends Command<int> {
  @override
  String get description => "Generate a new token.";

  @override
  String get name => "gentoken";

  @override
  FutureOr<int> run() async {
    final selected = Select(
      prompt: "Which type of token do you want to generate?",
      options: ["admin", "recorder", "viewer"],
    ).interact();

    late final TokenRole role;
    if (selected == 0) {
      role = TokenRole.admin;
    } else if (selected == 1) {
      role = TokenRole.recorder;
    } else {
      role = TokenRole.viewer;
    }

    try {
      final response = await daemonClient.getTokenApi().tokenGenerate(
        role: role,
      );
      print(chalk.green("✅  Generated token: ${chalk.italic(response.data!)}"));
    } on DioException catch (e) {
      if (e.response != null) {
        final error = Error.fromJson(e.response!.data);
        print(
          chalk.red(
            "⚠️  Failed to generate token: ${error.message} (${error.code})",
          ),
        );
      } else {
        print(
          chalk.red("⚠️  Failed to generate token! Is the daemon running?"),
        );
      }
    }

    exit(0);
  }
}
