import 'dart:async';

import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class ConfigRepository {
  final _storage = const FlutterSecureStorage();
  final _controller = StreamController<AppConfig>.broadcast();

  static const _keyUrl = 'api_url';
  static const _keyToken = 'api_token';

  Stream<AppConfig> get configStream => _controller.stream;

  Future<AppConfig> loadConfig() async {
    final url = await _storage.read(key: _keyUrl);
    final token = await _storage.read(key: _keyToken);
    _controller.add(AppConfig(apiUrl: url ?? "", apiToken: token ?? ""));

    return AppConfig(
      apiUrl: url ?? 'https://localhost:8080/',
      apiToken: token ?? '',
    );
  }

  Future<void> saveConfig(AppConfig config) async {
    await _storage.write(key: _keyUrl, value: config.apiUrl);
    await _storage.write(key: _keyToken, value: config.apiToken);
    _controller.add(config);
  }
}

class AppConfig {
  final String apiUrl;
  final String apiToken;

  const AppConfig({this.apiUrl = '', this.apiToken = ''});

  // Hilfreich für Updates, wenn man nur einen Wert ändern will
  AppConfig copyWith({String? apiBase, String? apiToken}) {
    return AppConfig(
      apiUrl: apiBase ?? this.apiUrl,
      apiToken: apiToken ?? this.apiToken,
    );
  }
}
