import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:iconsax/iconsax.dart';
import 'package:switcher/core/switcher_size.dart';
import 'package:switcher/switcher.dart';
import '../../../../widgets/customtext.dart';
import 'menu_nav_pilotage.dart';



class DrawerMenuPilotage extends StatefulWidget {
  const DrawerMenuPilotage({
    Key? key,
  }) : super(key: key);

  @override
  State<DrawerMenuPilotage> createState() => _DrawerMenuPilotageState();
}

class _DrawerMenuPilotageState extends State<DrawerMenuPilotage> {


  @override
  Widget build(BuildContext context) {
    bool isExtended = true;
    return SizedBox(
      width: 250,
      child: Drawer(
        child: SingleChildScrollView(
          child: Column(
            children: [
              const SizedBox(height: 10),
              CustomMenuButton(
                  pathMenu: '/accueil',
                  isFullPath: false,
                  image: "assets/icons/home.png",
                  icon: Icons.home,
                  label: "Accueil",
                  isExtended: isExtended),
              //SizedBox(height: 10),
              CustomMenuButton(
                  pathMenu: '/tableau-de-bord',
                  icon: Icons.table_chart_rounded,
                  image: "assets/icons/table.png",
                  isFullPath: false,
                  label: "Tableau de bord",
                  isExtended: isExtended),
              //SizedBox(height: 10),
              CustomMenuButton(
                  pathMenu: '/performances',
                  icon: Icons.show_chart,
                  image: "assets/icons/performance.png",
                  isFullPath: false,
                  label: "Performances",
                  isExtended: isExtended),
              //SizedBox(height: 10),
              CustomMenuButton(
                  pathMenu: '/suivi-des-donnees',
                  icon: Icons.monitor_outlined,
                  image: "assets/icons/monitoring.png",
                  isFullPath: false,
                  label: "Suivi des données",
                  isExtended: isExtended
              ),
              //SizedBox(height: 10),
              CustomMenuButton(
                  pathMenu: '/profil',
                  image: "assets/icons/profil.png",
                  icon: Icons.person,
                  isFullPath: false,
                  label: "Profil",
                  isExtended: isExtended),
              SizedBox(
                height: 5,
              ),
              Divider(),
              SizedBox(
                height: 5,
              ),
              CustomMenuButton(
                  pathMenu: '/admin',
                  image: "assets/icons/admin.png",
                  icon: Icons.settings,
                  isFullPath: false,
                  label: "Paramètres",
                  isExtended: isExtended),
              //SizedBox(height: 10),
              CustomMenuButton(
                  pathMenu: '/d',
                  icon: Icons.track_changes_outlined,
                  label: "Historiques",
                  image: "",
                  isFullPath: false,
                  isExtended: isExtended),
              //SizedBox(height: 10),
              CustomMenuButton(
                  pathMenu: '/d',
                  icon: Icons.help,
                  image: "",
                  isFullPath: false,
                  label: "Aide",
                  isExtended: isExtended),
              //SizedBox(height: 10),
              CustomMenuButton(
                  pathMenu: '/d',
                  image: "",
                  icon: Icons.comment,
                  isFullPath: false,
                  label: "Commentaires",
                  isExtended: isExtended),
              SizedBox(
                height: 5,
              ),
              Divider(),
              SizedBox(
                height: 5,
              ),
              CustomMenuButton(
                  pathMenu: '/d',
                  icon: Icons.arrow_circle_left_sharp,
                  label: "Accueil Pilotage",
                  image: "assets/icons/back.png",
                  isFullPath: true,
                  isExtended: isExtended),
              SizedBox(height: 10),
              isExtended ? Padding(
                padding: const EdgeInsets.symmetric(vertical: 20),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(
                      Icons.sunny,
                      color: Colors.yellow,
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 8.0),
                      child: Switcher(
                        value: false,
                        onTap: () {},
                        size: SwitcherSize.medium,
                        switcherButtonRadius: 50,
                        enabledSwitcherButtonRotate: true,
                        iconOff: Icons.circle_outlined,
                        iconOn: Icons.circle_outlined,
                        colorOff: Colors.yellow,
                        colorOn: Colors.black,
                        onChanged: (bool state) {
                          //
                        },
                      ),
                    ),
                    const Icon(
                      Iconsax.moon,
                      color: Colors.black,
                    )
                  ],
                ),
              ) : Container(),
            ],
          ),
        ),
      ),
    );
  }
}
