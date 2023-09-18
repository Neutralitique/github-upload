import 'package:contained_tab_bar_view/contained_tab_bar_view.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:tab_indicator_styler/tab_indicator_styler.dart';
import '../../../../widgets/customtext.dart';
import 'widgets/entity_admin_pilotage.dart';
import 'widgets/indicator_admin_pilotage.dart';
import 'widgets/user_admin_pilotage/user_admin_pilotage.dart';
import '../../../../constants/colors.dart';

class AdministrationPilotage extends StatefulWidget {
  const AdministrationPilotage({Key? key}) : super(key: key);

  @override
  State<AdministrationPilotage> createState() => _AdministrationPilotageState();
}

class _AdministrationPilotageState extends State<AdministrationPilotage> with SingleTickerProviderStateMixin {

  static const List<Tab> myTabs = <Tab>[
    Tab(text: 'Gestion des utilisateurs'),
    Tab(text: 'Gestion des indicateurs'),
    Tab(text: 'Gestion des Filiales et Entités'),
  ];

  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(vsync: this, length: myTabs.length,initialIndex: 0);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
        padding: const EdgeInsets.only(right: defaultPadding),
        child: SizedBox(
          width: double.maxFinite,
          child: ContainedTabBarView(
            tabBarViewProperties: const TabBarViewProperties(
              physics: BouncingScrollPhysics(),
              dragStartBehavior: DragStartBehavior.start,
            ),
            tabBarProperties: TabBarProperties(
                alignment: TabBarAlignment.center,
                isScrollable: true,
                labelColor: Colors.black,
                labelPadding: const EdgeInsets.only(left: 0,right: 30),
                unselectedLabelColor: Colors.amber,
                indicator: MaterialIndicator(
                  color: Colors.amber,
                  paintingStyle: PaintingStyle.fill,
                )
            ),
            tabs: const [
              Padding(
                padding: const EdgeInsets.all(4.0),
                child: Center(child: CustomText(text: "Gestion des utilisateurs",size: 15,)),
              ),// Ajjouter , Modifier , Suppression d'itilisateur et acces
              Padding(
                padding: const EdgeInsets.all(4.0),
                child: Center(child: CustomText(text: "Gestion des indicateurs",size:15 ,)),
              ),// Gestion de la base de données d'indicateurs
              Padding(
                padding: const EdgeInsets.all(4.0),
                child: Center(child: CustomText(text: "Gestion des Filiales et Entités",size:15,)),
              ),
            ],
            views: const [
              UserAdmin(),
              IndicatorAdmin(),
              EntityAdmin()
            ],
          ),
        )
    );
  }
}



