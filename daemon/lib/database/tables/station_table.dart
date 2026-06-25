import 'package:drift/drift.dart';
import 'package:shared/pretty_print.dart';

class StationTable extends Table {
  TextColumn get uuid => text().unique().withLength(max: 36, min: 36)();
  TextColumn get name => text().nullable().unique().withLength(min: 1)();
  DateTimeColumn get createdAt => dateTime()();
  RealColumn get longitude => real().nullable()();
  RealColumn get latitude => real().nullable()();
  TextColumn get interfaceName => text()();
  BoolColumn get configured => boolean().withDefault(const Constant(false))();
}
