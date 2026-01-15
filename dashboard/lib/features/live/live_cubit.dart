import 'package:dashboard/repositories/daemon_repository.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:owvision_daemon_client_dart/owvision_daemon_client_dart.dart';
import 'package:shared/logger/logger.dart';
import 'package:shared/models/station_live_state.dart';

enum StationConnectionState { connecting, reconnecting, connected }

class LiveState {
  final StationLiveState stationState;
  final StationConnectionState connectionState;
  final StationAndSensors? station;
  final DateTime? latestUpdateTime;

  const LiveState({
    required this.stationState,
    required this.connectionState,
    required this.station,
    required this.latestUpdateTime,
  });

  @override
  String toString() {
    return "LiveState($connectionState)";
  }
}

class LiveCubit extends Cubit<LiveState> {
  final DaemonRepository _daemonRepository;
  ConnectionCanceller? _connectionCanceller;

  LiveCubit(this._daemonRepository)
    : super(
        LiveState(
          connectionState: StationConnectionState.connecting,
          stationState: StationLiveState(),
          station: null,
          latestUpdateTime: null,
        ),
      ) {
    _startConnectLoop();
  }

  Future<void> _startConnectLoop() async {
    _connectionCanceller = await _daemonRepository
        .stableConnectionToStationLiveSocket(
          (update, station) {
            final updateTime = update.entries
                .map((e) => e.value?.createdAt)
                .reduce((updateTime, newTime) {
                  if (newTime != null) {
                    if (updateTime == null) {
                      return newTime;
                    } else {
                      return newTime.isAfter(updateTime) ? newTime : updateTime;
                    }
                  } else {
                    return updateTime;
                  }
                });
            emit(
              LiveState(
                connectionState: StationConnectionState.connected,
                stationState: update,
                station: station,
                latestUpdateTime: updateTime,
              ),
            );
          },
          () {
            logger.warning("Temporary connection loss!");
            final previous = state;
            emit(
              LiveState(
                stationState: previous.stationState,
                connectionState: StationConnectionState.reconnecting,
                station: previous.station,
                latestUpdateTime: previous.latestUpdateTime,
              ),
            );
          },
        );
  }

  Future<void> _stopConnectLoop() async {
    await _connectionCanceller?.cancel();
    emit(
      LiveState(
        stationState: StationLiveState(),
        connectionState: StationConnectionState.connecting,
        station: null,
        latestUpdateTime: null,
      ),
    );
  }

  @override
  Future<void> close() async {
    await _stopConnectLoop();
    return super.close();
  }

  @override
  void onChange(Change<LiveState> change) {
    super.onChange(change);
    logger.info(change.nextState.stationState);
  }
}
