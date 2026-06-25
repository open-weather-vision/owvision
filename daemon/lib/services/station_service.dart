import 'package:daemon/repositories/station_repository.dart';
import 'package:events_emitter/emitters/event_emitter.dart';
import 'package:events_emitter/listener.dart';
import 'package:injectable/injectable.dart';
import 'package:shared/logger/logger.dart';
import 'package:shared/models/sensor.dart';
import '../models/station_info.dart';
import '../models/station_and_sensors.dart';

@singleton
class StationService {
  final StationRepository _stationRepository;
  final EventEmitter _events = EventEmitter();

  StationService(this._stationRepository);

  Future<StationInfo?> getByUuid({required String uuid}) {
    return _stationRepository.getByUuid(uuid: uuid);
  }

  /// Gets all weather stations.
  Future<List<StationInfo>> getAll() async {
    return await _stationRepository.getAll();
  }

  Future<StationAndSensors?> getStationAndSensorsByUuid({
    required String uuid,
  }) async {
    return await _stationRepository.getStationAndSensorsByUuid(uuid: uuid);
  }

  /// Deletes all weather stations.
  Future<int> deleteAll() async {
    final result = await _stationRepository.deleteAll();
    _events.emit("station_delete", "*");
    return result;
  }

  Future<bool> deleteOne({required String uuid}) async {
    final result = await _stationRepository.deleteOne(uuid: uuid);
    _events.emit("station_delete", uuid);
    return result;
  }

  Future<bool> exists({required String uuid}) async {
    return await _stationRepository.exists(uuid: uuid);
  }

  Set<EventListener<String>> watch({
    required Function(StationEvent, String) handler,
  }) {
    final createListener = EventListener("station_create", (String uuid) {
      handler(StationEvent.create, uuid);
    });
    _events.addEventListener(createListener);
    final deleteListener = EventListener("station_delete", (String uuid) {
      handler(StationEvent.delete, uuid);
    });
    _events.addEventListener(deleteListener);
    return {createListener, deleteListener};
  }

  void stopWatching({required Set<EventListener<String>> listeners}) {
    for (final listener in listeners) {
      _events.removeEventListener(listener);
    }
  }

  /// Creates a weather station and its sensors.
  Future<StationAndSensors> create({
    required StationInfo station,
    required List<Sensor> sensors,
  }) async {
    if (await _stationRepository.exists(uuid: station.uuid)) {
      throw Exception("Station with uuid '${station.uuid}' already exists!");
    } else {
      final result = await _stationRepository.create(
        station: station,
        sensors: sensors,
      );
      logger.info(
        "Created station '${station.name}' with ${sensors.length} sensors",
      );
      _events.emit("station_create", result.info.uuid.toString());
      return result;
    }
  }
}

enum StationEvent { delete, create }
