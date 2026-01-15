import 'dart:async';
import 'dart:convert';

import 'package:daemon/services/live_service.dart';
import 'package:daemon/services/station_service.dart';
import 'package:events_emitter/listener.dart';
import 'package:injectable/injectable.dart';
import 'package:shared/logger/logger.dart';
import 'package:shared/models/station.dart';
import 'package:shared/models/station_live_state.dart';
import 'package:web_socket_channel/web_socket_channel.dart';

@singleton
class LiveSensorStateService {
  final LiveService _liveService;
  final StationService _stationService;
  final Map<int, StationLiveState> _liveState = {};
  final Map<int, EventListener<SensorUpdate>> _trackers = {};

  LiveSensorStateService(this._liveService, this._stationService);

  Future<void> start() async {
    List<Station> stations = await _stationService.getAll();
    for (final station in stations) {
      _trackStation(station.id);
    }
    _stationService.watch(
      handler: (event, id) async {
        int parsedId = int.parse(id);
        if (event == StationEvent.create) {
          _trackStation(parsedId);
        } else {
          _untrackStation(parsedId);
        }
      },
    );
  }

  Future<void> _trackStation(int stationId) async {
    final stationAndSensors = await _stationService.getStationAndSensorsById(
      id: stationId,
    );
    if (stationAndSensors == null) {
      logger.severe(
        "Added station, but couldn't find it in the database! Cannot track live state.",
      );
      return;
    }
    _liveState[stationId] = StationLiveState.fromSensors(
      stationAndSensors.sensors,
    );
    logger.info("Tracking sensor states of station with id=$stationId");

    _trackers[stationId] = await _liveService.watchStation(
      stationId: stationId,
      handler: (update) {
        _liveState[stationId]!.update(update.sensor.name, update.state);
      },
    );
  }

  void _untrackStation(int stationId) {
    _trackers[stationId]?.cancel();
    _trackers.remove(stationId);
    _liveState.remove(stationId);
  }

  void handleWebsocketConnection(
    WebSocketChannel webSocket,
    Station station,
  ) async {
    logger.info(
      "User listening to weather station live data of '${station.name}'",
    );

    final currentLiveState = _liveState[station.id];
    if (currentLiveState == null) {
      logger.severe(
        "No live state available for station with id ${station.id}!",
      );
    } else {
      webSocket.sink.add(jsonEncode(currentLiveState.toJson()));
    }
    final timer = Timer.periodic(Duration(seconds: 10), (_) {
      final currentLiveState = _liveState[station.id];
      if (currentLiveState == null) {
        logger.severe(
          "No live state available for station with id ${station.id}!",
        );
      } else {
        webSocket.sink.add(jsonEncode(currentLiveState.toJson()));
      }
    });

    webSocket.stream.listen(
      (message) {},
      onDone: () {
        logger.info(
          "User stopped listening to weather station live data of '${station.name}'",
        );
        timer.cancel();
      },
      onError: (error) {
        logger.warning("Live socket connection issue: $error");
        timer.cancel();
      },
    );
  }
}
