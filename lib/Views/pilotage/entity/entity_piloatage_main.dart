import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:get/get.dart';
import 'package:go_router/go_router.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import '../../../helpers/helper_methods.dart';
import '../../../utils/pilotage_utils.dart';
import '../../../utils/utils.dart';
import '../controllers/side_menu_controller.dart';
import 'widgets/app_bar_pilotage.dart';
import 'widgets/drawer_menu_pilotage.dart';
import 'widgets/menu_nav_pilotage.dart';


class EntityPilotageMain extends StatefulWidget {
  final Widget child;
  const EntityPilotageMain({super.key, required this.child});

  @override
  State<EntityPilotageMain> createState() => _EntityPilotageMainState();
}

class _EntityPilotageMainState extends State<EntityPilotageMain> {

  final SideMenuController sideMenuController = Get.put(SideMenuController());
  final storage = FlutterSecureStorage();
  final supabase = Supabase.instance.client;
  late Future<Map> pilotageEntiteData;

  Future<Map> chekUserAccesPilotage() async{
    var data = {};
    String? email = await storage.read(key: 'email');
    final user = await supabase.from('Users').select().eq('email', email);
    final accesPilotage = await supabase.from('AccesPilotage').select().eq('email', email);
    data["user"] = user[0] ;
    data["accesPilotage"] = accesPilotage[0] ;
    if(chekcAccesPilotage(accesPilotage[0]) ==false) {
      await Future.delayed(Duration(milliseconds: 500));
      context.go("/");
    }
    return data;
  }


  @override
  void initState() {
    pilotageEntiteData = chekUserAccesPilotage();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    int width = MediaQuery.of(context).size.width.round();
    String responsive = responsiveRule(width);

    return FutureBuilder<Map?>(
      future: pilotageEntiteData,
      builder: (context, snapshot) {
        if (!snapshot.hasData) {
          return Scaffold(body: Center(child: loadingPageWidget()));
        }
        final data = snapshot.data!;
        String shortName = "${data["user"]["prenom"][0]}${data["user"]["nom"][0]}";
        return Scaffold(
          appBar: PreferredSize(
            preferredSize: Size.fromHeight(60.0),
            child: AppBarPilotage(shortName: shortName,),
          ),
          body: Scaffold(
            key: sideMenuController.scaffoldKey,
            drawer: const DrawerMenuPilotage(),
            endDrawer: const DrawerMenuPilotage(),
            body: Row(
              children: [MenuNavPilotage(responsive: responsive),Expanded(child: widget.child)],
            ),
          ),
        );
      },
    );
  }
}
