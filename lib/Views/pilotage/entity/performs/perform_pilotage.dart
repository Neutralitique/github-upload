import 'package:flutter/material.dart';
import 'package:styled_widget/styled_widget.dart';
import '../../../../constants/colors.dart';
import '../../../../module/styled_scrollview.dart';
import 'widgets/entete_performance.dart';
import 'widgets/perform_enjeu/perform_enjeu.dart';
import 'widgets/perform_global/performance_global.dart';
import 'widgets/perform_pilier/performance_piliers.dart';

class PerformPilotage extends StatefulWidget {
  const PerformPilotage({Key? key}) : super(key: key);

  @override
  State<PerformPilotage> createState() => _PerformPilotageState();
}

class _PerformPilotageState extends State<PerformPilotage> {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(right: defaultPadding,bottom: defaultPadding,top: 5),
      child: StyledScrollView(
        child: Column(
          children: [
            SizedBox(
              height: 405,
              child: Row(
                children: [
                  Container(
                      padding: const EdgeInsets.all(5),
                      decoration: const BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.all(Radius.circular(10)),
                      ),
                      child: const PerformanceGlobale()
                  ),
                  SizedBox(width: 10,),
                  Expanded(child: Container(
                      height: double.infinity,
                      padding: const EdgeInsets.all(5),
                      decoration: const BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.all(Radius.circular(10)),
                      ),
                      child: PerformancePiliers())
                  )
                ],
              ),
            ),
            SizedBox(height: 10,),
            Container(
                width: double.infinity,
                decoration: const BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.all(Radius.circular(10)),
                ),
                child: Transform.scale(
                  scale: 0.7,
                  child: Container(height:800,child: PerformanceEnjeu()),
                )
            ),
          ],
        ),
      ),
    );
  }
}
