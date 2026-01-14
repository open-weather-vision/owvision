import 'package:daemon/repositories/sensor_repository.dart';
import 'package:injectable/injectable.dart';
import 'package:shared/models/sensor.dart';

@singleton
class SensorService {
  final SensorRepository _sensorRepository;

  SensorService(this._sensorRepository);

  Future<Sensor?> getById({required int id}) {
    return _sensorRepository.getById(id: id);
  }
}
