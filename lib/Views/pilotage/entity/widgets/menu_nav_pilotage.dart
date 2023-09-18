import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:go_router/go_router.dart';
import 'package:iconsax/iconsax.dart';
import 'package:just_the_tooltip/just_the_tooltip.dart';
import 'package:perfqse/Views/pilotage/controllers/controllerEntity.dart';
import 'package:switcher/core/switcher_size.dart';
import 'package:switcher/switcher.dart';
import '../../../../constants/colors.dart';
import '../../controllers/side_menu_controller.dart';

class MenuNavPilotage extends StatefulWidget {
  final String responsive;
  const MenuNavPilotage({super.key, required this.responsive});

  @override
  State<MenuNavPilotage> createState() => _MenuNavPilotageState();
}

class _MenuNavPilotageState extends State<MenuNavPilotage> {

  final SideMenuController sideMenuController = Get.find();

  @override
  Widget build(BuildContext context) {
    switch (widget.responsive){
      case "cas-0":
        return Container();
      case "cas-1":
        return Container();
      case "cas-2":
        return menuPilotage(70,false);
      case "cas-3":
        return menuPilotage(70,false);
      case "cas-4":
        return Obx(() => menuPilotage(sideMenuController.cas4Extended.value ? 250:70, sideMenuController.cas4Extended.value));
      default :
        return Container();
    }
  }

  Widget menuPilotage(double largeur,bool isExtended) {
    return Container(
      width: largeur,
      child: Column(
        children: [
          SizedBox(height: 10),
          CustomMenuButton(
              pathMenu: '/accueil',
              image: "assets/icons/home.png",
              isFullPath:false,
              icon: Icons.home,
              label: "Accueil",
              isExtended: isExtended),
          //SizedBox(height: 10),
          CustomMenuButton(
              pathMenu: '/tableau-de-bord',
              image: "assets/icons/table.png",
              icon: Icons.table_chart_rounded,
              isFullPath:false,
              label: "Tableau de bord",
              isExtended: isExtended),
          //SizedBox(height: 10),
          CustomMenuButton(
              pathMenu: '/performances',
              image: "assets/icons/performance.png",
              icon: Icons.show_chart,
              isFullPath:false,
              label: "Performances",
              isExtended: isExtended),
          //SizedBox(height: 10),
          CustomMenuButton(
              pathMenu: '/suivi-des-donnees',
              image: "assets/icons/monitoring.png",
              icon: Icons.monitor_outlined,
              isFullPath:false,
              label: "Suivi des données",
              isExtended: isExtended
          ),
          //SizedBox(height: 10),
          CustomMenuButton(
              pathMenu: '/profil',
              image: "assets/icons/profil.png",
              icon: Icons.person,
              isFullPath:false,
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
              isFullPath:false,
              label: "Paramètres",
              isExtended: isExtended),
          //SizedBox(height: 10),
          CustomMenuButton(
              pathMenu: '/d',
              image: "",
              icon: Icons.track_changes_outlined,
              label: "Historiques",
              isFullPath:false,
              isExtended: isExtended),
          //SizedBox(height: 10),
          CustomMenuButton(
              pathMenu: '/d',
              image: "",
              icon: Icons.help,
              isFullPath:false,
              label: "Aide",
              isExtended: isExtended),
          //SizedBox(height: 10),
          CustomMenuButton(
              pathMenu: '/d',
              image: "",
              icon: Icons.comment,
              isFullPath:false,
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
              pathMenu: '/pilotage',
              image: "assets/icons/back.png",
              isFullPath:true,
              icon: Icons.arrow_circle_left_sharp,
              label: "Accueil Pilotage",
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
                Icon(
                  Iconsax.moon,
                  color: Colors.black,
                )
              ],
            ),
          ) : Container(),
        ],
      ),
    );
  }
}

class CustomMenuButton extends StatefulWidget {
  final String pathMenu;
  final bool isExtended;
  final String image;
  final bool isFullPath;
  final String label;
  final IconData icon;
  const CustomMenuButton(
      {super.key,
        required this.isExtended,
        required this.label,
        required this.icon,
        required this.pathMenu, required this.isFullPath, required this.image});

  @override
  State<CustomMenuButton> createState() => _CustomMenuButtonState();
}

