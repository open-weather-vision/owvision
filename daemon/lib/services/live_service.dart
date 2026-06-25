import 'package:events_emitter/emitters/event_emitter.dart';
import 'package:events_emitter/listener.dart';
import 'package:fixnum/fixnum.dart';
import 'package:grpc/grpc.dart';
import 'package:injectable/injectable.dart';
import 'package:shared/grpc/recorder.pbgrpc.dart' as grpc;
import 'package:shared/logger/logger.dart';
import 'package:shared/models/sensor.dart';
import 'package:shared/models/sensor_state.dart';
import 'package:shared/models/token_role.dart';
import 'package:shared/units/convert.dart';
import 'package:shared/units/convertible.dart';

import '../database/tables/sensor_table.dart';
import '../exceptions/station_not_found.dart';
import '../locator.dart';
import '../models/station_info.dart';
import 'config_service.dart';
import 'sensor_service.dart';
import 'station_service.dart';
import 'token_service.dart';

@singleton
/// Manages a grpc service that processes weather station updates and create requests from the **recorder**.
class LiveService {
  final _events = EventEmitter();
  late final Server _server;
  final ConfigService _configService;

  EventListener<SensorUpdate>? _sensorUpdateLogs;

  LiveService(
    StationService stationService,
    SensorService sensorService,
    this._configService,
  ) {
    _server = Server.create(
      services: [RecorderService(stationService, sensorService, _events)],
      interceptors: [authInterceptor],
    );
  }

  /// Starts the grpc server on the configured port.
  Future<void> start() async {
    late final ServerCredentials credentials = ServerLocalCredentials();
    await _server.serve(
      port: _configService.config.grpcLocalPort,
      security: credentials,
    );
    logger.info("Live service (grpc) running on 127.0.0.1:${_server.port}");
  }

  /// Logs all live events (`sensor_update`, `station_create`).
  void enableLogs() {
    _sensorUpdateLogs = EventListener("sensor_update", (SensorUpdate update) {
      logger.info(update.toString());
    });
    _events.addEventListener(_sensorUpdateLogs!);
  }

  /// Disables the logging of live events.
  void disableLogs() {
    if (_sensorUpdateLogs != null) {
      _events.removeEventListener(_sensorUpdateLogs!);
      _sensorUpdateLogs = null;
    }
  }

  /// Registers a handler that gets executed everytime the recorder sends a new sensor update.
  Future<EventListener<SensorUpdate>> watchStation({
    required String stationUuid,
    required Function(SensorUpdate) handler,
  }) async {
    final station = await getIt<StationService>().getByUuid(uuid: stationUuid);
    if (station == null) {
      throw StationNotFoundException(stationUuid);
    }
    final listener = EventListener("sensor_update", (SensorUpdate update) {
      if (update.sensor.stationUuid == station.uuid) {
        handler(update);
      }
    });
    _events.addEventListener(listener);
    return listener;
  }

  void stopWatchingStation(EventListener<SensorUpdate> listener) {
    _events.removeEventListener(listener);
  }
}

Future<GrpcError?> authInterceptor(
  ServiceCall call,
  ServiceMethod method,
) async {
  final metadata = call.clientMetadata;
  final tokenHeader = metadata?['authorization'];
  final tokenService = getIt<TokenService>();

  if (tokenHeader == null) {
    logger.warning("Declined grpc request: Missing auth token!");
    throw GrpcError.unauthenticated('Missing auth token!');
  }

  if (!tokenHeader.startsWith('Bearer ')) {
    logger.warning("Declined grpc request: Invalid auth token format!");
    throw GrpcError.unauthenticated('Invalid auth token format!');
  }

  final token = tokenHeader.replaceFirst("Bearer ", "");

  if (!await tokenService.checkToken(token: token, role: TokenRole.recorder)) {
    logger.warning("Declined grpc request: Invalid auth token!");
    throw GrpcError.unauthenticated("Invalid auth token!");
  }

  return null;
}

/// Implementation of the DaemonService defined in the proto file. This service gets called by the recorder to send new sensor updates and create requests for new stations.
class RecorderService extends grpc.DaemonServiceBase {
  final StationService _stationService;
  final SensorService _sensorService;
  final EventEmitter _events;

  RecorderService(this._stationService, this._sensorService, this._events);

