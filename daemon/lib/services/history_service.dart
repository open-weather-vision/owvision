import 'package:daemon/models/history_record.dart';
import 'package:daemon/models/sensor_history.dart';
import 'package:daemon/models/station_and_sensors.dart';
import 'package:daemon/repositories/history_repository.dart';
import 'package:daemon/repositories/sensor_repository.dart';
import 'package:injectable/injectable.dart';

@singleton
class HistoryService {
  final HistoryRepository _historyRepository;
  final SensorRepository _sensorRepository;

  HistoryService(this._historyRepository, this._sensorRepository);

  Future<bool> insert(HistoryRecord record) async {
    return _historyRepository.insert(record);
  }

  Future<Map<int, HistoryRecord?>> getLatestRecordForEachSensor(
    StationAndSensors station,
  ) async {
    return _historyRepository.getLatestRecordForEachSensor(station);
  }

  Future<SensorHistory?> getSensorHistory({
    required int stationId,
    required String sensorName,
    DateTime? from,
    DateTime? to,
  }) async {
    final sensor = await _sensorRepository.getByNameAndStationId(
      stationId: stationId,
      sensorName: sensorName,
    );
    if (sensor == null) {
      return null;
    }

    final records = await _historyRepository.getRecordsInInterval(
      sensor.id,
      from: from,
      to: to,
    );

    return SensorHistory(sensorName, sensor.storageUnit.id, records);
  }
}
