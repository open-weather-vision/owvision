import 'dart:io';

import 'package:shared/utils.dart';

import './tables/sensor_table.dart';
import './tables/token_table.dart';
import './tables/station_table.dart';
import 'package:shared/models/token_role.dart';
import "package:shared/models/sensor.dart";
import 'package:drift/drift.dart';
import 'package:injectable/injectable.dart';
import 'package:drift/native.dart';

part 'database.g.dart';

@DriftDatabase(tables: [StationTable, SensorTable, TokenTable])
@singleton
class AppDatabase extends _$AppDatabase {
  AppDatabase() : super(_openConnection());

  @override
  int get schemaVersion => 1;

  static QueryExecutor _openConnection() {
    return NativeDatabase.createInBackground(
      File('${getOwvisionHomeDirectory()}/data.sqlite'),
    );
  }
}