  @override
  Future<grpc.Station> setStation(
    ServiceCall call,
    grpc.StationDefinition request,
  ) async {
    // Check if station exists (by Uuid). If not, create it.
    try {
      if (!await _stationService.exists(uuid: request.uuid)) {
        logger.info(
          "Creating station '${request.name}' with uuid '${request.uuid}' and ${request.sensors.length} sensors.",
        );
        final station = StationInfo.createUnconfigured(
          id: request.uuid,
          interfaceName: request.interfaceName,
        );
        final sensors = request.sensors.map((sensor) {
          final element = SensorElement.values.byName(sensor.element);
          return Sensor.create(
            name: sensor.name,
            stationUuid: station.uuid,
            element: element,
            storageUnit: SensorElement.defaultUnit(element: element),
            recordIntervalSeconds: sensor.defaultHistoryIntervalSeconds.toInt(),
            historyIntervalSeconds: sensor.defaultHistoryIntervalSeconds
                .toInt(),
          );
        }).toList();
        final result = await _stationService.create(
          station: station,
          sensors: sensors,
        );
        return grpc.Station(
          configured: result.info.configured,
          latitude: result.info.latitude,
          longitude: result.info.longitude,
          name: result.info.name,
          uuid: result.info.uuid,
          sensors: result.sensors.map(
            (sensor) => grpc.Sensor(
              id: Int64(sensor.id),
              name: sensor.name,
              configuredRecordIntervalSeconds: Int64(
                sensor.recordIntervalSeconds,
              ),
              configuredHistoryIntervalSeconds: Int64(
                sensor.historyIntervalSeconds,
              ),
            ),
          ),
        );
      } else {
        logger.info(
          "Station with uuid '${request.uuid}' already exists. Updating station info and sensors.",
        );
        logger.warning("Not implemented yet!");
        throw GrpcError.unimplemented(
          "Updating station info and sensors is not implemented yet!",
        );
      }
    } catch (e) {
      logger.warning("Failed to set station: ${e.toString()}");
      throw GrpcError.internal("Failed to set station: ${e.toString()}");
    }
  }

  @override
  Future<grpc.UpdateSensorsResponse> updateSensors(
    ServiceCall call,
    grpc.UpdateSensorsRequest request,
  ) async {
    final updates = <grpc.UpdateSensorResponse>[];

    for (final update in request.updates) {
      final sensor = await _sensorService.getById(id: update.sensorId.toInt());
      if (sensor == null) {
        final message =
            "Didn't find sensor for update (sensorId=${update.sensorId}, updateId=${update.updateId})";
        logger.severe(message);
        updates.add(
          grpc.UpdateSensorResponse(
            updateId: update.updateId,
            success: false,
            error: message,
          ),
        );
      } else {
        _events.emit(
          "sensor_update",
          SensorUpdate(sensor: sensor, request: update),
        );
        updates.add(
          grpc.UpdateSensorResponse(updateId: update.updateId, success: true),
        );
      }
    }
    final successCount = updates.where((u) => u.success).length;
    logger.info(
      "Processed update batch: Successfully processed $successCount/${request.updates.length} updates.",
    );
    return grpc.UpdateSensorsResponse(updates: updates);
  }

  @override
  Future<grpc.Station> getStation(
    ServiceCall call,
    grpc.GetStationRequest request,
  ) async {
    final result = await _stationService.getStationAndSensorsByUuid(
      id: request.stationId.toInt(),
    );
    if (result == null) {
      throw GrpcError.notFound(
        "Station with id '${request.stationId}' not found!",
      );
    }
    return grpc.Station(
      id: Int64(result.info.uuid),
      version: result.info.version,
      sensors: result.sensors.map(
        (sensor) => grpc.Sensor(
          id: Int64(sensor.id),
          name: sensor.name,
          recordIntervalSeconds: Int64(sensor.recordIntervalSeconds),
        ),
      ),
    );
  }

  @override
  Future<grpc.Station> updateStation(
    ServiceCall call,
    grpc.UpdateStationRequest request,
  ) {
    // TODO: implement updateStation
    throw GrpcError.unimplemented();
  }

  @override
  Future<grpc.PingMessage> ping(
    ServiceCall call,
    grpc.PingMessage request,
  ) async {
    logger.info("Received grpc ping (id=${request.randomId})");
    return grpc.PingMessage(randomId: request.randomId);
  }
}

/// Represents a processed sensor update. Value gets automatically converted to the storage unit of the sensor.
class SensorUpdate {
  final Sensor sensor;
  late final SensorState state;

  SensorUpdate({
    required this.sensor,
    required grpc.UpdateSensorRequest request,
  }) {
    final createdAt = DateTime.fromMillisecondsSinceEpoch(
      request.newState.createdAt.toInt(),
    );
    state = SensorState(
      value: request.newState.hasValue()
          ? Convertible(
              request.newState.value,
              Unit.fromId(request.newState.unitId),
            ).to(sensor.storageUnit)
          : null,
      createdAt: createdAt,
      interval: Duration(seconds: sensor.historyIntervalSeconds),
    );
  }

  @override
  String toString() {
    return "${sensor.name}@${sensor.stationUuid}: $state";
  }
}
