import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:dio/io.dart';
import 'package:owvision_daemon_client_dart/owvision_daemon_client_dart.dart';
import 'package:shared/logger/logger.dart';
import 'package:shared/models/station_live_state.dart';
import 'package:web_socket_channel/io.dart';

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
  final String _token;
  final String _baseUrl;
  late final OwvisionDaemonClientDart _client;

  HttpClient _createInsecureClient() {
    final client = HttpClient();
    client.badCertificateCallback = (cert, host, port) => true;
    return client;
  }

  DaemonRepository(this._baseUrl, this._token) {
    _client = OwvisionDaemonClientDart(basePathOverride: _baseUrl);
    (_client.dio.httpClientAdapter as IOHttpClientAdapter).createHttpClient =
        _createInsecureClient;
    _client.setBearerAuth("BearerAuth", _token);
  }

  Future<StationAndSensors?> getStation(int id) async {
    logger.info("Fetching station...");
    final response = await _client.getStationApi().stationsOne(id: id);
    logger.info("Fetched station: ${response.data}");
    return response.data;
  }

  Future<List<Station>> getStations() async {
    logger.info("Fetching stations...");
    final response = await _client.getStationApi().stationsAll();
    logger.info("Fetched stations: ${response.data}");
    return response.data ?? [];
  }

  Future<ConnectionCanceller> stableConnectionToStationLiveSocket(
    void Function(StationLiveState, StationAndSensors) onUpdate,
    void Function() onTemporaryConnectionLoss, {
    int? id,
  }) async {
    var firstConnect = true;
    var hasBeenConnectedBefore = false;
    return ConnectionCanceller((canceller) async {
      while (!canceller.isCancelled) {
        if (!firstConnect) {
          logger.warning("Waiting 10 seconds before retrying to connect...");
          if (hasBeenConnectedBefore) {
            onTemporaryConnectionLoss();
          }
          await Future.delayed(Duration(seconds: 10));
        }
        firstConnect = false;
        try {
          logger.warning("Connecting to station...");
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
          final connection = IOWebSocketChannel.connect(
            "${_baseUrl.replaceFirst("http", "ws")}/stations/$id/live",
            headers: {"Authorization": "Bearer $_token"},
            customClient: _createInsecureClient(),
          );
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
          logger.severe("Suddenly disconnected from socket: $err");
        }
      }
      logger.info(
        "Successfully disconnected from weather station live socket!",
      );
    });
  }
}
