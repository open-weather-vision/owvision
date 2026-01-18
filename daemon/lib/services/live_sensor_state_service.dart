import 'dart:async';
import 'dart:convert';

import 'package:daemon/services/live_service.dart';
import 'package:daemon/services/templates/live_based_service.dart';
import 'package:injectable/injectable.dart';
import 'package:shared/logger/logger.dart';
import 'package:shared/models/station_live_state.dart';
import 'package:web_socket_channel/web_socket_channel.dart';

import '../models/station_info.dart';
import '../models/station_and_sensors.dart';

@singleton
/// Responsible for keeping the sensor state for each station in memory and transmitting it to any connected live websocket
class LiveSensorStateService extends LiveBasedService {
  final Map<int, StationLiveState> _liveState = {};
  LiveSensorStateService(super.liveService, super.stationService);

  @override
  void onStationTracked(StationAndSensors station) {
    logger.info(
      "Tracking sensor states of station with id=${station.info.id}!",
    );
    _liveState[station.info.id] = StationLiveState.fromSensors(station.sensors);
  }

  @override
  void onStationUntracked(int stationId) {
    logger.info(
      "Stopped tracking sensor states of station with id=$stationId}!",
    );
  }

  @override
  void onUpdate(StationAndSensors station, SensorUpdate update) {
    final stateForStation = _liveState[station.info.id];
    if (stateForStation == null) {
      logger.warning(
        "Failed to update sensor state of station with id=${station.info.id}. No state available!",
      );
      return;
    }
    stateForStation.update(update.sensor.name, update.state);
    logger.info(
      "[live update] ${station.info.name} (id=${station.info.id}): ${update.sensor.name}=${update.state.value} (${update.state.createdAt})",
    );
  }

  void handleWebsocketConnection(
    WebSocketChannel webSocket,
    StationInfo station,
  ) async {
    logger.info(
      "User started listening to weather station live data of '${station.name}'",
    );

    final currentLiveState = _liveState[station.id];
    if (currentLiveState == null) {
      logger.severe(
        "Live socket error: No live state available for station with id ${station.id}!",
      );
    } else {
      webSocket.sink.add(jsonEncode(currentLiveState.toJson()));
    }
    final timer = Timer.periodic(Duration(seconds: 5), (_) {
      final currentLiveState = _liveState[station.id];
      if (currentLiveState == null) {
        logger.severe(
          "Live socket error: No live state available for station with id=${station.id}!",
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
