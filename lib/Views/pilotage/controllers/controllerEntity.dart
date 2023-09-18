import 'package:flutter/material.dart';
import "package:get/get.dart";

class ControllerEntity extends GetxController{
  //-----------Header Element--------------
var headerNom="".obs;
var headerLogo="".obs;
var selectedEntity="".obs;

void InitValue(){
   headerNom.value="Trechville";
   headerLogo.value="SOLIBRA";
   selectedEntity.value="";
}
@override
  void onInit() {
    InitValue();
    super.onInit();
  }
}
