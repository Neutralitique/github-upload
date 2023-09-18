/*
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:perf_rse/modules/styled_scrollview.dart';
import 'package:perf_rse/views/pilotage/controllers/side_menu_controller.dart';
import 'package:perf_rse/views/pilotage/entite/archive/side_menu_pilotage._olddart';
import '../../../../helper/responsive.dart';
import 'package:get/get.dart';

import '../admin/admin_pilotage.dart';
import '../overview/overview_pilotage.dart';
import '../performs/perform_pilotage.dart';
import '../profil/profil_pilotage.dart';
import '../suivi/monitoring_pilotage.dart';
import '../tableau_bord/tableau_bord_pilotage..dart';
import 'entete_pilotage_home_old.dart';


class PilotageEntiteOverview extends StatefulWidget {
  final String urlPath;
  const PilotageEntiteOverview({Key? key, required this.urlPath}) : super(key: key);

  @override
  State<PilotageEntiteOverview> createState() => _PilotageEntiteOverviewState();
}

class _PilotageEntiteOverviewState extends State<PilotageEntiteOverview> {
  final SideMenuController sideMenuController = Get.put(SideMenuController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: sideMenuController.scaffoldKey,
      drawer: SideMenuPilotage(currentPath: widget.urlPath,),
      body: SafeArea(
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              if (Responsive.isDesktop(context)) SideMenuPilotage(currentPath: widget.urlPath,),
              Expanded(
                child: Column(
                  children: [
                    HeaderEntitePilotage( title: '${widget.urlPath}',),
                    Expanded(
                        child: contentEntitePilotage(widget.urlPath)
                    )
                    //OverviewPilotage(),
                  ],
                ),
              ),
            ],
          )),
    );
  }
  Widget contentEntitePilotage(String menu) {
    switch (menu){
      case "vue-d-ensemble":
        return const OverviewPilotage();
      case "tableau-de-bord":
        return const TableauBordPilotage();
      case "performances":
        return const PerformPilotage();
      case "suivi-des-donnees":
        return const MonitoringPilotage();
      case "admin":
        return const AdministrationPilotage();
      case "profil":
        return const ProfilPilotage();
      default :
        return Center(child: Text(menu),);
    }
  }
}

*/
