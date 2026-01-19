import 'dart:async';
import 'dart:ui';

import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class ConfigRepository {
  final _storage = const FlutterSecureStorage();
  final _controller = StreamController<AppConfig>.broadcast();

  static const _keyUrl = 'api_url';
  static const _keyToken = 'api_token';
  static const _keyDarkMode = 'dark_mode';

  Stream<AppConfig> get configStream => _controller.stream;

  Future<AppConfig> loadConfig() async {
    final url = await _storage.read(key: _keyUrl);
    final token = await _storage.read(key: _keyToken);
    final darkModeRaw = await _storage.read(key: _keyDarkMode);
    _controller.add(
      AppConfig(
        apiUrl: url ?? "",
        apiToken: token ?? "",
        darkMode: darkModeRaw == null ? null : darkModeRaw == "true",
      ),
    );

    return AppConfig(
      apiUrl: url ?? 'https://localhost:8080/',
      apiToken: token ?? '',
    );
  }

  Future<void> saveConfig(AppConfig config) async {
    await _storage.write(key: _keyUrl, value: config.apiUrl);
    await _storage.write(key: _keyToken, value: config.apiToken);
    await _storage.write(key: _keyDarkMode, value: config.darkMode.toString());
    _controller.add(config);
  }
}

class AppConfig {
  final String apiUrl;
  final String apiToken;
  late final bool darkMode;

  AppConfig({this.apiUrl = '', this.apiToken = '', bool? darkMode}) {
    this.darkMode =
        darkMode ??
        PlatformDispatcher.instance.platformBrightness == Brightness.dark;
  }

  // Hilfreich für Updates, wenn man nur einen Wert ändern will
  AppConfig copyWith({String? apiUrl, String? apiToken, bool? darkMode}) {
    return AppConfig(
      apiUrl: apiUrl ?? this.apiUrl,
      apiToken: apiToken ?? this.apiToken,
      darkMode: darkMode ?? this.darkMode,
    );
  }
}
