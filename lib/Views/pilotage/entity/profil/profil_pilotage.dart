import 'package:contained_tab_bar_view/contained_tab_bar_view.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:tab_indicator_styler/tab_indicator_styler.dart';

import '../../../../constants/colors.dart';
import '../../../../models/common/user_model.dart';
import '../../../../models/pilotage/acces_pilotage_model.dart';
import '../../../../widgets/customtext.dart';
import 'widgets/export_widget_profile.dart';

class ProfilPilotage extends StatefulWidget {
  final UserModel userModel;
  final AccesPilotageModel accesPilotageModel;
  const ProfilPilotage({Key? key, required this.userModel, required this.accesPilotageModel}) : super(key: key);

  @override
  State<ProfilPilotage> createState() => _ProfilPilotageState();
}

class _ProfilPilotageState extends State<ProfilPilotage> with SingleTickerProviderStateMixin {
  static const List<Tab> myTabs = <Tab>[
    Tab(text: 'Informations Personnelles'),
    Tab(text: 'Informations du Compte'),
    Tab(text: 'Modifier mon mot de passe'),
  ];

  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController =
        TabController(vsync: this, length: myTabs.length, initialIndex: 0);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(right: defaultPadding,bottom: defaultPadding),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Expanded(
            child: SizedBox(
              width: double.maxFinite,
              child: ContainedTabBarView(
                tabBarViewProperties: const TabBarViewProperties(
                  physics: BouncingScrollPhysics(),
                  dragStartBehavior: DragStartBehavior.start,
                ),
                tabBarProperties: TabBarProperties(
                    alignment: TabBarAlignment.start,
                    isScrollable: true,
                    labelColor: Colors.black,
                    labelPadding:
                    const EdgeInsets.only(left: 0, right: 30),
                    unselectedLabelColor: Colors.amber,
                    indicator: MaterialIndicator(
                      color: Colors.amber,
                      paintingStyle: PaintingStyle.fill,
                    )),
                tabs: const [
                  CustomText(
                    text: "Informations Personnelles",
                    size: 15,
                  ),
                  CustomText(
                    text: "Informations du Compte",
                    size: 15,
                  ),
                  CustomText(
                    text: "Modifier mon mot de passe",
                    size: 15,
                  ),
                ],
                views: [
                  Container(child: InfosPilote(userModel: widget.userModel,accesPilotageModel: widget.accesPilotageModel,),),
                  Container(child: InfosCompte(userModel: widget.userModel,accesPilotageModel: widget.accesPilotageModel,),),
                  Container(child: PasswordPilote(userModel: widget.userModel,accesPilotageModel: widget.accesPilotageModel,),)
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }


  Map<String,dynamic> getUserEntityInfos(){
    return {
      "entite_id":"sucrivoire"
    };
  }
}
