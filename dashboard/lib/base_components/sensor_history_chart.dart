import 'package:collection/collection.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:owvision_daemon_client_dart/owvision_daemon_client_dart.dart';

// TODO: Support other interval types than day
enum IntervalType { day }

enum ChartType { bar, line }

class SensorHistoryChart extends StatefulWidget {
  final List<List<HistoryRecord>> histories;
  final Color graphColor;
  final DateTime from;
  final DateTime to;
  final IntervalType intervalType;
  final int precision;
  final String label;
  final IconData icon;
  final String unit;
  final ChartType type;

  SensorHistoryChart(
    this.histories, {
    this.graphColor = Colors.blue,
    required this.from,
    required this.to,
    required this.intervalType,
    required this.label,
    required this.icon,
    required this.unit,
    this.type = ChartType.bar,
    this.precision = 1,
  });

  @override
  State<StatefulWidget> createState() {
    return _SensorHistoryChart();
  }
}

class _SensorHistoryChart extends State<SensorHistoryChart> {
  int selectedSensorIndex = 0;

  void _selectSensor(int index) {
    setState(() {
      selectedSensorIndex = index;
    });
  }

  SideTitles _bottomTitles(ThemeData theme) {
    late final double interval;
    late final double titleSpace;
    late final DateFormat format;
    switch (widget.intervalType) {
      case IntervalType.day:
        interval = Duration(hours: 1).inMilliseconds.toDouble();
        titleSpace = 50;
        format = DateFormat(DateFormat.HOUR24_MINUTE);
        break;
    }

    double? previousAxisPosition;
    return SideTitles(
      showTitles: true,
      minIncluded: false,
      maxIncluded: false,
      interval: interval,
      reservedSize: 40,
      getTitlesWidget: (value, meta) {
        if (previousAxisPosition != null) {
          final distance = (meta.axisPosition - previousAxisPosition!).abs();
          if (distance < titleSpace) {
            return SideTitleWidget(meta: meta, child: Text(""));
          }
        }
        previousAxisPosition = meta.axisPosition;
        return SideTitleWidget(
          meta: meta,
          child: Text(
            format.format(DateTime.fromMillisecondsSinceEpoch(value.toInt())),
            style: _titleStyle(theme),
          ),
        );
      },
    );
  }

  TextStyle _titleStyle(ThemeData theme) {
    return TextStyle(
      fontWeight: FontWeight.w500,
      color: theme.brightness == Brightness.light
          ? const Color.fromARGB(118, 0, 0, 0)
          : const Color.fromARGB(118, 255, 255, 255),
    );
  }

  SideTitles _leftTitles(ThemeData theme, double sampleValue) {
    return SideTitles(
      showTitles: true,
      reservedSize:
          sampleValue.toStringAsFixed(widget.precision).length * 9.5 + 12,
      maxIncluded: false,
      minIncluded: false,
      getTitlesWidget: (value, meta) => SideTitleWidget(
        meta: meta,
        child: Text(
          value.toStringAsFixed(widget.precision),
          style: _titleStyle(theme),
        ),
      ),
    );
  }

  FlBorderData _border(ThemeData theme) {
    return FlBorderData(
      border: Border.all(color: theme.colorScheme.onSurface.withAlpha(50)),
    );
  }

  FlTitlesData _titles(ThemeData theme, double sampleValue) {
    return FlTitlesData(
      leftTitles: AxisTitles(sideTitles: _leftTitles(theme, sampleValue)),
      bottomTitles: AxisTitles(sideTitles: _bottomTitles(theme)),
      topTitles: AxisTitles(),
      rightTitles: AxisTitles(),
    );
  }

  LineTouchData _toolTips(ThemeData theme) {
    return LineTouchData(
      enabled: true,
      touchSpotThreshold: double.infinity,
      getTouchLineEnd: (barData, spotIndex) => double.infinity,
      getTouchedSpotIndicator: (barData, spotIndexes) => spotIndexes
          .map(
            (spotIndex) => TouchedSpotIndicatorData(
              FlLine(color: theme.colorScheme.onPrimaryContainer),
              FlDotData(
                show: true,
                getDotPainter: (spot, percent, barData, index) =>
                    FlDotCirclePainter(
                      radius: 5,
                      color: theme.brightness == Brightness.light
                          ? Colors.black
                          : Colors.white,
                    ),
              ),
            ),
          )
          .toList(),
      touchTooltipData: LineTouchTooltipData(
        getTooltipColor: (touchedSpot) =>
            theme.brightness == Brightness.light ? Colors.black : Colors.white,
        getTooltipItems: (touchedSpots) => touchedSpots
            .map(
              (s) => LineTooltipItem(
                "${s.y.toStringAsFixed(widget.precision)}${widget.unit}",
                TextStyle(
                  color: theme.brightness == Brightness.light
                      ? Colors.white
                      : Colors.black,
                  fontWeight: FontWeight.w600,
                ),
              ),
            )
            .toList(),
      ),
    );
  }

