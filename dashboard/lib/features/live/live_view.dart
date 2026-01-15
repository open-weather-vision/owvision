import 'package:dashboard/base_components/connected_station_component.dart';
import 'package:dashboard/base_components/humidity_component.dart';
import 'package:dashboard/base_components/precipation_component.dart';
import 'package:dashboard/base_components/pressure_component.dart';
import 'package:dashboard/base_components/temperature_component.dart';
import 'package:dashboard/features/settings/settings_cubit.dart';
import 'package:dashboard/repositories/daemon_repository.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:owvision_daemon_client_dart/owvision_daemon_client_dart.dart';
import 'package:shared/models/sensor_state.dart';
import 'package:collection/collection.dart';

import 'live_cubit.dart';

class LiveView extends StatelessWidget {
  const LiveView({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SettingsCubit, SettingsState>(
      builder: (context, state) {
        return RepositoryProvider(
          create: (ctx) =>
              DaemonRepository(state.apiUrl ?? "", state.apiToken ?? ""),
          child: BlocProvider(
            lazy: false,
            create: (context) => LiveCubit(context.read<DaemonRepository>()),
            child: _LivePane(),
          ),
        );
      },
    );
  }
}

class SensorAndState {
  final Sensor sensor;
  final SensorState? state;

  const SensorAndState(this.sensor, this.state);
}

class _LivePane extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<LiveCubit, LiveState>(
      builder: (ctx, state) {
        return AnimatedSwitcher(
          duration: const Duration(milliseconds: 500),
          transitionBuilder: (child, animation) {
            return FadeTransition(opacity: animation, child: child);
          },

          child: _buildLiveView(ctx, state),
        );
      },
    );
  }

  Widget _buildLiveView(BuildContext ctx, LiveState state) {
    final theme = Theme.of(ctx);
    final sensors = state.stationState.entries
        .map(
          (e) => SensorAndState(
            state.station!.sensors.firstWhere((s) => s.name == e.key),
            e.value,
          ),
        )
        .toList();
    if (state.connectionState == StationConnectionState.connecting) {
      return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SpinKitDancingSquare(
              size: 100,
              color: theme.colorScheme.onPrimaryFixedVariant,
            ),
            Text(
              "Connecting...",
              style: TextStyle(
                fontSize: 20,
                color: theme.colorScheme.onPrimaryFixedVariant,
                fontWeight: FontWeight.w500,
              ),
            ),
          ],
        ),
      );
    } else {
      List<Widget> items = [];

      final _currentConditions = sensors.firstWhereOrNull(
        (s) => s.sensor.element == SensorElement.weatherCode,
      );

      // Connected component
      items.add(
        ConnectedStationComponent(
          state.station?.station,
          latestUpdateTime: state.latestUpdateTime,
          currentConditions: _currentConditions?.state,
          reconnecting:
              state.connectionState == StationConnectionState.reconnecting,
        ),
      );

      // Precipation stats
      final precipationAcc = sensors.firstWhereOrNull(
        (s) => s.sensor.element == SensorElement.precipationAccumulated,
      );
      final precipationRate = sensors.firstWhereOrNull(
        (s) => s.sensor.element == SensorElement.precipationRate,
      );
      if (precipationRate != null || precipationAcc != null) {
        items.add(PrecipationComponent(precipationAcc, precipationRate));
      }

      // Temperature stats
      final temperature = sensors.firstWhereOrNull(
        (s) => s.sensor.element == SensorElement.temperature,
      );
      if (temperature != null) {
        items.add(TemperatureComponent(temperature));
      }

      final pressure = sensors.firstWhereOrNull(
        (s) => s.sensor.element == SensorElement.pressure,
      );
      if (pressure != null) {
        items.add(PressureComponent(pressure));
      }

      final humidity = sensors.firstWhereOrNull(
        (s) => s.sensor.element == SensorElement.humidity,
      );
      if (humidity != null) {
        items.add(HumidityComponent(humidity));
      }

      return Padding(
        padding: const EdgeInsets.all(5),
        child: ListView.builder(
          itemCount: items.length,

          itemBuilder: (ctx, id) {
            return items[id];
          },
        ),
      );
    }
  }
}
