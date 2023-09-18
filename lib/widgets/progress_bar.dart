import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_gauges/gauges.dart';

class ProgressBar extends StatelessWidget {
  const ProgressBar({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final Brightness brightness = Theme.of(context).brightness;
    const double progressValue = 41.467;
    return Stack(children: <Widget>[
      Padding(
          padding: const EdgeInsets.all(10),
          child: Center(
              child: ClipRRect(
                  borderRadius: BorderRadius.circular(15),
                  child: SizedBox(
                      height: 20,
                      child: SfLinearGauge(
                        showTicks: false,
                        showLabels: false,
                        animateAxis: true,
                        animationDuration: 3000,
                        axisTrackStyle: LinearAxisTrackStyle(
                          thickness: 20,
                          edgeStyle: LinearEdgeStyle.bothCurve,
                          borderWidth: 1,
                          borderColor: brightness == Brightness.dark
                              ? const Color(0xff898989)
                              : Colors.grey[350],
                          color: brightness == Brightness.dark
                              ? Colors.transparent
                              : Colors.grey[350],
                        ),
                        barPointers: const <LinearBarPointer>[
                          LinearBarPointer(
                              value: progressValue,
                              thickness: 20,
                              edgeStyle: LinearEdgeStyle.bothCurve,
                              color: Colors.blue),
                        ],
                      ))))),
      Align(
          alignment: Alignment.centerLeft,
          child: Padding(
              padding: const EdgeInsets.only(right: 30,left: 15,top: 12,bottom: 15),
              child: Text(
                progressValue.toStringAsFixed(2) + '%',
                style: const TextStyle(fontSize: 14, color: Color(0xffFFFFFF)),
              ))),
    ]);
  }
}