  LineChart _renderChart(int index, ThemeData theme) {
    final records = widget.histories[index];

    final spots = records
        .map(
          (e) => FlSpot(
            e.createdAt.millisecondsSinceEpoch.toDouble(),
            e.value ?? 0,
          ),
        )
        .toList();
    final min = records.map((s) => s.value).whereType<double>().minOrNull ?? 0;
    var max = records.map((s) => s.value).whereType<double>().maxOrNull ?? 0;

    if (min == max) {
      max = min + 1;
    }

    final gridLine = FlLine(
      color: theme.brightness == Brightness.dark
          ? const Color.fromARGB(41, 255, 255, 255)
          : const Color.fromARGB(41, 0, 0, 0),
      strokeWidth: 1,
      dashArray: [8, 4],
    );
    return LineChart(
      LineChartData(
        clipData: FlClipData.all(),
        gridData: FlGridData(
          getDrawingHorizontalLine: (value) => gridLine,
          getDrawingVerticalLine: (value) => gridLine,
        ),

        lineBarsData: [
          LineChartBarData(
            spots: spots,
            isStepLineChart: widget.type == ChartType.bar,
            lineChartStepData: LineChartStepData(stepDirection: 0),
            color: widget.graphColor,
            dotData: FlDotData(show: false),
            belowBarData: widget.type == ChartType.bar
                ? BarAreaData(show: true, color: widget.graphColor)
                : BarAreaData(
                    show: true,
                    gradient: LinearGradient(
                      colors: [
                        widget.graphColor.withAlpha(150),
                        widget.graphColor.withAlpha(20),
                      ],
                      begin: AlignmentGeometry.topCenter,
                      end: AlignmentGeometry.bottomCenter,
                    ),
                  ),
            barWidth: widget.type == ChartType.bar ? 0 : 2,
            isCurved: true,
            curveSmoothness: 0.15,
          ),
        ],
        borderData: _border(theme),
        minX: widget.from.millisecondsSinceEpoch.toDouble(),
        maxX: widget.to.millisecondsSinceEpoch.toDouble(),
        minY: widget.type == ChartType.bar ? min : min - (max - min) * 0.1,
        maxY: max + (max - min) * 0.1,
        titlesData: _titles(theme, max),
        lineTouchData: _toolTips(theme),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    if (widget.histories.isEmpty ||
        widget.histories.map((l) => l.isEmpty).reduce((l, v) => l || v)) {
      return SizedBox.shrink();
    }

    return Container(
      margin: EdgeInsets.fromLTRB(10, 10, 10, 0),
      height: 300,
      decoration: BoxDecoration(
        border: Border.all(
          width: Theme.of(context).brightness == Brightness.dark ? 1.5 : 0,
          color: (Theme.of(context).brightness == Brightness.dark
              ? Colors.white.withAlpha(50)
              : Colors.transparent),
        ),
        borderRadius: BorderRadius.circular(10),
        color: theme.brightness == Brightness.light
            ? Colors.white
            : const Color.fromARGB(255, 15, 15, 15),
      ),
      child: Column(
        children: [
          Container(
            padding: EdgeInsets.all(10),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.vertical(top: Radius.circular(10)),
              color: Theme.of(context).brightness == Brightness.dark
                  ? const Color.fromARGB(255, 28, 29, 29)
                  : const Color.fromARGB(255, 228, 228, 228),
            ),
            child: Row(
              spacing: 10,
              children: [
                Icon(widget.icon, size: 18),
                Text(
                  widget.label,
                  style: TextStyle(fontWeight: FontWeight.w500),
                ),
                Spacer(),
                if (widget.histories.length > 1)
                  Row(
                    spacing: 10,
                    children: widget.histories
                        .mapIndexed(
                          (i, _) => InkWell(
                            onTap: () => _selectSensor(i),

                            child: Container(
                              width: 30,
                              height: 30,
                              decoration: BoxDecoration(
                                color: selectedSensorIndex == i
                                    ? Colors.white
                                    : Colors.grey,
                                borderRadius: BorderRadius.circular(5),
                                border: Border.all(
                                  color: const Color.fromARGB(
                                    62,
                                    255,
                                    255,
                                    255,
                                  ),
                                  width: 2,
                                ),
                              ),
                              alignment: AlignmentDirectional.center,
                              child: Text(
                                i.toString(),
                                style: TextStyle(
                                  color: selectedSensorIndex == i
                                      ? const Color.fromARGB(255, 0, 0, 0)
                                      : const Color.fromARGB(255, 90, 90, 90),
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ),
                          ),
                        )
                        .toList(),
                  ),
              ],
            ),
          ),
          Expanded(
            child: Padding(
              padding: EdgeInsetsGeometry.fromLTRB(0, 15, 15, 0),
              child: _renderChart(selectedSensorIndex, theme),
            ),
          ),
        ],
      ),
    );
  }
}
