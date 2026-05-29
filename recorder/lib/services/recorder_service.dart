import 'dart:async';
import 'dart:collection';

import 'package:fixnum/fixnum.dart';
import 'package:grpc/grpc.dart';
import 'package:injectable/injectable.dart';
import 'package:open_meteo/open_meteo.dart';
import 'package:recorder/cli/entry.dart';
import 'package:recorder/services/status_service.dart';
import 'package:recorder/utils/create_daemon_client.dart';
import 'package:shared/drift_free_timer.dart';
import 'package:shared/grpc/recorder.pbgrpc.dart' as grpc;
import 'package:shared/logger/logger.dart';
import 'package:shared/models/sensor.dart';
import 'package:shared/units/nounit.dart';
import 'package:shared/weather_code.dart';

import '../models/recorder_config.dart';

@singleton
/// Service responsible for managing the connection between the station interface and the central daemon.
///
/// It handles retrieving the station configuration, fetching sensor data at
/// specified intervals, integrating virtual sensors (like Open-Meteo),
/// buffering the results, and uploading them in batches via gRPC.
class RecorderService {
  static const openMeteoCurrentWeatherVirtualSensor =
      "current_weather_openmeteo";
  late grpc.StationInterfaceClient _localStationInterfaceClient;
  late grpc.DaemonServiceClient _daemonClient;
  late grpc.Station _station;
  late grpc.StationDefinition _definition;
  final DataQueue _queue = DataQueue();
  final _timers = <DriftFreeTimer>[];
  final Map<Int64, Future<void>> _sensorFetchLocks = {};
  final _openMeteo = WeatherApi(userAgent: "owvision_recorder");
  bool running = false;

  final StatusService _statusService;

  RecorderService(this._statusService);

  /// Creates a gRPC client to communicate with the local station interface.
  grpc.StationInterfaceClient createLocalStationInterfaceClient() {
    final channel = ClientChannel(
      recorderConfig.interfaceGrpcHost,
      port: recorderConfig.interfaceGrpcPort,
      options: const ChannelOptions(credentials: ChannelCredentials.insecure()),
    );
    return grpc.StationInterfaceClient(channel);
  }

  /// Starts the recorder service.
  ///
  /// This connects to both the interface and the daemon, syncs the station
  /// definition, sets up physical and virtual sensors, and schedules
  /// background tasks for continuous data fetching and batch uploading.
  Future<void> start() async {
    if (running) {
      logger.severe("Already running!");
      return;
    }
    await _statusService.init();
    running = true;
    recorderConfig = RecorderConfig.fromFileSync();
    logger.info(
      "Recorder active, trying to ping station interface on port ${recorderConfig.interfaceGrpcPort}",
    );
    _localStationInterfaceClient = createLocalStationInterfaceClient();
    _daemonClient = createDaemonClient();

    try {
      _definition = await _localStationInterfaceClient.getStationDefinition(
        grpc.GetStationDefinitionRequest(),
      );
      await _statusService.stationResponded();
      if (recorderConfig.stationId == null) {
        logger.info("Station not created yet! Creating...");
        if (recorderConfig.enableVirtualWeatherConditionSensor) {
          logger.info("Adding virtual open meteo weather sensor...");
          _definition.sensors.add(
            grpc.SensorDefinition(
              name: openMeteoCurrentWeatherVirtualSensor,
              recordIntervalSeconds: Int64(60 * 15),
              element: SensorElement.weatherCode.name,
            ),
          );
        }
        _station = await _daemonClient.createStation(_definition);
        await _statusService.daemonResponded();
        recorderConfig.stationId = _station.id.toInt();
        await recorderConfig.saveToFile();
        logger.info("Successfully created station!");
      } else {
        logger.info(
          "Station already created! Checking if definition changed...",
        );
        final oldStation = await _daemonClient.getStation(
          grpc.GetStationRequest(stationId: Int64(recorderConfig.stationId!)),
        );
        await _statusService.daemonResponded();
        if (oldStation.version != _definition.version) {
          logger.info(
            "Station definition changed (v${oldStation.version} -> v${_definition.version}). Applying changes...",
          );
          _station = await _daemonClient.updateStation(
            grpc.UpdateStationRequest(
              stationId: Int64(recorderConfig.stationId!),
              definition: _definition,
            ),
          );
          await _statusService.daemonResponded();
          logger.info("Successfully changed definition!");
        } else {
          logger.info(
            "Station definition is up to date (v${oldStation.version})",
          );
          _station = oldStation;
        }
      }
      for (final sensor in _station.sensors) {
        _fetchSensor(sensor);
        _timers.add(
          DriftFreeTimer(
            Duration(seconds: sensor.recordIntervalSeconds.toInt()),
            (_) async {
              _fetchSensor(sensor);
            },
          ),
        );
      }
      logger.info("Successfully scheduled record timers!");
      await _processLatestBatch();
      _timers.add(
        DriftFreeTimer(Duration(seconds: 10), (_) async {
          await _processLatestBatch();
        }),
      );
    } catch (e) {
      await _statusService.stationDidntRespond();
      logger.warning(
        "Error while communicating with interface: $e. Restarting in 10 seconds...",
      );
      pause();
      await Future.delayed(Duration(seconds: 10));
      return start();
    }
  }

