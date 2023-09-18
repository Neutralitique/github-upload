import 'package:get/get.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';
import '../../../models/pilotage/axeModel.dart';
import '../../../models/pilotage/critereModel.dart';
import '../../../models/pilotage/enjeuModel.dart';
import '../../../models/pilotage/indicateur_model.dart';

class ControllerTbQSE extends GetxController{
  var Size=1.obs;
  var centerCicle="".obs;
  var axeSelect="".obs;
  var nameAxeSelect="".obs;
  var enjeuSelect="".obs;
  var dropdownMois="".obs;
  var dropdownAnnee="".obs;
  var dropdownAnnee_last="".obs;

  List <IndicateurModel> listIndicateurs=<IndicateurModel>[].obs;
  List <CritereModel> listCriteres=<CritereModel>[].obs;
  List <EnjeuModel> listEnjeux=<EnjeuModel>[].obs;
  List <AxeModel> listAxes=<AxeModel>[].obs;


  void InitValue(){
    Size.value=400;
    centerCicle.value="";
    axeSelect.value="";
    nameAxeSelect.value="";
    enjeuSelect.value="";
    dropdownMois.value="Juillet";
    dropdownAnnee.value="2023";
    dropdownAnnee_last.value="";
  }
  @override
  void onInit() {
    InitValue();
    super.onInit();
  }
}