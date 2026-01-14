import 'package:daemon/repositories/station_repository.dart';
import 'package:events_emitter/emitters/event_emitter.dart';
import 'package:events_emitter/listener.dart';
import 'package:injectable/injectable.dart';
import 'package:shared/models/sensor.dart';
import 'package:shared/models/station.dart';
import 'package:shared/models/station_and_sensors.dart';

@singleton
class StationService {
  final StationRepository _stationRepository;
  final EventEmitter _events = EventEmitter();

  StationService(this._stationRepository);

  Future<Station?> getById({required int id}) {
    return _stationRepository.getById(id: id);
  }

  /// Gets all weather stations.
  Future<List<Station>> getAll() async {
    return await _stationRepository.getAll();
  }

  Future<StationAndSensors?> getStationAndSensorsById({required int id}) async {
    return await _stationRepository.getStationAndSensorsById(id: id);
  }

  /// Deletes all weather stations.
  Future<int> deleteAll() async {
    final result = await _stationRepository.deleteAll();
    _events.emit("station_delete", "*");
    return result;
  }

  Future<bool> deleteOne({required int id}) async {
    final result = await _stationRepository.deleteOne(id: id);
    _events.emit("station_delete", id.toString());
    return result;
  }

  Set<EventListener<String>> watch({
    required Function(StationEvent, String) handler,
  }) {
    final createListener = EventListener("station_create", (String id) {
      handler(StationEvent.create, id);
    });
    _events.addEventListener(createListener);
    final deleteListener = EventListener("station_delete", (String id) {
      handler(StationEvent.delete, id);
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
    required Station station,
    required List<Sensor> sensors,
  }) async {
    if (await _stationRepository.exists(name: station.name)) {
      throw Exception("Station with name '${station.name}' already exists!");
    } else {
      final result = await _stationRepository.create(
        station: station,
        sensors: sensors,
      );
      _events.emit("station_create", result.station.id.toString());
      return result;
    }
  }
}

enum StationEvent { delete, create }
