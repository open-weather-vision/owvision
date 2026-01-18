import 'dart:async';
import 'package:daemon/services/templates/station_based_service.dart';
import 'package:events_emitter/listener.dart';

import '../../models/station_and_sensors.dart';
import '../live_service.dart';

/// A live based service is a service that needs to listen to all sensor updates coming from the recorder.
abstract class LiveBasedService extends StationBasedService {
  final Map<int, EventListener<SensorUpdate>> _trackers = {};
  final LiveService liveService;

  LiveBasedService(this.liveService, super.stationService);

  @override
  Future<void> onStationCreate(int stationId) async {
    final stationAndSensors = await stationService.getStationAndSensorsById(
      id: stationId,
    );
    if (stationAndSensors == null) {
      return;
    }
    _trackers[stationId] = await liveService.watchStation(
      stationId: stationId,
      handler: (update) {
        onUpdate(stationAndSensors, update);
      },
    );
    onStationTracked(stationAndSensors);
  }

  void onStationTracked(StationAndSensors station);
  void onStationUntracked(int stationId);

  void onUpdate(StationAndSensors station, SensorUpdate update);

  @override
  void onStationDelete(int stationId) {
    _trackers[stationId]?.cancel();
    _trackers.remove(stationId);
    onStationUntracked(stationId);
  }
}
