import 'package:get/get.dart';

import '../../../../../models/common/user_model.dart';
import '../../../../../models/pilotage/acces_pilotage_model.dart';

class ProfilPilotageController extends GetxController{
  var userModel=UserModel(email:"").obs;
  var accesPilotageModel=AccesPilotageModel(email:"").obs;
}