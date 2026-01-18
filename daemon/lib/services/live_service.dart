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
    required int stationId,
    required Function(SensorUpdate) handler,
  }) async {
    final station = await getIt<StationService>().getById(id: stationId);
    if (station == null) {
      throw StationNotFoundException(stationId);
    }
    final listener = EventListener("sensor_update", (SensorUpdate update) {
      if (update.sensor.stationId == station.id) {
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

/// Implementation of the RemoveRecorderService
class RecorderService extends grpc.DaemonServiceBase {
  final StationService _stationService;
  final SensorService _sensorService;
  final EventEmitter _events;

  RecorderService(this._stationService, this._sensorService, this._events);

  @override
  Future<grpc.Station> createStation(
    ServiceCall call,
    grpc.StationDefinition request,
  ) async {
    try {
      final result = await _stationService.create(
        station: StationInfo.create(
          name: request.name,
          longitude: request.longitude,
          latitude: request.latitude,
          version: request.version,
        ),
        sensors: request.sensors.map((sensor) {
          final element = SensorElement.values.byName(sensor.element);
          return Sensor.create(
            name: sensor.name,
            element: element,
            storageUnit: SensorElement.defaultUnit(element: element),
            recordIntervalSeconds: sensor.hasRecordIntervalSeconds()
                ? sensor.recordIntervalSeconds.toInt()
                : defaultRecordIntervalSeconds,
            historyIntervalSeconds: sensor.hasHistoryIntervalSeconds()
                ? sensor.historyIntervalSeconds.toInt()
                : defaultHistoryIntervalSeconds,
          );
        }).toList(),
      );
      if (result == null) {
        throw Exception("Internal error!");
      }
      return grpc.Station(
        id: Int64(result.info.id),
        version: result.info.version,
        sensors: result.sensors.map(
          (sensor) => grpc.Sensor(
            id: Int64(sensor.id),
            name: sensor.name,
            recordIntervalSeconds: Int64(sensor.recordIntervalSeconds),
            historyIntervalSeconds: Int64(sensor.historyIntervalSeconds),
          ),
        ),
      );
    } catch (e) {
      logger.warning("Failed to create station: ${e.toString()}");
      throw GrpcError.internal("Failed to create station: ${e.toString()}");
    }
  }

  @override
  Future<grpc.UpdateSensorsResponse> updateSensors(
    ServiceCall call,
    grpc.UpdateSensorsRequest request,
  ) async {
    final errors = <String>[];
    final processed = <Int64>[];

    for (final update in request.updates) {
      try {
        final sensor = await _sensorService.getById(
          id: update.sensorId.toInt(),
        );
        if (sensor == null) {
          logger.severe(
            "Didn't find sensor for update (sensorId=${update.sensorId}, updateId=${update.updateId})",
          );
          continue;
        }
        _events.emit(
          "sensor_update",
          SensorUpdate(sensor: sensor, request: update),
        );
        processed.add(update.updateId);
      } catch (e) {
        final message = "Invalid sensor id '${update.sensorId}'!";
        errors.add(message);
        logger.warning("Failed to update sensor: $message");
        continue;
      }
    }
    logger.info(
      "Processed update batch: Successfully processed ${processed.length}/${request.updates.length} updates.",
    );
    return grpc.UpdateSensorsResponse(errors: errors, processed: processed);
  }

  @override
  Future<grpc.Station> getStation(
    ServiceCall call,
    grpc.GetStationRequest request,
  ) async {
    final result = await _stationService.getStationAndSensorsById(
      id: request.stationId.toInt(),
    );
    if (result == null) {
      throw GrpcError.notFound(
        "Station with id '${request.stationId}' not found!",
      );
    }
    return grpc.Station(
      id: Int64(result.info.id),
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
    return "${sensor.name}@${sensor.stationId}: $state";
  }
}
