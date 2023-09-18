import 'package:get/get.dart';

class ResetPassWordController extends GetxController {
  var email = "".obs;
  var resetCode = "".obs;
  var resetStep = 1.obs;


  void initValue() {
    resetStep.value = 1;
    email.value = "";
    resetCode.value = "";
  }

  @override
  void onInit() {
    initValue();
    super.onInit();
  }
}