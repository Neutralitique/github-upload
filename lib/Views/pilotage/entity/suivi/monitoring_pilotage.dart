import 'package:flutter/material.dart';
import '../../../../constants/colors.dart';
import '../../../../helpers/responsive.dart';
import '../overview/widgets/suivi_details/section_suivi.dart';
import '../overview/widgets/suivi_details/suivi_details.dart';
import 'widgets/entete_suivi/entete_suivi.dart';
import 'widgets/iframe_suivi_month.dart';
import 'widgets/suivi_mensuel/suivi_mensuel.dart';

class MonitoringPilotage extends StatefulWidget {
  const MonitoringPilotage({Key? key}) : super(key: key);

  @override
  State<MonitoringPilotage> createState() => _MonitoringPilotageState();
}

class _MonitoringPilotageState extends State<MonitoringPilotage> {
  @override
  Widget build(BuildContext context) {
    return Container(
      //padding: const EdgeInsets.only(left: defaultPadding,right: defaultPadding,bottom: defaultPadding,top: 5),
      child: Column(
        children: [
          Container(height: 40,child: EnteteSuivi(),),
          SizedBox(height: 5,),
          Expanded(child: Row(
            children: [
              Expanded(child: Column(
                children:  [
                  SectionSuivi(),
                  SizedBox(height: defaultPadding),
                  Expanded(child: SuiviMensuel())
                ],
              )),
              if (!Responsive.isMobile(context)) const SizedBox(width: defaultPadding),
              const SizedBox(width: 300,child: SuiviDetails())
            ],
          ))
        ],
      ),
    );
  }
}

class MonitoringPilotage2 extends StatefulWidget {
  const MonitoringPilotage2({super.key});

  @override
  State<MonitoringPilotage2> createState() => _MonitoringPilotage2State();
}

class _MonitoringPilotage2State extends State<MonitoringPilotage2> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: [
          Container(height: 40,child: EnteteSuivi(),),
          SizedBox(height: 5,),
          Expanded(child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Expanded(
                      child: Container(
                        padding: const EdgeInsets.all(5),
                        decoration: const BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.all(Radius.circular(10)),
                        ),
                        child: Stack(
                          children: [
                            SuiviMonth(),
                            Positioned(
                              bottom: 300,
                              left: 780,
                              child: Container(width: 100,height: 50,color: Colors.white,),
                            )
                          ],
                        ),
                      ),
                      ),
                    SizedBox(width: 20,),
                    const SizedBox(width: 300,child: SuiviDetails()),
                    SizedBox(width: 15,),
                  ],
                )
              ],
            ),
          ))
        ],
      ),
    );
  }
}

