import 'package:daemon/routers/station_router.dart';
import 'package:daemon/routers/token_router.dart';
import 'package:injectable/injectable.dart';
import 'package:shelf/shelf.dart';
import "package:shelf_router/shelf_router.dart";

@singleton
class AppRouter {
  final TokenRouter _tokenRouter;
  final StationRouter _stationRouter;
  final String version = "v1";

  AppRouter(this._stationRouter, this._tokenRouter);

  Handler get router {
    final app = Router();

    final api = Router();
    api.mount("/stations", _stationRouter.router);

    api.mount("/tokens", _tokenRouter.router);

    app.mount("/api/$version", api.call);
    return app.call;
  }
}
