import 'package:daemon/database/tables/sensor_table.dart';
import 'package:drift/drift.dart';

@TableIndex(
  name: 'history_sensor_created_idx',
  columns: {#sensorId, #createdAt},
)
class HistoryTable extends Table {
  IntColumn get id => integer().autoIncrement()();
  IntColumn get sensorId => integer().references(
    SensorTable,
    #id,
    onDelete: KeyAction.cascade,
    onUpdate: KeyAction.cascade,
  )();
  RealColumn get value => real().nullable()();
  DateTimeColumn get createdAt => dateTime()();

  @override
  List<Set<Column>> get customUniqueKeys => [
    {sensorId, createdAt},
  ];
}
