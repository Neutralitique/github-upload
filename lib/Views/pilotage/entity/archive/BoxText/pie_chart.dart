import 'package:flutter/material.dart';
import 'package:pie_chart/pie_chart.dart';

class PieChartDonnut extends StatefulWidget {
  final double numFull;
  final Color colorFull;
  final Color colorEmpty;
  const PieChartDonnut({super.key,
    required this.numFull,
    required this.colorFull,
    required this.colorEmpty});

  @override
  State<PieChartDonnut> createState() => PieChartDonnutState();
}

class PieChartDonnutState extends State<PieChartDonnut> {
  int touchedIndex = -1;

  final gradientList = <List<Color>>[
    [
      Color.fromRGBO(223, 250, 92, 1),
      Color.fromRGBO(129, 250, 112, 1),
    ],
    [
      Color.fromRGBO(129, 182, 205, 1),
      Color.fromRGBO(91, 253, 199, 1),
    ],
    [
      Color.fromRGBO(175, 63, 62, 1.0),
      Color.fromRGBO(254, 154, 92, 1),
    ]
  ];

  @override
  Widget build(BuildContext context) {
    final double numEmpCal=100-widget.numFull;
    Map<String, double> dataMap = {
      "numFull": widget.numFull,
      "numEmpty":numEmpCal
    };

    List<Color> colorList = [
      widget.colorFull,
      widget.colorEmpty
    ];

    return Center(
      child: PieChart(
        dataMap: dataMap,
        chartType: ChartType.ring,
        baseChartColor: Colors.grey[50]!.withOpacity(0.15),
        colorList: colorList,
        initialAngleInDegree: 0,
        chartRadius:100,
        ringStrokeWidth:13,
        animationDuration: const Duration(seconds: 4),
        centerText: "",
        chartValuesOptions: ChartValuesOptions(
          showChartValuesInPercentage: true,
        ),
        legendOptions:const LegendOptions(
            showLegends:false,
        ),
        totalValue: 100,
      ),
    );
  }

  // List<PieChartSectionData> showingSections() {
  //   return List.generate(2, (i) {
  //     final num numEmpCal=100-widget.numFull;
  //     final double numEmpty= numEmpCal.toDouble();
  //     final isTouched = i == touchedIndex;
  //     final fontSize = isTouched ? 17.0 :12.0;
  //     final radius = isTouched ? 20.0 : 15.0;//25.0;
  //     const shadows = [Shadow(color: Colors.black, blurRadius: 2)];
  //     switch (i) {
  //       case 0:
  //         return PieChartSectionData(
  //           color:widget.colorEmpty,
  //           value: widget.numFull,
  //             showTitle:true,
  //           title: "${widget.numFull.toString()}%",
  //           radius: radius,
  //           titleStyle: TextStyle(
  //             fontSize: fontSize,
  //             fontWeight: FontWeight.bold,
  //             color: Colors.black,
  //           ),
  //         );
  //       case 1:
  //         return PieChartSectionData(
  //           color:widget.colorFull,
  //           value: numEmpty,
  //           title: "${numEmpty.toString()}%",
  //           radius: radius,
  //           titleStyle: TextStyle(
  //             fontSize: fontSize,
  //             fontWeight: FontWeight.bold,
  //             color: Colors.black,
  //           ),
  //         );
  //       default:
  //         throw Error();
  //     }
  //   });
  // }
}