import 'dart:convert';
import 'dart:io';

import 'package:json_annotation/json_annotation.dart';
import 'package:shared/logger/logger.dart';
import 'package:shared/utils.dart';

part 'daemon_config.g.dart';

@JsonSerializable()
class DaemonConfig {
  static const int latestVersion = 1;
  static final _daemonConfigFile = File(
    "${getOwvisionHomeDirectory()}/daemon_config.json",
  );

  final int grpcLocalPort;
  final int restApiLocalPort;
  final int grpcPublicPort;
  final int restApiPublicPort;
  final bool production;
  String publicHostName;
  bool initialized;
  int version;

  DaemonConfig({
    required this.grpcPublicPort,
    required this.grpcLocalPort,
    required this.restApiPublicPort,
    required this.restApiLocalPort,
    required this.production,
    required this.publicHostName,
    required this.version,
    required this.initialized,
  });

  static DaemonConfig fromFileSync() {
    logger.info("Reading daemon config from file");
    late final DaemonConfig config;
    try {
      config = DaemonConfig.fromJson(
        jsonDecode(_daemonConfigFile.readAsStringSync()),
      );
      logger.info("Read daemon config: $config");
      if (config.version < DaemonConfig.latestVersion) {
        logger.warning(
          "Config is outdated (${config.version} < ${DaemonConfig.latestVersion})",
        );
        config.migrate();
      }
    } catch (e) {
      config = DaemonConfig(
        restApiLocalPort: 7070,
        restApiPublicPort: 8080,
        grpcLocalPort: 7071,
        grpcPublicPort: 8081,
        production: false,
        publicHostName: "0.0.0.0",
        version: DaemonConfig.latestVersion,
        initialized: false,
      );
      logger.warning(
        "Failed to read daemon config. Falling back to defaults: $config",
      );
      config.saveToFile().catchError(
        (e) => {
          logger.warning(
            "Error while saving daemon config in background: ${e.toString()}",
          ),
        },
      );
    }
    return config;
  }

  factory DaemonConfig.fromJson(Map<String, dynamic> json) =>
      _$DaemonConfigFromJson(json);

  Future<void> saveToFile() async {
    await _daemonConfigFile.writeAsString(jsonEncode(toJson()));
  }

  @override
  String toString() {
    return "(publicHostname=$publicHostName, grpcLocalPort=$grpcLocalPort, grpcPublicPort=$grpcPublicPort, restApiLocalPort=$restApiLocalPort, restApiPublicPort=$restApiPublicPort, production=$production)";
  }

  Map<String, dynamic> toJson() => _$DaemonConfigToJson(this);

  Future<void> migrate() async {
    // To support older config versions add code to migrate here
    version = DaemonConfig.latestVersion;
    await saveToFile();
    logger.info("Successfully migrated config to version $version");
  }

  static Future<void> removeConfigFile() async {
    try {
      await _daemonConfigFile.delete();
    } catch (_) {}
  }

  dynamic generateCaddyConfig() {
    final config = {
      "apps": {
        "http": {
          "servers": {
            "srv0": {
              "listen": [":$restApiPublicPort"],
              "routes": [
                {
                  "match": [
                    {
                      "host": [publicHostName],
                    },
                  ],
                  "handle": [
                    {
                      "handler": "subroute",
                      "routes": [
                        {
                          "handle": [
                            {
                              "handler": "reverse_proxy",
                              "upstreams": [
                                {"dial": "127.0.0.1:$restApiLocalPort"},
                              ],
                            },
                          ],
                        },
                      ],
                    },
                  ],
                  "terminal": true,
                },
              ],
            },
            "srv1": {
              "listen": [":$grpcPublicPort"],
              "routes": [
                {
                  "match": [
                    {
                      "host": [publicHostName],
                    },
                  ],
                  "handle": [
                    {
                      "handler": "subroute",
                      "routes": [
                        {
                          "handle": [
                            {
                              "handler": "reverse_proxy",
                              "transport": {
                                "protocol": "http",
                                "versions": ["h2c", "2"],
                              },
                              "upstreams": [
                                {"dial": "127.0.0.1:$grpcLocalPort"},
                              ],
                            },
                          ],
                        },
                      ],
                    },
                  ],
                  "terminal": true,
                },
              ],
            },
          },
        },
      },
    };
    return config;
  }
}
