import 'dart:async';
import 'dart:ui';

import 'package:dashboard/main.dart';
import 'package:flutter_colorpicker/flutter_colorpicker.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class ConfigRepository {
  final _storage = const FlutterSecureStorage();
  final _controller = StreamController<AppConfig>.broadcast();

  static const _keyUrl = 'api_url';
  static const _keyToken = 'api_token';
  static const _keyDarkMode = 'dark_mode';
  static const _keyThemeColor = 'theme_color';

  Stream<AppConfig> get configStream => _controller.stream;

  Future<AppConfig> loadConfig() async {
    final url = await _storage.read(key: _keyUrl);
    final token = await _storage.read(key: _keyToken);
    final darkModeRaw = await _storage.read(key: _keyDarkMode);
    final themeColorRaw = await _storage.read(key: _keyThemeColor);

    final config = AppConfig(
      apiUrl: url ?? "",
      apiToken: token ?? "",
      darkMode: darkModeRaw == null ? null : darkModeRaw == "true",
      themeColor: themeColorRaw == null
          ? null
          : Color(int.parse(themeColorRaw.substring(0, 8), radix: 16)),
    );

    _controller.add(config);

    return config;
  }

  Future<void> saveConfig(AppConfig config) async {
    await _storage.write(key: _keyUrl, value: config.apiUrl);
    await _storage.write(key: _keyToken, value: config.apiToken);
    await _storage.write(key: _keyDarkMode, value: config.darkMode.toString());
    final themeColorString = config.themeColor.toHexString(enableAlpha: false);
    await _storage.write(key: _keyThemeColor, value: themeColorString);

    _controller.add(config);
  }
}

class AppConfig {
  final String apiUrl;
  final String apiToken;
  late final bool darkMode;
  late final Color themeColor;

  AppConfig({
    this.apiUrl = '',
    this.apiToken = '',
    bool? darkMode,
    Color? themeColor,
  }) {
    this.darkMode =
        darkMode ??
        PlatformDispatcher.instance.platformBrightness == Brightness.dark;
    this.themeColor = themeColor ?? defaultThemeColor;
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
