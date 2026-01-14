import 'package:test/test.dart';
import 'package:owvision_daemon_client_dart/owvision_daemon_client_dart.dart';


/// tests for StationApi
void main() {
  final instance = OwvisionDaemonClientDart().getStationApi();

  group(StationApi, () {
    // Get all stations.
    //
    //Future<List<Station>> stationsAll() async
    test('test stationsAll', () async {
      // TODO
    });

    // Connect to a station's live websocket.
    //
    //Future<Error> stationsConnect(int id) async
    test('test stationsConnect', () async {
      // TODO
    });

    // Get one station and it's sensors.
    //
    //Future<StationAndSensors> stationsOne(int id) async
    test('test stationsOne', () async {
      // TODO
    });

  });
}
