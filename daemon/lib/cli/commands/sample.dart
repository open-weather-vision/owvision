import 'dart:async';

import 'package:args/command_runner.dart';

class SampleCommand extends Command<int> {
  @override
  String get description => "Does something.";

  @override
  String get name => "sample";

  @override
  FutureOr<int> run() async {
    return 0;
  }
}
