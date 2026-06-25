import 'dart:async';
import 'package:daemon/services/templates/station_based_service.dart';
import 'package:events_emitter/listener.dart';

import '../../models/station_and_sensors.dart';
import '../live_service.dart';

/// A live based service is a service that needs to listen to all sensor updates coming from the recorder.
abstract class LiveBasedService extends StationBasedService {
  final Map<String, EventListener<SensorUpdate>> _trackers = {};
  final LiveService liveService;

  LiveBasedService(this.liveService, super.stationService);

  @override
  Future<void> onStationCreate(String stationUuid) async {
    final stationAndSensors = await stationService.getStationAndSensorsByUuid(
      id: stationUuid,
    );
    if (stationAndSensors == null) {
      return;
    }
    _trackers[stationUuid] = await liveService.watchStation(
      stationUuid: stationUuid,
      handler: (update) {
        onUpdate(stationAndSensors, update);
      },
    );
    onStationTracked(stationAndSensors);
  }

  void onStationTracked(StationAndSensors station);
  void onStationUntracked(String stationUuid);
  void onUpdate(StationAndSensors station, SensorUpdate update);

  @override
  void onStationDelete(String stationUuid) {
    _trackers[stationUuid]?.cancel();
    _trackers.remove(stationUuid);
    onStationUntracked(stationUuid);
  }

  @override
  void onStationDeleteAll() {
    for (final stationUuid in _trackers.keys) {
      onStationDelete(stationUuid);
    }
    _trackers.clear();
  }
}
