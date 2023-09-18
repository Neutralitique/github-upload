import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:go_router/go_router.dart';
import 'package:perfqse/helpers/helper_methods.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import '../../../utils/pilotage_utils.dart';
import '../../../widgets/copyright.dart';
import 'widgets/appbar_pilotage_home.dart';
import 'widgets/content_pilotage_home.dart';
import 'widgets/header_pilotage_home.dart';

class PilotageHome extends StatefulWidget {
  const PilotageHome({Key? key}) : super(key: key);

  @override
  State<PilotageHome> createState() => _PilotageHomeState();
}

class _PilotageHomeState extends State<PilotageHome> {
  final storage = FlutterSecureStorage();
  final supabase = Supabase.instance.client;
  late Future<Map> pilotageHomeData;


  Future<Map> loadDataPilotageHome() async{
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
    super.initState();
    pilotageHomeData = loadDataPilotageHome();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<Map?>(
        future: pilotageHomeData,
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return Scaffold(
              backgroundColor: Colors.white,
              body: Center(
                child: loadingPageWidget(),
              ),
            );
          }
          final data = snapshot.data!;
          return Scaffold(
            body: Container(
              child: Column(
                children: [
                  appBarPilotageHome(
                    title: "Pilotage", mainData: data["user"],),
                  Expanded(child: Container(
                    // height: 800,
                    padding: const EdgeInsets.only(
                        left: 10, right: 10, bottom: 10),
                    decoration: const BoxDecoration(
                        image: DecorationImage(image: AssetImage(
                            "assets/images/background_image.jpg"),
                            fit: BoxFit.fitWidth)),
                    child: Stack(
                      children: [
                        SingleChildScrollView(
                          child: Container(
                            height: 700,
                            child: Column(
                              children: const [
                                const SizedBox(height: 10,),
                                HeaderPilotageHome(),
                                const SizedBox(height: 10,),
                                Expanded(child: ContentPilotageHome())
                              ],
                            ),
                          ),
                        ),
                        Positioned(
                          bottom: -1,
                          child: InkWell(
                            onTap: () {
                              context.go("/");
                            },
                            child: SizedBox(
                              width: 50,
                              height: 50,
                              child: Card(
                                elevation: 10,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(60),
                                ),
                                color: Colors.red,
                                child: Icon(
                                  Icons.home_outlined, color: Colors.white,
                                  size: 30,),
                              ),
                            ),
                          ),
                        )
                      ],
                    ),
                  )),
                  const CopyRight()
                ],
              ),
            ),

          );
        });
  }}
