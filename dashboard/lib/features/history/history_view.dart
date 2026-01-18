import 'package:collection/collection.dart';
import 'package:dashboard/base_components/sensor_history_chart.dart';
import 'package:dashboard/repositories/daemon_repository.dart';
import 'package:dashboard/utils/icon_by_element.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:material_symbols_icons/material_symbols_icons.dart';
import 'package:shared/logger/logger.dart';
import 'package:shared/models/sensor.dart' as shared;
import 'package:owvision_daemon_client_dart/owvision_daemon_client_dart.dart';
import 'package:shared/units/convert.dart';

class HistoryView extends StatefulWidget {
  const HistoryView({super.key});

  @override
  State<StatefulWidget> createState() {
    return _HistoryPane();
  }
}

class _HistoryPane extends State<HistoryView> {
  List<SensorHistory> history = [];
  StationAndSensors? station;
  DateTime selectedDay = DateTime.now();
  bool loaded = false;
  static const supportedSensorElements = <shared.SensorElement>[
    shared.SensorElement.temperature,
    shared.SensorElement.precipationAccumulated,
    shared.SensorElement.humidity,
    shared.SensorElement.pressure,
    shared.SensorElement.precipationRate,
    shared.SensorElement.snowHeight,
    shared.SensorElement.windSpeed,
    shared.SensorElement.windDirection,
    shared.SensorElement.windChill,
    shared.SensorElement.dewPoint,
  ];

  @override
  void initState() {
    super.initState();
    loadHistory();
  }

  DateTime _beginningOfSelectedDay() {
    return selectedDay.copyWith(
      hour: 0,
      minute: 0,
      second: 0,
      millisecond: 0,
      microsecond: 0,
    );
  }

  DateTime _endOfSelectedDay() {
    return selectedDay.copyWith(
      hour: 24,
      minute: 0,
      second: 0,
      millisecond: 0,
      microsecond: 0,
    );
  }

  void loadHistory() async {
    final daemon = await context.read<DaemonRepository>();
    try {
      final fetchedStation = await daemon.getStation(1);
      if (fetchedStation == null) {
        throw Exception("Failed to fetch station!");
      }
      final currentHistory = await daemon.getSensorHistory(
        fetchedStation.info.id,
        _beginningOfSelectedDay().subtract(Duration(hours: 1)),
        _endOfSelectedDay().add(Duration(hours: 1)),
      );
      setState(() {
        history = currentHistory;
        station = fetchedStation;
        loaded = true;
      });
    } catch (err) {
      logger.severe(err);
      setState(() {
        history = [];
        station = null;
        loaded = false;
      });
    }
  }

  void _pickDate() async {
    final newDay = await showDatePicker(
      context: context,
      firstDate: DateTime(2025),
      lastDate: DateTime.now(),
      currentDate: selectedDay,
    );
    if (newDay == null) {
      return;
    }
    setState(() {
      selectedDay = newDay;
    });
    loadHistory();
  }

  bool _anyHistoryAvailable() {
    return history.isNotEmpty &&
        history.map((s) => s.history.isNotEmpty).reduce((v, l) => v || l);
  }

  Map<shared.SensorElement, List<SensorHistory>> _sensorHistoriesByElement() {
    final result = <shared.SensorElement, List<SensorHistory>>{};
    for (final element in supportedSensorElements) {
      result[element] = [];
      final sensors = station?.sensors.reversed.where(
        (s) => s.element.value == element.name,
      );
      result[element] =
          sensors
              ?.map(
                (s) => history.firstWhereOrNull((h) => h.sensorName == s.name),
              )
              .whereType<SensorHistory>()
              .toList() ??
          [];
      if (result[element]!.isEmpty) {
        result.remove(element);
      }
    }
    return result;
  }

  Widget _renderCharts(ThemeData theme) {
    final histories = _sensorHistoriesByElement();
    final from = _beginningOfSelectedDay();
    final to = _endOfSelectedDay();
    return ListView.builder(
      itemCount: histories.length,
      itemBuilder: (context, index) {
        final element = supportedSensorElements[index];
        final elementHistories = histories[element];
        final unit = elementHistories != null && elementHistories.isNotEmpty
            ? Unit.fromId(elementHistories[0].unitId).shortName
            : "";
        return SensorHistoryChart(
          elementHistories?.map((h) => h.history).toList() ?? [],
          from: from,
          to: to,
          intervalType: IntervalType.day,
          label: element.label,
          icon: iconByElement(element),
          unit: unit,
          graphColor: theme.colorScheme.primary,
          type: element == shared.SensorElement.precipationAccumulated
              ? ChartType.bar
              : ChartType.line,
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Scaffold(
      body: _anyHistoryAvailable()
          ? Padding(
              padding: EdgeInsetsGeometry.fromLTRB(0, 0, 0, 10),
              child: _renderCharts(theme),
            )
          : Center(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                mainAxisSize: MainAxisSize.max,
                spacing: 5,
                children: [
                  Icon(Symbols.indeterminate_question_box, size: 70),
                  Text("No data available!"),
                ],
              ),
            ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => _pickDate(),
        child: Icon(Icons.date_range),
      ),
    );
  }
}
