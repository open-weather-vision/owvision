import 'package:injectable/injectable.dart';
import 'package:recorder/models/recorder_status.dart';

@singleton
class StatusService {
  final _recorderStatus = RecorderStatus.fromFileSync();

  Future<void> init() async {
    _recorderStatus.stationConnected = false;
    _recorderStatus.daemonConnected = false;
    await _recorderStatus.saveToFile();
  }

  Future<void> stationResponded() async {
    _recorderStatus.stationConnected = true;
    _recorderStatus.latestStationConnection = DateTime.now();
    await _recorderStatus.saveToFile();
  }

  Future<void> stationDidntRespond() async {
    _recorderStatus.stationConnected = false;
    await _recorderStatus.saveToFile();
  }

  Future<void> daemonDidntRespond() async {
    _recorderStatus.daemonConnected = true;
    _recorderStatus.latestDaemonConnection = DateTime.now();
    await _recorderStatus.saveToFile();
  }

  Future<void> daemonResponded() async {
    _recorderStatus.daemonConnected = false;
    await _recorderStatus.saveToFile();
  }
}
