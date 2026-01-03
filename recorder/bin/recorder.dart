import 'package:recorder/cli/entry.dart';
import 'package:recorder/locator.dart';
import 'package:recorder/services/recorder_service.dart';

void main(List<String> arguments) async {
  await cliEntry(arguments);
  // configureDependencies();
  // final service = getIt<RecorderService>();
  // await service.start();
}
