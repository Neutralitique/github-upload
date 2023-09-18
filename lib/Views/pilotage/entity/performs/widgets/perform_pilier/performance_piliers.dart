import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:get/get.dart';
import 'package:styled_widget/styled_widget.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

class PerformancePiliers extends StatefulWidget {
  const PerformancePiliers({Key? key}) : super(key: key);

  @override
  State<PerformancePiliers> createState() => _PerformancePiliersState();
}

class _PerformancePiliersState extends State<PerformancePiliers> {

  late double _columnWidth;
  late double _columnSpacing;
  List<ChartSampleData>? chartData;
  TooltipBehavior? _tooltipBehavior;
  bool _isLoaded = false ;
  bool isCardView = true ;


  void initialisation() async {
    _columnWidth = 0.8;
    _columnSpacing = 0.2;
    _tooltipBehavior = TooltipBehavior(enable: true);
    chartData = <ChartSampleData>[
      ChartSampleData(
          x: 'Gouvernance', y: 16, secondSeriesYValue: 8, thirdSeriesYValue: 13),
      ChartSampleData(
          x: 'Economie', y: 8, secondSeriesYValue: 10, thirdSeriesYValue: 7),
      ChartSampleData(
          x: 'Société', y: 12, secondSeriesYValue: 10, thirdSeriesYValue: 5),
      ChartSampleData(
          x: 'Environnement', y: 4, secondSeriesYValue: 8, thirdSeriesYValue: 14)
    ];
    await Future.delayed(const Duration(milliseconds: 2000));
    setState(() {
      _isLoaded = true;
    });
  }

  @override
  void initState() {
    initialisation();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return _isLoaded ? _buildSpacingColumnChart() : Stack(
      alignment: AlignmentDirectional.center,
      children: const [
        SizedBox(
            height: 50,
            width: 50,
            child: CircularProgressIndicator(
              color: Colors.grey,
              strokeWidth: 4,
            )),
        SizedBox(
            height: 30,
            width: 30,
            child:
                CircularProgressIndicator(color: Colors.amber, strokeWidth: 4)),
      ],
    );
  }

  SfCartesianChart _buildSpacingColumnChart() {
    return SfCartesianChart(
      plotAreaBorderWidth: 0,
      title: ChartTitle(
          text: 'Performance suivant les AXES STRATEGIQUES'),
      primaryXAxis: CategoryAxis(
        title: AxisTitle(text: "Les axes stratégiques"),
        majorGridLines: const MajorGridLines(width: 0),
      ),
      primaryYAxis: NumericAxis(
          title: AxisTitle(text: "Performance en %"),
          maximum: 20,
          minimum: 0,
          interval: 4,
          axisLine: const AxisLine(width: 0),
          majorTickLines: const MajorTickLines(size: 0)),
      series: _getDefaultColumn(),
      legend: Legend(isVisible: true),
      tooltipBehavior: _tooltipBehavior,
    );
  }

  ///Get the column series
  List<ColumnSeries<ChartSampleData, String>> _getDefaultColumn() {
    return <ColumnSeries<ChartSampleData, String>>[
      ColumnSeries<ChartSampleData, String>(

        /// To apply the column width here.
          width: isCardView ? 0.8 : _columnWidth,

          /// To apply the spacing betweeen to two columns here.
          spacing: isCardView ? 0.2 : _columnSpacing,
          dataSource: chartData!,
          color: const Color.fromRGBO(177, 183, 188, 1) ,
          xValueMapper: (ChartSampleData sales, _) => sales.x as String,
          yValueMapper: (ChartSampleData sales, _) => sales.y,
          name: '2022'),
      ColumnSeries<ChartSampleData, String>(
          dataSource: chartData!,
          width: isCardView ? 0.8 : _columnWidth,
          spacing: isCardView ? 0.2 : _columnSpacing,
          color: Colors.blue,
          xValueMapper: (ChartSampleData sales, _) => sales.x as String,
          yValueMapper: (ChartSampleData sales, _) => sales.secondSeriesYValue,
          name: '2023'),
    ];
  }

  @override
  void dispose() {
    chartData!.clear();
    super.dispose();
  }
}

class PerformanceEnjeux extends StatefulWidget {
  const PerformanceEnjeux({Key? key}) : super(key: key);

  @override
  State<PerformanceEnjeux> createState() => _PerformanceEnjeuxState();
}

class _PerformanceEnjeuxState extends State<PerformanceEnjeux> {

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
        height: 650,
        width: double.infinity,
        padding: const EdgeInsets.all(5),
        decoration: const BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.all(Radius.circular(10)),
        ),
        child: Image.asset("assets/images/monthly-average-rainfall.png",scale: 1,)
    );
  }
}

class ChartSampleData {
  final String x;
  final double y;
  final double secondSeriesYValue;
  final double thirdSeriesYValue;
  ChartSampleData({
    required double this.thirdSeriesYValue,
    required String this.x,
    required double this.y,
    required double this.secondSeriesYValue,
  });
}
