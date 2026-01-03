import 'package:drift/drift.dart';
import 'package:shared/models/token_role.dart';

class TokenTable extends Table {
  TextColumn get token => text().unique()();
  TextColumn get role => textEnum<TokenRole>()();
}