  /// Fetches the current value for a given [sensor] and enqueues an update.
  ///
  /// If the sensor is an Open-Meteo virtual sensor, it queries the weather API.
  /// Otherwise, it requests the state from the connected station interface.
  Future<void> _fetchSensor(grpc.Sensor sensor) async {
    final previousLock = _sensorFetchLocks[sensor.id];
    final completer = Completer<void>();
    _sensorFetchLocks[sensor.id] = completer.future;

    if (previousLock != null) {
      await previousLock;
    }

    try {
      if (sensor.name == openMeteoCurrentWeatherVirtualSensor) {
        // Virtual open meteo server
        try {
          logger.info("Requesting current weather from open meteo...");
          final response = await _openMeteo.request(
            locations: {
              OpenMeteoLocation(
                latitude: _definition.latitude,
                longitude: _definition.longitude,
              ),
            },
            current: {WeatherCurrent.weather_code},
          );
          final code = response
              .segments[0]
              .currentData[WeatherCurrent.weather_code]!
              .value;
          logger.info(
            "Open meteo responded: $code (${weatherCodeToString(code)})",
          );
          await _statusService.openMeteoResponded();
          _queue.enqueueUpdate(
            grpc.UpdateSensorRequest(
              sensorId: sensor.id,
              newState: grpc.SensorState(
                createdAt: Int64(DateTime.now().millisecondsSinceEpoch),
                value: code,
                unitId: NoUnit.none.id,
              ),
            ),
          );
        } catch (e) {
          logger.warning(
            "Failed to get current weather conditions from open meteo! $e",
          );
          await _statusService.openMeteoDidntRespond();
        }
      } else {
        // Common sensors
        try {
          final state = await _localStationInterfaceClient.getSensorState(
            grpc.GetSensorStateRequest(name: sensor.name),
          );
          await _statusService.stationResponded();
          _queue.enqueueUpdate(
            grpc.UpdateSensorRequest(sensorId: sensor.id, newState: state),
          );
        } catch (e) {
          await _statusService.stationDidntRespond();
          logger.warning(
            "Failed to get value from sensor ${sensor.name} (${_station.id}): $e",
          );
        }
      }
    } finally {
      completer.complete();
      if (_sensorFetchLocks[sensor.id] == completer.future) {
        _sensorFetchLocks.remove(sensor.id);
      }
    }
  }

  /// Takes a batch from the queue and attempts to send it to the daemon.
  ///
  /// If successful, the transferred items are permanently removed from the queue.
  Future<void> _processLatestBatch() async {
    final batch = _queue.takeBatch();
    final processed = <Int64>[];
    if (batch.isNotEmpty) {
      try {
        final response = await _daemonClient.updateSensors(
          grpc.UpdateSensorsRequest(updates: batch),
        );
        await _statusService.daemonResponded();

        for (final updateResp in response.updates) {
          processed.add(updateResp.updateId);
          if (!updateResp.success) {
            logger.warning(
              "Update ${updateResp.updateId} failed via daemon: ${updateResp.error}",
            );
          }
        }
      } catch (e) {
        await _statusService.daemonDidntRespond();
        logger.warning(
          "An error occurred while processing an update batch: $e",
        );
      }
      _queue.removeBatch(processed);
      logger.info(
        "Successfully processed ${processed.length}/${batch.length} updates!",
      );
    }
  }

  /// Pauses all recurring tasks and timers in the recorder service.
  void pause() {
    for (final timer in _timers) {
      timer.cancel();
    }
    running = false;
    logger.info("Paused recorder service");
  }
}

/// A local buffer for out-bound sensor updates before they reach the daemon.
///
/// The queue enforces a [maxQueueSize] and processes items in chunks of [maxBatchSize].
class DataQueue {
  final Queue<grpc.UpdateSensorRequest> _buffer = Queue();
  static const int maxBatchSize = 20;
  static const int maxQueueSize = 5000;
  Int64 _currentUpdateIndex = Int64(0);

  /// Enqueues a new update request, assigning it an incremental update index.
  ///
  /// If the buffer size exceeds [maxQueueSize], the oldest update is dropped.
  void enqueueUpdate(grpc.UpdateSensorRequest request) {
    request.updateId = _currentUpdateIndex++;
    if (_buffer.length >= maxQueueSize) {
      _buffer.removeFirst();
      logger.warning("Buffer (data queue) is full. Removed oldest update.");
    }
    _buffer.addLast(request);
  }

  /// Returns a chunk of up to [maxBatchSize] updates to be sent.
  List<grpc.UpdateSensorRequest> takeBatch() {
    return _buffer.take(maxBatchSize).toList();
  }

  /// Removes updates from the buffer that have been successfully processed.
  void removeBatch(List<Int64> processedUpdates) {
    for (final updateId in processedUpdates) {
      _buffer.removeWhere((u) => u.updateId == updateId);
    }
  }
}