class _CustomMenuButtonState extends State<CustomMenuButton> {
  final ControllerEntity _controllerEntity = Get.find();
  
  bool _isHovering = false;
  bool isSelected = false;
  String _rootLocation = "/pilotage/espace/";

  final SideMenuController sideMenuController = Get.find();

  bool calculateSelectedIndex(BuildContext context) {
     _rootLocation = "/pilotage/espace/${_controllerEntity.headerNom.value}";
    final String location = GoRouterState.of(context).location;
    if (location.endsWith(widget.pathMenu)) {
      return true;
    }
    return false;
  }

  @override
  Widget build(BuildContext context) {
    _rootLocation = "/pilotage/espace/${_controllerEntity.headerNom.value}";
    isSelected = calculateSelectedIndex(context);
    return widget.isExtended ? InkWell(
      overlayColor: MaterialStateProperty.all(Colors.transparent),
      onTap: () {},
      onHover: (isHovering) {
        setState(() {
          _isHovering = isHovering;
        });
      },
      child: Container(
        height: 35,
        width:240,
        decoration: BoxDecoration(
            color: isSelected
                ? _isHovering
                ?  red //Color(0xFFEEEEEE)
                : red //Color(0xFFE8F0FE)
                : Colors.transparent,
            borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(20),
                bottomLeft: Radius.circular(20))),
        child: Center(
          child: OutlinedButton(
            style: OutlinedButton.styleFrom(
              backgroundColor: Colors.transparent,
              foregroundColor: Colors.transparent,
              side: const BorderSide(
                color: Colors.transparent,
              ),
              shape: const RoundedRectangleBorder(
                  borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(20),
                      bottomLeft: Radius.circular(20))),
            ),
            onPressed: () async{
              if (widget.pathMenu != "/d") {
                if (widget.isFullPath == false) {
                  GoRouter.of(context).go(_rootLocation+widget.pathMenu);
                  bool isOpenDrawer = sideMenuController.checkIsDrawerOpen();
                  //showDebugMessage(context,"Drawer Menu ${isOpenDrawer}");
                  if (isOpenDrawer){
                    await Future.delayed(Duration(milliseconds: 33));
                    sideMenuController.controlMenu();
                  }
                } else if (widget.isFullPath == true) {
                  GoRouter.of(context).go(widget.pathMenu);
                }

              }
            },
            child: Row(
              children: [
                SizedBox(
                  width: 3,
                ),
                widget.image == "" ? Icon(
                  widget.icon,
                  size: 25,
                  color: isSelected ? Colors.white : Colors.black,
                ) : Image.asset(widget.image,width: 25,),
                /*,*/
                SizedBox(
                  width: 15,
                ),
                Text(
                  widget.label,
                  style: TextStyle(
                      fontSize:18,
                      color: isSelected ?
                      Colors.white//Color(0xFF114693)
                          : Colors.black),
                )
              ],
            ),
          ),
        ),
      ),
    ) : smallMenu(isSelected);
  }

  Widget smallMenu(bool isSelected){
    return Row(
      children: [
        SizedBox(
          width: 19,
        ),
        InkWell(
          hoverColor: Colors.transparent,
          onHover: (value){
            setState(() {
              _isHovering = value;
            });
          },
          onTap: (){
          },
          child: JustTheTooltip(
            preferredDirection: AxisDirection.right,
            backgroundColor: Color(0xFF616161),
            waitDuration: Duration(milliseconds: 500),
            content: Container(
              padding: const EdgeInsets.all(8.0),
              child: Text(widget.label,style: TextStyle(color: Colors.white),),
            ),
            child: Container(
              width: 40,
              height: 40,
              decoration: isSelected ? BoxDecoration(
                shape: BoxShape.circle,//Color(0xFFEEEEEE)
                color: isSelected ?Colors.red :Color(0xFFE8F0FE),
              ):null,
              child: IconButton(
                onPressed: (){
                  if (widget.pathMenu != "/d") {
                    GoRouter.of(context).go(_rootLocation+widget.pathMenu);
                  }
                },
                splashRadius: 20,
                padding: EdgeInsets.zero,//Color(0xFF114693)
                icon: Icon(widget.icon,size:isSelected? 30:25,color: isSelected ? Colors.white : Colors.black),
              ),
            ),
          ),
        ),
      ],
    );
  }


}