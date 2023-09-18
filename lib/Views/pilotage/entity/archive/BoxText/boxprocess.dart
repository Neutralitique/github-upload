import 'package:syncfusion_flutter_charts/charts.dart';
import 'package:flutter/material.dart';
 class BoxProcess extends StatefulWidget {
    final double firstvalue;
    final double secondvalue;
    final String process;
    BoxProcess({super.key,
     required this.firstvalue,
     required this.secondvalue,
      required this.process,
   });

   @override
   State<BoxProcess> createState() => _BoxProcessState();
 }

 class _BoxProcessState extends State<BoxProcess> {
   late List<GDPData> _chartData;
   late TooltipBehavior _tooltipBehavior;

   @override
   void initState() {
     _chartData = getChartData(widget.firstvalue,widget.secondvalue);
     _tooltipBehavior = TooltipBehavior(enable: true);
     super.initState();
   }
   @override
   Widget build(BuildContext context) {
     return Center(
           child: Container(
             height: 90,
             width: 400,
             decoration:BoxDecoration(
               color:Colors.white,
             ),
               child: SfCartesianChart(
                      legend: Legend(isVisible: true),
                  enableAxisAnimation:true,
                     tooltipBehavior: _tooltipBehavior,
                     series: <ChartSeries>[
                       BarSeries<GDPData, String>(
                           name: widget.process,
                           dataSource: _chartData,
                           xValueMapper: (GDPData gdp, _) => gdp.year,
                           yValueMapper: (GDPData gdp, _) => gdp.value,
                           dataLabelSettings: DataLabelSettings(isVisible: true),
                           enableTooltip: true)
                     ],
                      primaryXAxis: CategoryAxis(),
                      primaryYAxis:CategoryAxis(
                        maximum:100, interval:10
                      ) ,
                   ),
                 ),
         );
   }
 }
List<GDPData> getChartData(double firstvalue,double secondvalue) {
  int year = new DateTime.now().year;
  final List<GDPData> chartData = [
    GDPData('${year-1}', firstvalue),
    GDPData('${year}', secondvalue),
  ];
  return chartData;
}

class GDPData {
  GDPData(this.year, this.value);
  final String year;
  final double value;
}