import 'dart:convert';
import 'dart:io';

import 'package:owvision_daemon_client_dart/owvision_daemon_client_dart.dart';
import 'package:shared/utils.dart';

class CliConfig {
  static final _configFile = File(
    "${getOwvisionHomeDirectory()}/cli_config.json",
  );

  int? selectedStationId;
  String? apiToken;
  String daemonHost = OwvisionDaemonClientDart.basePath;

  CliConfig() {
    if (_configFile.existsSync()) {
      Map<String, dynamic> json = jsonDecode(_configFile.readAsStringSync());
      selectedStationId = json['selectedStationId'];
      apiToken = json['apiToken'];
      daemonHost = json['daemonHost'] ?? OwvisionDaemonClientDart.basePath;
    } else {
      _configFile.createSync(recursive: true);
      save();
    }
  }

  static Future<void> removeConfigFile() async {
    try {
      await _configFile.delete();
    } catch (_) {}
  }

  void save() {
    String json = jsonEncode({
      "selectedStationId": selectedStationId,
      "apiToken": apiToken,
      "daemonHost": daemonHost,
    });
    _configFile.writeAsStringSync(json);
  }
}
