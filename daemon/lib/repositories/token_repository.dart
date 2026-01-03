import 'dart:convert';

import 'package:crypto/crypto.dart';
import 'package:daemon/database/database.dart';
import 'package:injectable/injectable.dart';
import 'package:shared/logger/logger.dart';
import 'package:shared/models/token.dart';
import 'package:shared/models/token_role.dart';
import 'package:uuid/uuid.dart';

@singleton
class TokenRepository {
  final AppDatabase _database;
  final uuid = Uuid();

  TokenRepository(this._database);

  static Token fromResult({required TokenTableData result}) {
    return Token(token: result.token, role: result.role);
  }

  String _hashToken(String plainToken) {
    return sha256.convert(utf8.encode(plainToken)).toString();
  }

  Future<void> insertInitializationTokenIfThereIsNone() async {
    final hashedToken = _hashToken("%12345678%");
    final token = await _database
        .select(_database.tokenTable)
        .getSingleOrNull();
    if (token == null) {
      await _database
          .into(_database.tokenTable)
          .insert(
            TokenTableCompanion.insert(
              token: hashedToken,
              role: TokenRole.initialize,
            ),
          );
      logger.info("Inserted init token!");
    }
  }

  Future<List<Token>> getAll({TokenRole? role}) async {
    final query = _database.select(_database.tokenTable);
    if (role != null) {
      query.where((t) => t.role.equals(role.name));
    }
    final result = await query.get();
    return result.map((t) => fromResult(result: t)).toList();
  }

  Future<String> generateToken({required TokenRole role}) async {
    final plainToken = uuid.v4();
    final hashedToken = _hashToken(plainToken);
    await _database
        .into(_database.tokenTable)
        .insert(TokenTableCompanion.insert(token: hashedToken, role: role));
    return plainToken;
  }

  Future<Token?> getToken({required String token}) async {
    final hashedToken = _hashToken(token);
    final result = await (_database.select(
      _database.tokenTable,
    )..where((t) => t.token.equals(hashedToken))).getSingleOrNull();
    return result != null ? fromResult(result: result) : null;
  }

  Future<bool> checkToken({
    required TokenRole role,
    required String token,
  }) async {
    final hashedToken = _hashToken(token);
    final result = await (_database.select(
      _database.tokenTable,
    )..where((t) => t.token.equals(hashedToken))).getSingleOrNull();

    return result != null &&
        (result.role == role || result.role == TokenRole.admin);
  }
}
