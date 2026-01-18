import 'package:daemon/database/database.dart';
import 'package:drift/drift.dart';
import 'package:injectable/injectable.dart';
import 'package:shared/logger/logger.dart';

import '../models/history_record.dart';
import '../models/station_and_sensors.dart';

@singleton
class HistoryRepository {
  final AppDatabase _database;

  static HistoryRecord fromResult({required HistoryTableData result}) {
    return HistoryRecord(
      value: result.value,
      createdAt: result.createdAt,
      sensorId: result.sensorId,
    );
  }

  HistoryRepository(this._database);

  Future<Map<int, HistoryRecord?>> getLatestRecordForEachSensor(
    StationAndSensors station,
  ) async {
    return {
      for (final sensor in station.sensors)
        sensor.id: await getLatestRecordForSensor(sensor.id),
    };
  }

  Future<HistoryRecord?> getLatestRecordForSensor(int id) async {
    try {
      final result =
          await (_database.select(_database.historyTable)
                ..where((e) => e.sensorId.equals(id))
                ..orderBy([(e) => OrderingTerm.desc(e.createdAt)]))
              .getSingleOrNull();
      return result != null ? fromResult(result: result) : null;
    } catch (e) {
      logger.severe(e);
      return null;
    }
  }

  Future<List<HistoryRecord>> getRecordsInInterval(
    int id, {
    DateTime? from,
    DateTime? to,
  }) async {
    try {
      final query = _database.select(_database.historyTable)
        ..where((r) => r.sensorId.equals(id));
      if (from != null) {
        query.where((r) => r.createdAt.isBiggerOrEqualValue(from));
      }
      if (to != null) {
        query.where((r) => r.createdAt.isSmallerOrEqualValue(to));
      }
      return (await query.get()).map((r) => fromResult(result: r)).toList();
    } catch (e) {
      logger.severe(e);
      return [];
    }
  }

  Future<bool> insert(HistoryRecord record) async {
    try {
      await _database
          .into(_database.historyTable)
          .insert(
            HistoryTableCompanion.insert(
              sensorId: record.sensorId,
              createdAt: record.createdAt,
              value: Value(record.value),
            ),
          );
      return true;
    } catch (e) {
      logger.severe("Failed to insert history record: $e");
      return false;
    }
  }
}
