import 'package:flutter/material.dart';
import 'package:get/get.dart';

class UnimplementedWidget{

  static bool showDialog(){
    Get.defaultDialog(
      title: "Unimplemented Feature",
      titleStyle: TextStyle(fontStyle: FontStyle.italic),
      radius: 10,
      content: Container(
          width: 250,height: 250,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset("assets/images/error.png",width: 300,height: 200,)
            ],
          ),
      ),
    );
    return true;
  }

}