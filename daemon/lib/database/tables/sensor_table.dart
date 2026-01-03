import 'package:daemon/database/tables/station_table.dart';
import 'package:drift/drift.dart';
import "package:shared/models/sensor.dart";

class SensorTable extends Table {
  IntColumn get id => integer().autoIncrement()();
  IntColumn get stationId => integer().references(
    StationTable,
    #id,
    onDelete: KeyAction.cascade,
    onUpdate: KeyAction.cascade,
  )();
  TextColumn get element => textEnum<SensorElement>()();
  TextColumn get storageUnitId => text()();
  TextColumn get name => text()();
  IntColumn get recordIntervalSeconds =>
      integer().withDefault(const Constant(60))();

  @override
  List<Set<Column>> get uniqueKeys => [
    {stationId, name},
  ];
}
