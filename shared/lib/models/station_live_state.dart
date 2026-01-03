import 'package:shared/models/sensor.dart';

import 'sensor_state.dart';

class StationLiveState {
  final Map<String, SensorState?> _sensorStates = {};

  StationLiveState();

  factory StationLiveState.fromSensors(List<Sensor> sensors) {
    final result = StationLiveState();
    for (final sensor in sensors) {
      result.update(sensor.name, null);
    }
    return result;
  }

  void update(String sensor, SensorState? state) {
    _sensorStates[sensor] = state;
  }

  Iterable<MapEntry<String, SensorState?>> get entries => _sensorStates.entries;

  factory StationLiveState.fromJson(Map<String, dynamic> json) {
    final result = StationLiveState();
    for (final sensorName in json.keys) {
      result.update(sensorName, SensorState.fromJson(json[sensorName]));
    }
    return result;
  }

  Map<String, dynamic> toJson() {
    final result = <String, dynamic>{};
    for (final sensorName in _sensorStates.keys) {
      result[sensorName] = _sensorStates[sensorName]!.toJson();
    }
    return result;
  }
}
