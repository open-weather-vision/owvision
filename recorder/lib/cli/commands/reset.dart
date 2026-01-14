import 'dart:async';
import 'dart:io';

import 'package:args/command_runner.dart';
import 'package:chalkdart/chalkstrings.dart';
import 'package:recorder/models/recorder_status.dart';
import 'package:shared/models/recorder_config.dart';
import 'package:shared/service.dart';

class ResetCommand extends Command<int> {
  @override
  String get description =>
      "Resets the recorder service (drops all data). If a systemctl service is running it is stopped and disabled.";

  @override
  String get name => "reset";

  @override
  FutureOr<int> run() async {
    if (Platform.isLinux) {
      await SystemCtlService("ow_recorder").remove();
    }
    await RecorderConfig.removeConfigFile();
    RecorderStatus.removeFile();
    print(chalk.green("✅ Successfully resetted recorder."));
    exit(0);
  }
}
