import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:dashboard/log.dart';
import 'package:dio/io.dart';
import 'package:flutter/foundation.dart';
import 'package:owvision_daemon_client_dart/owvision_daemon_client_dart.dart';
import 'package:shared/models/station_live_state.dart';
import 'package:web_socket_channel/io.dart';
import 'package:web_socket_channel/web_socket_channel.dart';

import 'config_repository.dart';

class ConnectionCanceller {
  bool _isCancelled = false;
  late final Future<void> _future;
  void Function()? _onCancel;

  ConnectionCanceller(
    Future<void> Function(ConnectionCanceller canceller) connect,
  ) {
    _future = connect(this);
  }

  bool get isCancelled => _isCancelled;

  void onCancel(void Function() onCancel) {
    if (isCancelled) {
      onCancel();
    } else {
      _onCancel = onCancel;
    }
  }

  Future<void> cancel() async {
    _isCancelled = true;
    if (_onCancel != null) _onCancel!();
    await _future;
  }
}

class DaemonRepository {
  late OwvisionDaemonClientDart _client;
  AppConfig? _cachedConfig;
  final ConfigRepository _configRepository;

  Future<AppConfig> get currentConfig async =>
      _cachedConfig ?? await _configRepository.loadConfig();

  DaemonRepository({required ConfigRepository configRepository})
    : _configRepository = configRepository {
    _configRepository.configStream.listen((config) {
      _cachedConfig = config;
      recreateClient(config.apiUrl, config.apiToken);
    });
  }

  HttpClient _createInsecureClient() {
    final client = HttpClient();
    client.badCertificateCallback = (cert, host, port) => true;
    return client;
  }

  void recreateClient(String baseUrl, String token) {
    _client = OwvisionDaemonClientDart(basePathOverride: baseUrl);
    if (!kIsWeb) {
      (_client.dio.httpClientAdapter as IOHttpClientAdapter).createHttpClient =
          _createInsecureClient;
    }
    _client.setBearerAuth("BearerAuth", token);
  }

  Future<StationAndSensors?> getStation(int id) async {
    Log.info("Fetching station...");
    final response = await _client.getStationApi().stationOne(id: id);
    Log.info("Fetched station!");
    return response.data;
  }

  Future<List<WeatherStation>> getStations() async {
    Log.info("Fetching stations...");
    final response = await _client.getStationApi().stationAll();
    Log.info("Fetched stations!");
    return response.data ?? [];
  }

  Future<List<SensorHistory>> getSensorHistory(
    int id,
    DateTime from,
    DateTime to,
  ) async {
    final response = await _client.getStationApi().stationHistory(
      id: id,
      from: from,
      to: to,
    );

    return response.data ?? [];
  }

  Future<ConnectionCanceller> stableConnectionToStationLiveSocket(
    void Function(StationLiveState, StationAndSensors) onUpdate,
    void Function() onTemporaryConnectionLoss, {
    int? id,
  }) async {
    await currentConfig;
    var firstConnect = true;
    var hasBeenConnectedBefore = false;
    return ConnectionCanceller((canceller) async {
      while (!canceller.isCancelled) {
        if (!firstConnect) {
          Log.warn("Waiting 10 seconds before retrying to connect...");
          if (hasBeenConnectedBefore) {
            onTemporaryConnectionLoss();
          }
          await Future.delayed(Duration(seconds: 10));
        }
        firstConnect = false;
        try {
          Log.warn("Connecting to station...");
          // 1. Find a station to connect to
          if (id == null) {
            final stations = await getStations();
            if (stations.isEmpty) {
              throw Exception("No station available to connect!");
            } else {
              id = stations[0].id;
            }
          }
          // 2. Connect to the web socket
          late final WebSocketChannel connection;
          if (kIsWeb) {
            connection = WebSocketChannel.connect(
              Uri.parse(
                "${(await currentConfig).apiUrl.replaceFirst("http", "ws")}/stations/$id/live",
              ),
              protocols: ["auth.bearer.${(await currentConfig).apiToken}}"],
            );
          } else {
            connection = IOWebSocketChannel.connect(
              "${(await currentConfig).apiUrl.replaceFirst("http", "ws")}/stations/$id/live",
              headers: {
                "Authorization": "Bearer ${(await currentConfig).apiToken}",
              },
              customClient: _createInsecureClient(),
            );
          }
          await connection.ready;

          // 3. Get station information
          final station = await getStation(id!);

          if (station == null) {
            throw Exception("Failed to get station information!");
          }

          final completer = Completer();

          // 4. Update live state
          connection.stream.listen(
            (message) {
              final Map<String, dynamic> response = jsonDecode(message);
              onUpdate(StationLiveState.fromJson(response), station);
              hasBeenConnectedBefore = true;
            },
            onError: (error) {
              completer.completeError(error);
            },
            onDone: () {
              completer.complete();
            },
            cancelOnError: true,
          );

          canceller.onCancel(() {
            connection.sink.close();
          });

          await completer.future;
        } catch (err) {
          Log.error("Suddenly disconnected from socket: $err");
        }
      }
      Log.info("Successfully disconnected from weather station live socket!");
    });
  }
}
