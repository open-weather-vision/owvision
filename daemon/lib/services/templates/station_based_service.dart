import 'dart:async';
import 'package:daemon/services/station_service.dart';

import '../../models/station_info.dart';

/// A station based service is a service that needs to operate for every individual station that is currently active.
abstract class StationBasedService {
  final StationService stationService;

  StationBasedService(this.stationService);

  Future<void> start() async {
    List<StationInfo> stations = await stationService.getAll();
    for (final station in stations) {
      onStationCreate(station.id);
    }
    stationService.watch(
      handler: (event, id) async {
        int parsedId = int.parse(id);
        if (event == StationEvent.create) {
          onStationCreate(parsedId);
        } else {
          onStationDelete(parsedId);
        }
      },
    );
  }

  Future<void> onStationCreate(int stationId);

  void onStationDelete(int stationId);
}
