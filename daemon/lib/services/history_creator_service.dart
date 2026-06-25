import 'package:daemon/locator.dart';
import 'package:daemon/services/history_service.dart';
import 'package:daemon/services/live_service.dart';
import 'package:daemon/services/templates/live_based_service.dart';
import 'package:injectable/injectable.dart';
import 'package:shared/logger/logger.dart';

import '../models/history_record.dart';
import '../models/station_and_sensors.dart';

@singleton
/// Creates an history record for each sensor periodically.
class HistoryCreatorService extends LiveBasedService {
  final Map<int, HistoryState> _historyState = {};

  HistoryCreatorService(super.liveService, super.stationService);

  @override
  Future<void> onUpdate(StationAndSensors station, SensorUpdate update) async {
    final historyState = _historyState[station.info.uuid];
    if (historyState == null) {
      logger.severe(
        "Failed to update sensor state of station with id=${station.info.uuid}. No history state available!",
      );
      return;
    }
    try {
      await historyState.update(station, update);
    } catch (e) {
      logger.severe(
        "Failed to update sensor state of station with id=${station.info.uuid}: $e",
      );
    }
  }

  @override
  Future<void> onStationTracked(StationAndSensors station) async {
    try {
      _historyState[station.info.uuid] = await HistoryState.create(station);
    } catch (e) {
      logger.severe(
        "Failed to create history state for station with id=${station.info.uuid}: $e",
      );
    }
  }

  @override
  Future<void> onStationUntracked(int stationId) async {
    _historyState.remove(stationId);
  }
}

class HistoryState {
  final Map<int, HistoryRecord?> latestSensorUpdates;
  // final Map<int, SensorUpdate?> previousValidSensorUpdate;

  HistoryState(this.latestSensorUpdates /* this.previousValidSensorUpdate*/);

  static Future<HistoryState> create(StationAndSensors station) async {
    return HistoryState(
      await getIt<HistoryService>().getLatestRecordForEachSensor(station),
      // {for (final sensor in station.sensors) sensor.id: null},
    );
  }

  Future<void> update(StationAndSensors station, SensorUpdate update) async {
    final latestUpdateOfSensor = latestSensorUpdates[update.sensor.id];
    if (latestUpdateOfSensor == null ||
        update.state.createdAt.difference(latestUpdateOfSensor.createdAt) >
            Duration(seconds: update.sensor.historyIntervalSeconds)) {
      final newRecord = HistoryRecord(
        value: update.state.value?.value,
        createdAt: update.state.createdAt, // TODO: Fix drift
        sensorId: update.sensor.id,
      );
      final success = await getIt<HistoryService>().insert(newRecord);
      if (success) {
        latestSensorUpdates[update.sensor.id] = newRecord;
        logger.info(
          "[history record] ${station.info.name} (id=${station.info.uuid}): ${update.sensor.name}=${update.state.value} (${update.state.createdAt})",
        );
      }
    }
  }
}
