import 'package:daemon/services/caddy_service.dart';
import 'package:daemon/services/history_creator_service.dart';
import 'package:logging/logging.dart';
import 'package:shared/logger/logger.dart';

import 'locator.dart';
import 'services/live_sensor_state_service.dart';
import 'services/live_service.dart';
import 'services/rest_api_service.dart';
import 'services/token_service.dart';
import 'utils/fix_libsqlite.dart';

Future<void> runDaemon() async {
  fixLibsqlite();

  logger.level = Level.ALL;
  // load injectable services
  configureDependencies();

  // start grpc live service
  final liveService = getIt<LiveService>();
  liveService.enableLogs();
  await liveService.start();

  // start rest api
  final restApi = getIt<RestApiService>();
  await restApi.start();

  // configure caddy
  final caddyService = getIt<CaddyService>();
  caddyService.tryToConfigure();

  // start tracking stations state in ram
  final liveSensorStateService = getIt<LiveSensorStateService>();
  await liveSensorStateService.start();

  // start generating history records
  final historyCreatorService = getIt<HistoryCreatorService>();
  await historyCreatorService.start();

  // start generating tokens if there are none
  final tokenService = getIt<TokenService>();
  await tokenService.insertInitializationTokenIfThereIsNone();
}
