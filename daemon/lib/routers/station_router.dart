import 'package:daemon/controllers/station_controller.dart';
import 'package:injectable/injectable.dart';
import 'package:shelf/shelf.dart';
import 'package:shelf_router/shelf_router.dart';

@singleton
class StationRouter {
  final StationController _stationController;

  StationRouter(this._stationController);

  Handler get router {
    final app = Router();
    // every role can read from the stations controller

    app.get("/", _stationController.getAll);
    app.get("/<id>", _stationController.getOne);
    app.get("/<id>/live", _stationController.live);
    app.get("/<id>/history", _stationController.getHistory);

    return app.call;
  }
}
