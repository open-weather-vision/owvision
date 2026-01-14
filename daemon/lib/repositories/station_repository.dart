import 'package:daemon/database/database.dart';
import 'package:daemon/repositories/sensor_repository.dart';
import 'package:drift/drift.dart';
import 'package:shared/logger/logger.dart';
import 'package:shared/models/sensor.dart';
import 'package:shared/models/station.dart';
import 'package:injectable/injectable.dart';
import 'package:shared/models/station_and_sensors.dart';

@singleton
class StationRepository {
  final AppDatabase _database;

  StationRepository(this._database);

  Station _fromResult({required StationTableData result}) {
    return Station(
      id: result.id,
      name: result.name,
      createdAt: result.createdAt,
      latitude: result.latitude,
      longitude: result.longitude,
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
  Future<bool> deleteOne({required int id}) async {
    try {
      int deleted = await (_database.delete(
        _database.stationTable,
      )..where((s) => s.id.equals(id))).go();
      await (_database.delete(
        _database.sensorTable,
      )..where((s) => s.stationId.equals(id))).go();
      return deleted != 0;
    } catch (e) {
      logger.severe(e);
      return false;
    }
  }

  /// Checks if a station with the passed name already exists.
  Future<bool> exists({required String name}) async {
    return (await getByName(name: name)) != null;
  }

  // Gets a station by name.
  Future<Station?> getByName({required String name}) async {
    try {
      final result = await (_database.select(
        _database.stationTable,
      )..where((station) => station.name.equals(name))).getSingleOrNull();
      return result != null ? _fromResult(result: result) : null;
    } catch (e) {
      logger.severe(e);
      return null;
    }
  }

  // Gets a station by id.
  Future<Station?> getById({required int id}) async {
    try {
      final result = await (_database.select(
        _database.stationTable,
      )..where((station) => station.id.equals(id))).getSingleOrNull();
      return result != null ? _fromResult(result: result) : null;
    } catch (e) {
      logger.severe(e);
      return null;
    }
  }

  // Gets a station by id.
  Future<StationAndSensors?> getStationAndSensorsById({required int id}) async {
    try {
      final station = await getById(id: id);
      if (station == null) {
        return null;
      }
      final result = await (_database.select(
        _database.sensorTable,
      )..where((s) => s.stationId.equals(id))).get();
      final sensors = result
          .map((s) => SensorRepository.fromResult(result: s))
          .toList();
      return StationAndSensors(station: station, sensors: sensors);
    } catch (e) {
      logger.severe(e);
      return null;
    }
  }

  /// Creates a weather station and its sensors in a single atomic transaction.
  Future<StationAndSensors?> create({
    required Station station,
    required List<Sensor> sensors,
  }) async {
    try {
      return await _database.transaction(() async {
        final stationId = await _database
            .into(_database.stationTable)
            .insert(
              StationTableCompanion.insert(
                name: station.name,
                createdAt: station.createdAt,
                longitude: station.longitude,
                latitude: station.latitude,
              ),
            );
        final createdStation = Station(
          id: stationId,
          createdAt: station.createdAt,
          latitude: station.latitude,
          longitude: station.longitude,
          name: station.name,
        );
        final insertedSensors = <Sensor>[];
        for (final sensor in sensors) {
          final sensorId = await _database
              .into(_database.sensorTable)
              .insert(
                SensorTableCompanion.insert(
                  name: sensor.name,
                  stationId: stationId,
                  element: sensor.element,
                  storageUnitId: sensor.storageUnit.id,
                  recordIntervalSeconds: Value(sensor.recordIntervalSeconds),
                ),
              );
          insertedSensors.add(
            Sensor(
              id: sensorId,
              name: sensor.name,
              stationId: stationId,
              element: sensor.element,
              storageUnit: sensor.storageUnit,
              recordIntervalSeconds: sensor.recordIntervalSeconds,
            ),
          );
        }
        return StationAndSensors(
          station: createdStation,
          sensors: insertedSensors,
        );
      });
    } catch (e) {
      logger.severe(e);
      return null;
    }
  }

  Future<List<Station>> getAll() async {
    try {
      var stations = await _database.select(_database.stationTable).get();
      return stations.map((s) => _fromResult(result: s)).toList();
    } catch (e) {
      logger.severe(e);
      return [];
    }
  }
}
