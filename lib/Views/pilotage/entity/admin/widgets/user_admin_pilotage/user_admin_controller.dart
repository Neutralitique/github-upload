
import 'package:get/get.dart';

import '../../../../../../api/supabase.dart';
import '../../../../../../models/common/user_model.dart';
import '../../../../../../models/pilotage/acces_pilotage_model.dart';

class UserAdminController extends GetxController{

  final  DataBaseController dbController=DataBaseController();
  List<UserModel> users=<UserModel>[].obs;
  List<AccesPilotageModel> accesPilotage=<AccesPilotageModel>[].obs;

  initialisation()async{
    users = await dbController.getAllUser();
    accesPilotage = await dbController.getAllUsersAccesPilotage();
  }
  addUser({required email,required password,required data })async{
      await dbController.AddUser(email: email,password: password,data: data);
      initialisation();
  }


  @override
  void onInit() {
     initialisation();
    super.onInit();
  }
}