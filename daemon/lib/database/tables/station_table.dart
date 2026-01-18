import 'package:drift/drift.dart';

class StationTable extends Table {
  IntColumn get id => integer().autoIncrement()();
  TextColumn get name => text().unique().withLength(min: 1)();
  DateTimeColumn get createdAt => dateTime()();
  RealColumn get longitude => real()();
  RealColumn get latitude => real()();
  IntColumn get version => integer()();
}
