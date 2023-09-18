import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:get/get.dart';
import 'package:go_router/go_router.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import '../../../../helpers/helper_methods.dart';
import '../../../../models/common/user_model.dart';
import '../../../../models/pilotage/acces_pilotage_model.dart';
import '../../../../utils/pilotage_utils.dart';
import 'controller/profil_pilotage_controller.dart';
import 'profil_pilotage.dart';


class ScreenPilotageProfil extends StatefulWidget {
  /// Constructs a [ScreenPilotageProfil] widget.
  const ScreenPilotageProfil({super.key});

  @override
  State<ScreenPilotageProfil> createState() => _ScreenPilotageProfilState();
}

class _ScreenPilotageProfilState extends State<ScreenPilotageProfil> {

  final storage = FlutterSecureStorage();
  final ProfilPilotageController userController= Get.put(ProfilPilotageController());
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
  void initState(){
    pilotageEntiteData = chekUserAccesPilotage();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<Map?>(
      future: pilotageEntiteData,
      builder: (context,snapshot){
        if (!snapshot.hasData) {
          return Center(
            child: loadingPageWidget(),//const SpinKitRipple(color: Colors.blue,),
          );
        }
        final data = snapshot.data!;
        userController.userModel.value=UserModel.fromJson(data["user"]);
        userController.accesPilotageModel.value=AccesPilotageModel.fromJson(data["accesPilotage"]);
        return Scaffold(
          body: Padding(
            padding: EdgeInsets.only(top: 16,left: 10),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text("Profil",style: TextStyle(fontSize: 24,color: Color(0xFF3C3D3F),fontWeight: FontWeight.bold),),
                SizedBox(height: 5,),
                Expanded(
                  child: Column(
                    children: [
                      Expanded(child: Container(
                          child: Obx((){return ProfilPilotage(userModel: userController.userModel.value, accesPilotageModel: userController.accesPilotageModel.value);})
                      ),
                      )
                    ],
                  ),
                )
              ],
            ),
          ),
        );
      },
    );
  }

}