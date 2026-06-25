import 'package:drift/drift.dart';
import 'package:shared/logger/logger.dart';
import 'package:injectable/injectable.dart';
import 'package:shared/models/sensor.dart';

import '../database/database.dart';
import '../models/station_info.dart';
import '../models/station_and_sensors.dart';
import 'sensor_repository.dart';

@singleton
class StationRepository {
  final AppDatabase _database;

  StationRepository(this._database);

  StationInfo _fromResult({required StationTableData result}) {
    return StationInfo(
      uuid: result.uuid,
      name: result.name,
      createdAt: result.createdAt,
      latitude: result.latitude,
      longitude: result.longitude,
      interfaceName: result.interfaceName,
      configured: result.configured,
    );
  }

  /// Deletes all stations.
  Future<int> deleteAll() async {
    try {
      await _database.delete(_database.sensorTable).go();
      return await _database.delete(_database.stationTable).go();
    } catch (e) {
      logger.severe(e);
      return 0;
    }
  }

  /// Deletes a station.
  Future<bool> deleteOne({required String uuid}) async {
    try {
      int deleted = await (_database.delete(
        _database.stationTable,
      )..where((s) => s.uuid.equals(uuid))).go();
      await (_database.delete(
        _database.sensorTable,
      )..where((s) => s.stationUuid.equals(uuid))).go();
      return deleted != 0;
    } catch (e) {
      logger.severe(e);
      return false;
    }
  }

  /// Checks if a station with the passed uuid already exists.
  Future<bool> exists({required String uuid}) async {
    return (await getByUuid(uuid: uuid)) != null;
  }

  // Gets a station by uuid.
  Future<StationInfo?> getByUuid({required String uuid}) async {
    try {
      final result = await (_database.select(
        _database.stationTable,
      )..where((station) => station.uuid.equals(uuid))).getSingleOrNull();
      return result != null ? _fromResult(result: result) : null;
    } catch (e) {
      logger.severe(e);
      return null;
    }
  }

  // Gets a station by uuid.
  Future<StationAndSensors?> getStationAndSensorsByUuid({
    required String uuid,
  }) async {
    try {
      final station = await getByUuid(uuid: uuid);
      if (station == null) {
        return null;
      }
      final result = await (_database.select(
        _database.sensorTable,
      )..where((s) => s.stationUuid.equals(uuid))).get();
      final sensors = result
          .map((s) => SensorRepository.fromResult(result: s))
          .toList();
      return StationAndSensors(info: station, sensors: sensors);
    } catch (e) {
      logger.severe(e);
      return null;
    }
  }

  /// Creates a weather station and its sensors in a single atomic transaction.
  Future<StationAndSensors> create({
    required StationInfo station,
    required List<Sensor> sensors,
  }) async {
    try {
      return await _database.transaction(() async {
        await _database
            .into(_database.stationTable)
            .insert(
              StationTableCompanion.insert(
                name: Value(station.name),
                interfaceName: station.interfaceName,
                uuid: station.uuid,
                configured: Value(station.configured),
                createdAt: station.createdAt,
                longitude: Value(station.longitude),
                latitude: Value(station.latitude),
              ),
            );
        final insertedSensors = <Sensor>[];
        for (final sensor in sensors) {
          final sensorId = await _database
              .into(_database.sensorTable)
              .insert(
                SensorTableCompanion.insert(
                  name: sensor.name,
                  stationUuid: station.uuid,
                  element: sensor.element,
                  storageUnitId: sensor.storageUnit.id,
                  recordIntervalSeconds: Value(sensor.recordIntervalSeconds),
                  historyIntervalSeconds: Value(sensor.historyIntervalSeconds),
                ),
              );
          insertedSensors.add(
            Sensor(
              id: sensorId,
              name: sensor.name,
              stationUuid: station.uuid,
              element: sensor.element,
              storageUnit: sensor.storageUnit,
              recordIntervalSeconds: sensor.recordIntervalSeconds,
              historyIntervalSeconds: sensor.historyIntervalSeconds,
            ),
          );
        }
        return StationAndSensors(info: station, sensors: insertedSensors);
      });
    } catch (e) {
      logger.severe(e);
      throw Exception("Failed to create station and sensors: ${e.toString()}");
    }
  }

  Future<List<StationInfo>> getAll() async {
    try {
      var stations = await _database.select(_database.stationTable).get();
      return stations.map((s) => _fromResult(result: s)).toList();
    } catch (e) {
      logger.severe(e);
      return [];
    }
  }
}
