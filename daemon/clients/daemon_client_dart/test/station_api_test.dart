import 'package:test/test.dart';
import 'package:owvision_daemon_client_dart/owvision_daemon_client_dart.dart';


/// tests for StationApi
void main() {
  final instance = OwvisionDaemonClientDart().getStationApi();

  group(StationApi, () {
    // Get all stations.
    //
    //Future<List<WeatherStation>> stationAll() async
    test('test stationAll', () async {
      // TODO
    });

    // Connect to a station's live websocket.
    //
    //Future<Error> stationConnect(int id) async
    test('test stationConnect', () async {
      // TODO
    });

    // Get the history of one ore more sensors (in a specific interval).
    //
    //Future<List<SensorHistory>> stationHistory(int id, { DateTime from, DateTime to, List<String> sensors }) async
    test('test stationHistory', () async {
      // TODO
    });

    // Get one station and it's sensors.
    //
    //Future<StationAndSensors> stationOne(int id) async
    test('test stationOne', () async {
      // TODO
    });

  });
}
