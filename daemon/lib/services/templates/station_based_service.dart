import 'dart:async';
import 'package:daemon/services/station_service.dart';

import '../../models/station_info.dart';

/// A station based service is a service that needs to operate for every individual station that is currently active.
abstract class StationBasedService {
  final StationService stationService;

  StationBasedService(this.stationService);

  Future<void> start() async {
    List<StationInfo> stations = await stationService.getAll();
    final futures = stations.map((station) => onStationCreate(station.uuid));
    await Future.wait(futures);
    stationService.watch(
      handler: (event, id) async {
        if (event == StationEvent.create) {
          int parsedId = int.parse(id);
          onStationCreate(parsedId);
        } else {
          if (id == "*") {
            onStationDeleteAll();
          } else {
            int parsedId = int.parse(id);
            onStationDelete(parsedId);
          }
        }
      },
    );
  }

  Future<void> onStationCreate(String stationUuid);

  void onStationDelete(String stationUuid);

  void onStationDeleteAll();
}
