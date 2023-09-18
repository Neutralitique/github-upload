// import 'package:fl_chart/fl_chart.dart';
// import 'package:flutter/material.dart';
//
//
// class PieChartDonnut extends StatefulWidget {
//   final double numFull;
//   final Color colorFull;
//   final Color colorEmpty;
//   const PieChartDonnut({super.key,
//     required this.numFull,
//     required this.colorFull,
//     required this.colorEmpty});
//
//   @override
//   State<PieChartDonnut> createState() => PieChartDonnutState();
// }
//
// class PieChartDonnutState extends State<PieChartDonnut> {
//   int touchedIndex = -1;
//
//
//   @override
//   Widget build(BuildContext context) {
//     return AspectRatio(
//       aspectRatio: 1.3,
//       child:Expanded(
//         child: AspectRatio(
//           aspectRatio: 1,
//           child: PieChart(
//             swapAnimationDuration:const Duration(seconds: 1000),
//             swapAnimationCurve:Curves.fastLinearToSlowEaseIn,
//             PieChartData(
//               pieTouchData: PieTouchData(
//                 touchCallback: (FlTouchEvent event, pieTouchResponse) {
//                   setState(() {
//                     if (!event.isInterestedForInteractions ||
//                         pieTouchResponse == null ||
//                         pieTouchResponse.touchedSection == null) {
//                       touchedIndex = -1;
//                       return;
//                     }
//                     touchedIndex = pieTouchResponse
//                         .touchedSection!.touchedSectionIndex;
//                   });
//                 },
//               ),
//               borderData: FlBorderData(
//                 show: false,
//               ),
//               sectionsSpace: 0,
//               centerSpaceRadius: 30,
//               sections: showingSections(),
//             ),
//           ),
//         ),
//       ),
//     );
//   }
//
//   List<PieChartSectionData> showingSections() {
//     return List.generate(2, (i) {
//       final num numEmpCal=100-widget.numFull;
//       final double numEmpty= numEmpCal.toDouble();
//       final isTouched = i == touchedIndex;
//       final fontSize = isTouched ? 17.0 :12.0;
//       final radius = isTouched ? 30.0 : 15.0;//25.0;
//       const shadows = [Shadow(color: Colors.black, blurRadius: 2)];
//       switch (i) {
//         case 0:
//           return PieChartSectionData(
//             color:widget.colorEmpty,
//             value: widget.numFull,
//             showTitle:true,
//             title: "${widget.numFull.toString()}%",
//             radius: radius,
//             titleStyle: TextStyle(
//               fontSize: fontSize,
//               fontWeight: FontWeight.bold,
//               color: Colors.black,
//             ),
//           );
//         case 1:
//           return PieChartSectionData(
//             color:widget.colorFull,
//             value: numEmpty,
//             title: "${numEmpty.toString()}%",
//             radius: radius,
//             titleStyle: TextStyle(
//               fontSize: fontSize,
//               fontWeight: FontWeight.bold,
//               color: Colors.black,
//             ),
//           );
//         default:
//           throw Error();
//       }
//     });
//   }
// }