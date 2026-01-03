import 'dart:async';
import 'dart:collection';

import 'package:fixnum/fixnum.dart';
import 'package:grpc/grpc.dart';
import 'package:injectable/injectable.dart';
import 'package:recorder/cli/entry.dart';
import 'package:recorder/services/status_service.dart';
import 'package:recorder/utils/create_daemon_client.dart';
import 'package:shared/grpc/recorder.pbgrpc.dart';
import 'package:shared/logger/logger.dart';
import 'package:shared/models/recorder_config.dart';

@singleton
class RecorderService {
  late StationInterfaceClient _stationInterfaceClient;
  late DaemonServiceClient _daemonClient;
  late Station _station;
  final DataQueue _queue = DataQueue();
  final _timers = <Timer>[];
  bool running = false;

  final StatusService _statusService;

  RecorderService(this._statusService);

  StationInterfaceClient createStationInterfaceClient() {
    final channel = ClientChannel(
      recorderConfig.interfaceGrpcHost,
      port: recorderConfig.interfaceGrpcPort,
      options: const ChannelOptions(credentials: ChannelCredentials.insecure()),
    );
    return StationInterfaceClient(channel);
  }

  Future<void> start() async {
    if (running) {
      logger.severe("Already running!");
      return;
    }
    await _statusService.init();
    running = true;
    while (!recorderConfig.active) {
      logger.warning("Recorder in idle state..");
      await Future.delayed(Duration(seconds: 10));
      recorderConfig = RecorderConfig.fromFileSync();
    }
    logger.info(
      "Recorder active, trying to ping station interface on port ${recorderConfig.interfaceGrpcPort}",
    );
    _stationInterfaceClient = createStationInterfaceClient();
    _daemonClient = createDaemonClient();

    try {
      final definition = await _stationInterfaceClient.getStationDefinition(
        GetStationDefinitionRequest(),
      );
      _statusService.stationResponded();
      if (recorderConfig.stationId == null) {
        logger.info("Station not created yet! Creating...");
        _station = await _daemonClient.createStation(definition);
        _statusService.daemonResponded();
        logger.info("Successfully created station!");
      } else {
        logger.info(
          "Station already created! Checking if definition changed...",
        );
        final oldStation = await _daemonClient.getStation(
          GetStationRequest(stationId: Int64(recorderConfig.stationId!)),
        );
        _statusService.daemonResponded();
        if (oldStation.version != definition.version) {
          logger.info(
            "Station definition changed (v${oldStation.version} -> v${definition.version}). Applying changes...",
          );
          _station = await _daemonClient.updateStation(
            UpdateStationRequest(
              stationId: Int64(recorderConfig.stationId!),
              definition: definition,
            ),
          );
          _statusService.daemonResponded();
          recorderConfig.stationId = _station.id.toInt();
          await recorderConfig.saveToFile();
          logger.info("Successfully changed definition!");
        } else {
          logger.info(
            "Station definition is up to date (v${oldStation.version})",
          );
          _station = oldStation;
        }
      }
      for (final sensor in _station.sensors) {
        _timers.add(
          Timer.periodic(
            Duration(seconds: sensor.recordIntervalSeconds.toInt()),
            (_) async {
              try {
                final state = await _stationInterfaceClient.getSensorState(
                  GetSensorStateRequest(name: sensor.name),
                );
                _statusService.stationResponded();
                _queue.enqueueUpdate(
                  UpdateSensorRequest(sensorId: sensor.id, newState: state),
                );
              } catch (e) {
                _statusService.stationDidntRespond();
                logger.warning(
                  "Failed to get value from sensor ${sensor.name} (${_station.id}): $e",
                );
              }
            },
          ),
        );
      }
      logger.info("Successfully scheduled record timers!");

      _timers.add(
        Timer.periodic(Duration(seconds: 10), (_) async {
          final batch = _queue.takeBatch();
          final processed = <UpdateSensorRequest>[];
          if (batch.isNotEmpty) {
            String? error;
            try {
              final response = await _daemonClient.updateSensors(
                UpdateSensorsRequest(updates: batch),
              );
              _statusService.daemonResponded();
              if (response.errors.isNotEmpty) {
                error = response.errors.join("\n");
              }
              for (final updateIndex in response.processed) {
                processed.add(batch.elementAt(updateIndex));
              }
            } catch (e) {
              _statusService.daemonDidntRespond();
              error = "Failed to connect to daemon server ($e)!";
            }
            if (error != null) {
              logger.warning(
                "An error occurred while processing an update batch: $error",
              );
            }
            _queue.removeBatch(processed);
            logger.info(
              "Successfully processed ${processed.length}/${batch.length} updates!",
            );
          }
        }),
      );
    } catch (e) {
      _statusService.stationDidntRespond();
      logger.warning(
        "Error while communicating with interface: $e. Restarting in 10 seconds...",
      );
      pause();
      await Future.delayed(Duration(seconds: 10));
      return start();
    }
  }

  void pause() {
    for (final timer in _timers) {
      timer.cancel();
    }
    running = false;
    logger.info("Paused recorder service");
  }
}

class DataQueue {
  final Queue<UpdateSensorRequest> _buffer = Queue();
  int maxBatchSize = 20;

  void enqueueUpdate(UpdateSensorRequest request) {
    _buffer.addLast(request);
  }

  List<UpdateSensorRequest> takeBatch() {
    return _buffer.take(maxBatchSize).toList();
  }

  void removeBatch(List<UpdateSensorRequest> processedUpdates) {
    _buffer.removeWhere((u) => processedUpdates.contains(u));
  }
}
