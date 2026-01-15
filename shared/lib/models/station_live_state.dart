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
      final state = json[sensorName];
      result.update(
        sensorName,
        state == null ? null : SensorState.fromJson(json[sensorName]),
      );
    }
    return result;
  }

  Map<String, dynamic> toJson() {
    final result = <String, dynamic>{};
    for (final sensorName in _sensorStates.keys) {
      if (_sensorStates[sensorName] != null) {
        result[sensorName] = _sensorStates[sensorName]!.toJson();
      } else {
        result[sensorName] = null;
      }
    }
    return result;
  }

  @override
  String toString() {
    var result = "StationLiveState {\n";
    for (final sensorName in _sensorStates.keys) {
      final state = _sensorStates[sensorName];
      result += "  $sensorName=${state != null ? state.toString() : "-"}\n";
    }
    return result += "}\n";
  }
}
