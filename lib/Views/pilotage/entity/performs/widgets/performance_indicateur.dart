import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:syncfusion_flutter_charts/charts.dart';



class PerformanceIndicateur extends StatefulWidget {
  const PerformanceIndicateur({Key? key}) : super(key: key);

  @override
  State<PerformanceIndicateur> createState() => _PerformanceIndicateurState();
}

class _PerformanceIndicateurState extends State<PerformanceIndicateur> {
  bool isCardView = true;

  List<_ChartData>? chartData;

  @override
  void initState() {
    chartData = <_ChartData>[
      _ChartData(2016, 21, 28),
      _ChartData(2017, 24, 44),
      _ChartData(2018, 36, 48),
      _ChartData(2019, 38, 50),
      _ChartData(2020, 54, 66),
      _ChartData(2022, 57, 78),
    ];
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return  _buildPerformanceIndicateur();
  }

  SfCartesianChart _buildPerformanceIndicateur() {
    return SfCartesianChart(
      plotAreaBorderWidth: 0,
      title: ChartTitle(text: "Taux de Consommation d'energie -- SANIA"),
      legend: Legend(
          isVisible:false,
          overflowMode: LegendItemOverflowMode.wrap),
      primaryXAxis: NumericAxis(
          edgeLabelPlacement: EdgeLabelPlacement.shift,
          interval: 2,
          axisLine: const AxisLine(width: 2),
          majorGridLines: const MajorGridLines(width: 0)),
      primaryYAxis: NumericAxis(
          labelFormat: '{value}%',
          axisLine: const AxisLine(width: 2),
          majorTickLines: const MajorTickLines(color: Colors.transparent)),
      series: _getDefaultLineSeries(),
      tooltipBehavior: TooltipBehavior(enable: true),
    );
  }

  /// The method returns line series to chart.
  List<LineSeries<_ChartData, num>> _getDefaultLineSeries() {
    return <LineSeries<_ChartData, num>>[
      LineSeries<_ChartData, num>(
          animationDuration: 2500,
          dataSource: chartData!,
          xValueMapper: (_ChartData sales, _) => sales.x,
          yValueMapper: (_ChartData sales, _) => sales.y,
          width: 2,
          name: 'SUCRIVOIRE',
          markerSettings: const MarkerSettings(isVisible: true)),
    ];
  }

  @override
  void dispose() {
    chartData!.clear();
    super.dispose();
  }
}

class _ChartData {
  _ChartData(this.x, this.y, this.y2);
  final double x;
  final double y;
  final double y2;
}
