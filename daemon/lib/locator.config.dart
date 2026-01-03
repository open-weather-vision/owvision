// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format width=80

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:get_it/get_it.dart' as _i174;
import 'package:injectable/injectable.dart' as _i526;

import 'controllers/station_controller.dart' as _i12;
import 'controllers/token_controller.dart' as _i1022;
import 'database/database.dart' as _i565;
import 'repositories/sensor_repository.dart' as _i247;
import 'repositories/station_repository.dart' as _i189;
import 'repositories/token_repository.dart' as _i434;
import 'routers/app_router.dart' as _i50;
import 'routers/station_router.dart' as _i296;
import 'routers/token_router.dart' as _i677;
import 'services/caddy_service.dart' as _i1032;
import 'services/config_service.dart' as _i863;
import 'services/live_sensor_state_service.dart' as _i141;
import 'services/live_service.dart' as _i160;
import 'services/rest_api_service.dart' as _i346;
import 'services/sensor_service.dart' as _i631;
import 'services/station_service.dart' as _i572;
import 'services/token_service.dart' as _i570;

extension GetItInjectableX on _i174.GetIt {
  // initializes the registration of main-scope dependencies inside of GetIt
  _i174.GetIt init({
    String? environment,
    _i526.EnvironmentFilter? environmentFilter,
  }) {
    final gh = _i526.GetItHelper(this, environment, environmentFilter);
    gh.singleton<_i565.AppDatabase>(() => _i565.AppDatabase());
    gh.singleton<_i863.ConfigService>(() => _i863.ConfigService());
    gh.singleton<_i247.SensorRepository>(
      () => _i247.SensorRepository(gh<_i565.AppDatabase>()),
    );
    gh.singleton<_i189.StationRepository>(
      () => _i189.StationRepository(gh<_i565.AppDatabase>()),
    );
    gh.singleton<_i434.TokenRepository>(
      () => _i434.TokenRepository(gh<_i565.AppDatabase>()),
    );
    gh.singleton<_i1032.CaddyService>(
      () => _i1032.CaddyService(gh<_i863.ConfigService>()),
    );
    gh.singleton<_i631.SensorService>(
      () => _i631.SensorService(gh<_i247.SensorRepository>()),
    );
    gh.singleton<_i572.StationService>(
      () => _i572.StationService(gh<_i189.StationRepository>()),
    );
    gh.singleton<_i570.TokenService>(
      () => _i570.TokenService(
        gh<_i434.TokenRepository>(),
        gh<_i863.ConfigService>(),
      ),
    );
    gh.singleton<_i160.LiveService>(
      () => _i160.LiveService(
        gh<_i572.StationService>(),
        gh<_i631.SensorService>(),
        gh<_i863.ConfigService>(),
      ),
    );
    gh.singleton<_i1022.TokenController>(
      () => _i1022.TokenController(
        gh<_i570.TokenService>(),
        gh<_i863.ConfigService>(),
      ),
    );
    gh.singleton<_i677.TokenRouter>(
      () => _i677.TokenRouter(gh<_i1022.TokenController>()),
    );
    gh.singleton<_i141.LiveSensorStateService>(
      () => _i141.LiveSensorStateService(
        gh<_i160.LiveService>(),
        gh<_i572.StationService>(),
      ),
    );
    gh.singleton<_i12.StationController>(
      () => _i12.StationController(
        gh<_i572.StationService>(),
        gh<_i141.LiveSensorStateService>(),
      ),
    );
    gh.singleton<_i296.StationRouter>(
      () => _i296.StationRouter(gh<_i12.StationController>()),
    );
    gh.singleton<_i50.AppRouter>(
      () => _i50.AppRouter(gh<_i296.StationRouter>(), gh<_i677.TokenRouter>()),
    );
    gh.singleton<_i346.RestApiService>(
      () =>
          _i346.RestApiService(gh<_i50.AppRouter>(), gh<_i863.ConfigService>()),
    );
    return this;
  }
}
