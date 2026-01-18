import 'dart:convert';

import 'package:daemon/models/sensor_history.dart';
import 'package:daemon/services/history_service.dart';
import 'package:daemon/services/live_sensor_state_service.dart';
import 'package:daemon/services/station_service.dart';
import 'package:injectable/injectable.dart';
import 'package:shared/logger/logger.dart';
import 'package:shelf/shelf.dart';
import 'package:shelf_web_socket/shelf_web_socket.dart';

import '../models/error_response.dart';

@singleton
class StationController {
  final StationService _stationService;
  final LiveSensorStateService _liveSocketService;
  final HistoryService _historyService;

  StationController(
    this._stationService,
    this._liveSocketService,
    this._historyService,
  );

  Future<Response> getAll(Request request) async {
    final stations = await _stationService.getAll();

    final jsonBody = jsonEncode(stations.map((s) => s.toJson()).toList());

    return Response.ok(jsonBody);
  }

  Future<Response> getHistory(Request request, String id) async {
    final idParsed = int.tryParse(id);
    if (idParsed == null) {
      return Response.notFound(
        jsonEncode(
          ErrorResponse(
            ErrorCode.notFound,
            "Station id must be an integer!",
          ).toJson(),
        ),
      );
    }

    var sensors = request.url.queryParametersAll["sensors"];

    final fromRaw = request.url.queryParameters["from"];
    final toRaw = request.url.queryParameters["to"];
    late final DateTime? from;
    late final DateTime? to;
    try {
      from = fromRaw != null ? DateTime.parse(fromRaw) : null;
      to = toRaw != null ? DateTime.parse(toRaw) : null;
    } catch (e) {
      return Response.badRequest(
        body: jsonEncode(
          ErrorResponse(
            ErrorCode.badRequest,
            "Failed to parse from/to interval!",
          ).toJson(),
        ),
      );
    }

    sensors ??=
        (await _stationService.getStationAndSensorsById(
          id: idParsed,
        ))?.sensors.map((s) => s.name).toList() ??
        [];

    final histories = <SensorHistory>[];
    for (final sensor in sensors) {
      final history = await _historyService.getSensorHistory(
        stationId: idParsed,
        sensorName: sensor,
        from: from,
        to: to,
      );
      if (history != null) {
        histories.add(history);
      } else {
        logger.warning(
          "Getting history for sensor '$sensor' (station id=$idParsed) failed.",
        );
      }
    }

    return Response.ok(jsonEncode(histories));
  }

  Future<Response> getOne(Request request, String id) async {
    final idParsed = int.tryParse(id);
    if (idParsed == null) {
      return Response.notFound(
        jsonEncode(
          ErrorResponse(
            ErrorCode.notFound,
            "Station id must be an integer!",
          ).toJson(),
        ),
      );
    }
    final stationAndSensors = await _stationService.getStationAndSensorsById(
      id: idParsed,
    );

    if (stationAndSensors == null) {
      return Response.notFound(
        jsonEncode(
          ErrorResponse(ErrorCode.notFound, "Invalid station id!").toJson(),
        ),
      );
    }

    final jsonBody = jsonEncode(stationAndSensors.toJson());
    return Response.ok(jsonBody);
  }

  Future<Response> live(Request request, String id) async {
    final idParsed = int.tryParse(id);
    if (idParsed == null) {
      return Response.notFound(
        jsonEncode(
          ErrorResponse(
            ErrorCode.notFound,
            "Station id must be an integer!",
          ).toJson(),
        ),
      );
    }
    final station = await _stationService.getById(id: idParsed);
    if (station == null) {
      return Response.notFound(
        jsonEncode(
          ErrorResponse(ErrorCode.notFound, "Invalid station id!").toJson(),
        ),
      );
    }

    final handler = webSocketHandler((webSocket, _) {
      _liveSocketService.handleWebsocketConnection(webSocket, station);
    });

    return handler(request);
  }
}
