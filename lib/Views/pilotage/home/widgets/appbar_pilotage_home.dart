import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:go_router/go_router.dart';
import 'package:quds_popup_menu/quds_popup_menu.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../../../../widgets/customtext.dart';
import '../../../../models/common/user_model.dart';

class appBarPilotageHome extends StatefulWidget {
  final String title;
  final  mainData;
  const appBarPilotageHome({Key? key, required this.title, required this.mainData}) : super(key: key);

  @override
  State<appBarPilotageHome> createState() => _appBarPilotageHomeState();
}

class _appBarPilotageHomeState extends State<appBarPilotageHome> {
  final storage = new FlutterSecureStorage();

  @override
  Widget build(BuildContext context) {
    return Container(
        height: 53,
        color: Colors.black54,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              children: [
                const SizedBox(
                  width: 17,
                ),
                Image.asset(
                  "assets/logos/perf_QSE.png",
                  height: 50,
                ),
                const SizedBox(
                  width: 20,
                ),
                Text("Accueil ${widget.title}",
                    style: TextStyle(color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 23,
                    )
                )
              ],
            ),
            Row(
              children: [
                Container(
                  padding: EdgeInsets.only(
                      right: 6, left: 6, top: 1, bottom: 1),
                  height: 40,
                  decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(60)
                  ),
                  child: Center(
                    child: Row(
                      children: [
                        Center(
                          child: CustomText(
                            text: "${widget.mainData["prenom"]} ${widget.mainData["nom"]}",
                            color: Colors.black,
                            weight: FontWeight.bold,
                            size: 18,
                          ),
                        ),
                        const SizedBox(width: 7,),
                        QudsPopupButton(
                          items: getMenuItems(shortName: "${widget.mainData["prenom"]![0]}${widget.mainData["nom"]![0]}",name: "${widget.mainData["prenom"]} ${widget.mainData["nom"]}",email:widget.mainData["email"]),
                          child: CircleAvatar(
                            backgroundColor: Colors.red,
                            child: Center(
                              child: CustomText(
                                text:"${widget.mainData["prenom"]![0]}${widget.mainData["nom"]![0]}",
                                color: Colors.black,
                                weight: FontWeight.bold,
                                size: 20,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                const SizedBox(width: 30,),
                TextButton(
                  child: const Text(
                    "A propos de Perf QSE",
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontStyle: FontStyle.italic,
                      fontSize: 15,
                    ),
                  ),
                  onPressed: () async {
                    const url = "https://huboutils.visionstrategie.com";
                    final uri = Uri.parse(url);
                    if (await canLaunchUrl(uri)) {
                      await launchUrl(uri);
                    }
                    else {
                      throw "Could not launch $url";
                    }
                  },
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
  List<QudsPopupMenuBase> getMenuItems({required String shortName,required String name,required String email,}) {
    return [
      QudsPopupMenuItem(
          leading: CircleAvatar(
            backgroundColor: Colors.red,
            child: Center(
              child: CustomText(
                text: shortName,
                color: Colors.black,
                weight: FontWeight.bold,
              ),
            ),
          ),
          title:  Text(name,
            style: TextStyle(fontSize: 13, fontWeight: FontWeight.bold),
          ),
          subTitle: Text('${email}'),
          onPressed: () {}),
      QudsPopupMenuDivider(),
      QudsPopupMenuItem(
          leading: const Icon(Icons.person,color: Colors.blue,size: 30,),
          title: const Text(
            'Mon Profil',
            style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
          ),
          subTitle: const Text('Informations du compte et plus'),
          onPressed: () {
          }),
      QudsPopupMenuWidget(
          builder: (c) => Container(
              padding: const EdgeInsets.all(10),
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
                                onPressed: () async{
                                  await storage.write(key: 'logged', value: "");
                                  await storage.write(key: 'userEmail', value: "");
                                  context.go('/account/login');
                                },
                                child: Text('Oui'),
                              ),
                            ],
                          );
                        },);
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.red,
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
