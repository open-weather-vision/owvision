import 'dart:convert';

import 'package:daemon/services/live_sensor_state_service.dart';
import 'package:daemon/services/station_service.dart';
import 'package:injectable/injectable.dart';
import 'package:shared/models/error_response.dart';
import 'package:shelf/shelf.dart';
import 'package:shelf_web_socket/shelf_web_socket.dart';

@singleton
class StationController {
  final StationService _stationService;
  final LiveSensorStateService _liveSocketService;

  StationController(this._stationService, this._liveSocketService);

  Future<Response> getAll(Request request) async {
    final stations = await _stationService.getAll();

    final jsonBody = jsonEncode(stations.map((s) => s.toJson()).toList());

    return Response.ok(jsonBody);
  }

  Future<Response> getOne(Request request, String id) async {
    final idParsed = int.tryParse(id);
    if (idParsed == null) {
      return Response.notFound(
        jsonEncode(
          ErrorResponse(ErrorCode.notFound, "Station id must be an integer!"),
        ),
      );
    }
    final stationAndSensors = await _stationService.getStationAndSensorsById(
      id: idParsed,
    );

    if (stationAndSensors == null) {
      return Response.notFound(
        jsonEncode(ErrorResponse(ErrorCode.notFound, "Invalid station id!")),
      );
    }

    final jsonBody = jsonEncode(stationAndSensors);
    return Response.ok(jsonBody);
  }

  Future<Response> live(Request request, String id) async {
    final idParsed = int.tryParse(id);
    if (idParsed == null) {
      return Response.notFound(
        jsonEncode(
          ErrorResponse(ErrorCode.notFound, "Station id must be an integer!"),
        ),
      );
    }
    final station = await _stationService.getById(id: idParsed);
    if (station == null) {
      return Response.notFound(
        jsonEncode(ErrorResponse(ErrorCode.notFound, "Invalid station id!")),
      );
    }

    final handler = webSocketHandler((webSocket, _) {
      _liveSocketService.handleWebsocketConnection(webSocket, station);
    });

    return handler(request);
  }
}
