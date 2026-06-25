import 'package:daemon/database/database.dart';
import 'package:injectable/injectable.dart';
import 'package:path/path.dart';
import 'package:shared/logger/logger.dart';
import 'package:shared/models/sensor.dart';
import 'package:shared/units/convert.dart';
import 'package:drift/drift.dart';

@singleton
class SensorRepository {
  final AppDatabase _database;

  static Sensor fromResult({required SensorTableData result}) {
    return Sensor(
      id: result.id,
      stationUuid: result.stationUuid,
      element: result.element,
      name: result.name,
      storageUnit: Unit.fromId(result.storageUnitId),
      recordIntervalSeconds: result.recordIntervalSeconds,
      historyIntervalSeconds: result.historyIntervalSeconds,
    );
  }

  SensorRepository(this._database);

  Future<Sensor?> getByNameAndStationUuid({
    required String stationUuid,
    required String sensorName,
  }) async {
    try {
      final result =
          await (_database.select(_database.sensorTable)..where(
                (s) =>
                    s.stationUuid.equals(stationUuid) &
                    s.name.equals(sensorName),
              ))
              .getSingle();
      return fromResult(result: result);
    } catch (e) {
      logger.severe(e);
      return null;
    }
  }

  Future<Sensor?> getById({required int id}) async {
    try {
      final result = await (_database.select(
        _database.sensorTable,
      )..where((s) => s.id.equals(id))).getSingle();
      return fromResult(result: result);
    } catch (e) {
      logger.severe(e);
      return null;
    }
  }

  Future<List<Sensor>> getByStationUuid({required String stationUuid}) async {
    try {
      final result = await (_database.select(
        _database.sensorTable,
      )..where((s) => s.stationUuid.equals(stationUuid))).get();
      return result.map((s) => fromResult(result: s)).toList();
    } catch (e) {
      logger.severe(e);
      return [];
    }
  }
}
