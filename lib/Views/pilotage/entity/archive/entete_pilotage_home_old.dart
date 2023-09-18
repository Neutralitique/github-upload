/*
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:go_router/go_router.dart';
import 'package:quds_popup_menu/quds_popup_menu.dart';
import '../../../../constants/colors.dart';
import '../../../../helper/responsive.dart';
import '../../../../widgets/custom_text.dart';
import '../../controllers/side_menu_controller.dart';

class AppBarEntiteHome extends StatefulWidget {
  const AppBarEntiteHome({Key? key}) : super(key: key);

  @override
  State<AppBarEntiteHome> createState() => _AppBarEntiteHomeState();
}

class _AppBarEntiteHomeState extends State<AppBarEntiteHome> {
  var avatarString = "HH";
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 60,
      color: headerApp,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Row(
            children: [
              SizedBox(width: 20,),
              IconButton(
                splashRadius: 25,
                padding: EdgeInsets.zero,onPressed: (){},
                icon: Icon(Icons.menu,size: 30,color: Colors.white,),
              ),
              SizedBox(width: 20,),
              InkWell(
                onTap: (){
                  context.go('/');
                },
                child: Tooltip(
                  message: "Accueil Générale Perf RSE",
                  child: Image.asset(
                    "assets/logos/perf_rse.png",
                    height: 50,
                  ),
                ),
              ),
              SizedBox(width: 20,),
              const Text(
                "Sucrivoire Siège",
                style: TextStyle(
                    fontSize: 20, fontWeight: FontWeight.bold, color: Colors.black),
              ),
            ],
          ),
          Row(
            children: [
              const Center(
                child: CustomText(
                  text: "Fabrice H.",
                  color: Colors.white,
                  weight: FontWeight.bold,
                  size: 15,
                ),
              ),
              const SizedBox(
                width: 20,
              ),
              QudsPopupButton(
                  items: getMenuItems(),
                  child: CircleAvatar(
                    backgroundColor: Color(0xFFFFFF00),
                    child: Center(
                      child: CustomText(
                        text: avatarString,
                        color: Color(0xFFF1C232),
                        weight: FontWeight.bold,
                      ),
                    ),
                  )),
              const SizedBox(width: 30,),
              TextButton(
                child: const Text(
                  "A propos de Perf RSE",
                  style: TextStyle(color: Colors.black, decoration: TextDecoration.underline),),
                onPressed: () {},
              ),
              const SizedBox(
                width: 30,
              ),
            ],
          )
        ],
      ),
    );
  }

  List<QudsPopupMenuBase> getMenuItems() {
    String avatarString = "HH";
    return [
      QudsPopupMenuItem(
          leading: CircleAvatar(
            backgroundColor: Color(0xFFFFFF00),
            child: Center(
              child: CustomText(
                text: avatarString,
                color: Color(0xFFF1C232),
                weight: FontWeight.bold,
              ),
            ),
          ),
          title: const Text(
            'Fabrice HOUESSOU',
            style: TextStyle(fontSize: 13, fontWeight: FontWeight.bold),
          ),
          subTitle: Text('fabdev6@gmail.com'),
          onPressed: () {}),
      QudsPopupMenuDivider(),
      QudsPopupMenuItem(
          leading: const Icon(Icons.person,color: Colors.blue,size: 30,),
          title: Text(
            'Mon Profil',
            style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
          ),
          subTitle: Text('Informations du compte et plus'),
          onPressed: () {
          }),
      QudsPopupMenuWidget(
          builder: (c) => Container(
              padding: EdgeInsets.all(10),
              width: 200,
              child: IntrinsicHeight(
                child: ElevatedButton(
                    onPressed: () {
                      showDialog(
                        context: Get.context!,
                        builder: (BuildContext context) {
                          return AlertDialog(
                            title: Text('Voulez-vous quitter cette application ?'),
                            content: SizedBox(width:200,child: Text('On somme désolé te voir partir...')),
                            actionsAlignment: MainAxisAlignment.spaceBetween,
                            actions: <Widget>[
                              OutlinedButton(
                                onPressed: () {
                                  Navigator.pop(context);
                                },
                                child: Text('Non'),
                              ),
                              OutlinedButton(
                                onPressed: () {
                                  Get.toNamed("/login");
                                },
                                child: Text('Oui'),
                              ),
                            ],
                          );
                        },);
                    },
                    style: ElevatedButton.styleFrom(
                      primary: Colors.amber,
                      shape: const StadiumBorder(),
                    ),
                    child: Container(
                      alignment: Alignment.center,
                      width: double.maxFinite,
                      padding: const EdgeInsets.symmetric(vertical: 10),
                      child: const CustomText(
                        text: "Se déconnecter",
                        color: Colors.white,
                      ),
                    )),
              )))
    ];
  }
}


class HeaderEntitePilotage extends StatefulWidget {
  final String title;
  const HeaderEntitePilotage({Key? key, required this.title}) : super(key: key);

  @override
  State<HeaderEntitePilotage> createState() => _HeaderEntitePilotageState();
}

class _HeaderEntitePilotageState extends State<HeaderEntitePilotage> {
  final SideMenuController sideMenuController = Get.find();
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: defaultPadding,right: 8),
      child: Row(
        children: [
          if (!Responsive.isDesktop(context))
            IconButton(
              splashRadius: 20,
              icon: const Icon(Icons.menu),
              onPressed: (){
                sideMenuController.controlMenu();
              },
            ),
          if (!Responsive.isMobile(context)) urlPathToTitleWidget(widget.title),
          SizedBox(width: 20,),
          Expanded(child: Container()),
          if (widget.title == "tableau-de-bord") Container(width :350,child: SearchField()),
          QudsPopupButton(
            radius: 0.0,
              items: getMenuItems(),
              child: const ProfileCard()
          )
        ],
      ),
    );
  }
  List<QudsPopupMenuBase> getMenuItems() {
    String avatarString = "HH";
    return [
      QudsPopupMenuItem(
          leading: CircleAvatar(
            backgroundColor: Color(0xFFFFFF00),
            child: Center(
              child: CustomText(
                text: avatarString,
                color: Color(0xFFF1C232),
                weight: FontWeight.bold,
              ),
            ),
          ),
          title: const Text(
            'Fabrice HOUESSOU',
            style: TextStyle(fontSize: 13, fontWeight: FontWeight.bold),
          ),
          subTitle: Text('fabdev6@gmail.com'),
          onPressed: () {}),
      QudsPopupMenuDivider(),
      QudsPopupMenuItem(
          leading: const Icon(Icons.person,color: Colors.blue,size: 30,),
          title: Text(
            'Mon Profil',
            style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
          ),
          subTitle: Text('Informations du compte et plus'),
          onPressed: () {
            context.go("/pilotage/entite/profil");
          }),
      QudsPopupMenuWidget(
          builder: (c) => Container(
              padding: EdgeInsets.all(10),
              width: 200,
              child: IntrinsicHeight(
                child: ElevatedButton(
                    onPressed: () {
                      showDialog(
                        context: context,
                        builder: (BuildContext context) {
                          return AlertDialog(
                            title: const Text('Voulez-vous quitter cette application ?'),
                            content: const SizedBox(width:200,child: Text('Nous sommes désolés de vous voir partir...')),
                            actionsAlignment: MainAxisAlignment.spaceBetween,
                            actions: <Widget>[
                              OutlinedButton(
                                onPressed: () {
                                  Navigator.pop(context);
                                },
                                child: Text('Non'),
                              ),
                              OutlinedButton(
                                onPressed: () {
                                  context.go('/account/login');
                                },
                                child: Text('Oui'),
                              ),
                            ],
                          );
                        },);
                    },
                    style: ElevatedButton.styleFrom(
                      primary: Colors.amber,
                      shape: const StadiumBorder(),
                    ),
                    child: Container(
                      alignment: Alignment.center,
                      width: double.maxFinite,
                      padding: const EdgeInsets.symmetric(vertical: 10),
                      child: const CustomText(
                        text: "Se déconnecter",
                        color: Colors.white,
                      ),
                    )),
              )))
    ];
  }

  Widget urlPathToTitleWidget(String menu) {
    switch (menu){
      case "vue-d-ensemble":
        return const TitleWidget(
          logo: "assets/logos/logo_sucrivoire.png",
          entiteTitle: "Sucrivoire Siège", iconCard: Icon(Icons.home, size: 30,),
          cardTile: "Vue d'ensemble",
        );
      case "tableau-de-bord":
        return const TitleWidget(
          logo: "assets/logos/logo_sucrivoire.png",
          entiteTitle: "Sucrivoire Siège", iconCard: Icon(Icons.table_chart_rounded,size: 30,),
          cardTile: "Tableau de bord",
        );
      case "performances":
        return const TitleWidget(
          logo: "assets/logos/logo_sucrivoire.png",
          entiteTitle: "Sucrivoire Siège", iconCard: Icon(Icons.bar_chart,size: 30,),
          cardTile: "Performances",
        );
      case "suivi-des-donnees":
        return const TitleWidget(
          logo: "assets/logos/logo_sucrivoire.png",
          entiteTitle: "Sucrivoire Siège", iconCard: Icon(Icons.monitor,size: 30,),
          cardTile: "Suivi des données",
        );
      case "admin":
        return Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            const CustomText(
              text: "Pilotage",
              size: 20,
              weight: FontWeight.bold,
            ),
            const SizedBox(
              width: 5,
            ),
            Image.asset("assets/logos/logo_sifca_bon.png",height: 40,fit: BoxFit.fitWidth,),
            const SizedBox(
              width: 5,
            ),
            const SizedBox(
              width: 5,
            ),
            const Icon(
              Icons.group_add_rounded,
              size: 30,
            ),
            const SizedBox(
              width: 5,
            ),
            const CustomText(text: "Centre d'administration",color: Colors.grey,)
          ],
        );
      case "profil":
        return Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.start,
          children: const [
            CustomText(
              text: "Pilotage",
              size: 20,
              weight: FontWeight.bold,
            ),
            SizedBox(
              width: 5,
            ),
            Icon(
              Icons.person,
              size: 30,
            ),
            SizedBox(
              width: 5,
            ),
            CustomText(text: "Profil",color: Colors.grey,)
          ],
        );
      default :
        return Container();
    }
  }
}


class ProfileCard extends StatelessWidget {
  const ProfileCard({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(left: defaultPadding),
      padding: const EdgeInsets.symmetric(
        horizontal: defaultPadding,
        vertical: 5,
      ),
      decoration: BoxDecoration(
        color: secondaryColor,
        borderRadius: const BorderRadius.all(Radius.circular(10)),
        border: Border.all(color: Colors.white10),
      ),
      child: Row(
        children: [
          Image.asset(
            "assets/images/profil_person.png",
            height: 38,
          ),
          if (!Responsive.isMobile(context))
            const Padding(
              padding:
              EdgeInsets.symmetric(horizontal: defaultPadding / 2),
              child: Text("Fabrice HOUESSOU"),
            ),
          const Icon(Icons.keyboard_arrow_down),
        ],
      ),
    );
  }
}

class TitleWidget extends StatefulWidget {
  final String logo,entiteTitle,cardTile;
  final Icon iconCard;
  const TitleWidget({Key? key, required this.logo, required this.entiteTitle, required this.cardTile, required this.iconCard}) : super(key: key);

  @override
  State<TitleWidget> createState() => _TitleWidgetState();
}

class _TitleWidgetState extends State<TitleWidget> {
  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        const CustomText(
          text: "Pilotage",
          size: 20,
          weight: FontWeight.bold,
        ),
        const SizedBox(
          width: 5,
        ),
        Image.asset(widget.logo,height: 60,fit: BoxFit.fitWidth,),
        const SizedBox(
          width: 5,
        ),
        const CustomText(text: "Entité",size: 20,),
        const SizedBox(
          width: 5,
        ),
        Container(
          decoration: const BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.all(Radius.circular(10)),
          ),
          padding: const EdgeInsets.all(10),
          child: Row(
            children: [
              CustomText(text: widget.entiteTitle,),
              SizedBox(width: 10,),
              Icon(Icons.arrow_drop_down_outlined,color: Colors.grey,)
            ],
          ),
        ),
        const SizedBox(
          width: 5,
        ),
        widget.iconCard,
        const SizedBox(
          width: 10,
        ),
        CustomText(
          text: widget.cardTile,
          color: Colors.grey,
        )
      ],
    );
  }
}


class SearchField extends StatelessWidget {
  const SearchField({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextField(
      decoration: InputDecoration(
        hintText: "Recherche d'un indicateur par mots clés",
        fillColor: secondaryColor,
        hintStyle: TextStyle(fontSize: 15),
        filled: true,
        border: const OutlineInputBorder(
          borderSide: BorderSide.none,
          borderRadius: BorderRadius.all(Radius.circular(10)),
        ),
        suffixIcon: InkWell(
          onTap: () {},
          child: Container(
            padding: const EdgeInsets.all(defaultPadding * 0.75),
            margin: EdgeInsets.symmetric(horizontal: defaultPadding / 2),
            decoration: const BoxDecoration(
              color: primaryColor,
              borderRadius: BorderRadius.all(Radius.circular(10)),
            ),
            child: SvgPicture.asset("assets/icons/Search.svg"),
          ),
        ),
      ),
    );
  }
}





*/
