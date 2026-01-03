import 'dart:async';
import 'dart:io';
import 'dart:math';

import 'package:fixnum/fixnum.dart';
import 'package:grpc/grpc.dart';
import 'package:shared/grpc/recorder.pbgrpc.dart';
import 'package:shared/logger/logger.dart';
import 'package:shared/models/sensor.dart';
import 'package:shared/units/humidity.dart';
import 'package:shared/units/temperature.dart';

class StationDriverMock {
  late double tempIn;
  late double tempOut;
  late double humOut;
  final _random = Random();

  StationDriverMock() {
    tempIn = _random.nextDouble() * 30 - 15;
    tempOut = _random.nextDouble() * 30 - 15;
    humOut = _random.nextDouble() * 100;
    Timer.periodic(Duration(seconds: 1), (_) {
      tempOut += (_random.nextDouble() - 0.5) * 0.1;
      tempIn += (_random.nextDouble() - 0.5) * 0.1;
      humOut += (_random.nextDouble() - 0.5) * 0.1;
    });
  }
}

class ClientTest extends StationInterfaceServiceBase {
  final _stationDriver = StationDriverMock();

  @override
  Future<SensorState> getSensorState(
    ServiceCall call,
    GetSensorStateRequest request,
  ) async {
    logger.info("Someone requested the value of sensor ${request.name}!");
    if (request.name == "temperature_out") {
      return SensorState(
        unitId: Temperature.celsius.id,
        createdAt: Int64(DateTime.now().millisecondsSinceEpoch),
        value: _stationDriver.tempOut,
      );
    } else if (request.name == "temperature_in") {
      return SensorState(
        unitId: Temperature.celsius.id,
        createdAt: Int64(DateTime.now().millisecondsSinceEpoch),
        value: _stationDriver.tempIn,
      );
    } else {
      return SensorState(
        unitId: Humidity.percent.id,
        createdAt: Int64(DateTime.now().millisecondsSinceEpoch),
        value: _stationDriver.humOut,
      );
    }
  }

  @override
  Future<StationDefinition> getStationDefinition(
    ServiceCall call,
    GetStationDefinitionRequest request,
  ) async {
    logger.info("Someone requested the station definition!");
    return StationDefinition(
      latitude: 42,
      longitude: 41,
      name: "Hello station",
      sensors: [
        SensorDefinition(
          name: "temperature_in",
          element: SensorElement.temperature.name,
          recordIntervalSeconds: Int64(10),
        ),
        SensorDefinition(
          name: "temperature_out",
          element: SensorElement.temperature.name,
          recordIntervalSeconds: Int64(10),
        ),
        SensorDefinition(
          name: "humidity_out",
          element: SensorElement.humidity.name,
          recordIntervalSeconds: Int64(60),
        ),
      ],
      version: 1,
    );
  }
}

Future<void> main(List<String> args) async {
  final server = Server.create(services: [ClientTest()]);
  await server.serve(
    address: InternetAddress.anyIPv4,
    port: 50051,
    // security: ServerLocalCredentials(),
  );
  logger.info("Station interface running on port ${server.port}...");
}
