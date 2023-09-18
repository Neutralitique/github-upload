import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:get/get.dart';
import 'package:flutter/material.dart';

void showLoading(String message) {
  Get.defaultDialog(
      title: message,
      content: const SpinKitRipple(color: Colors.blue,),
      barrierDismissible: false);
}


Widget loadingPageWidget() {
  return const Stack(
    alignment: AlignmentDirectional.center,
    children: [
      SizedBox(
          height: 50,
          width: 50,
          child: CircularProgressIndicator(
            color: Colors.grey,
            strokeWidth: 4,
          )),
      SizedBox(
          height: 30,
          width: 30,
          child:
          CircularProgressIndicator(color: Colors.amber, strokeWidth: 4)),
    ],
  );
}

void showAlert(String message,Icon icon) {
  Get.defaultDialog(
      title: "Alerte",
      titleStyle: TextStyle(fontSize: 20,color: Colors.red,fontWeight: FontWeight.bold),
      content: Container(
        width: 200,
        height: 100,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Center(child: Text(message,overflow:TextOverflow.ellipsis,maxLines: 2,textAlign: TextAlign.center,)),
            const SizedBox(height: 10,),
            Center(
              child: icon,
            ),
          ],
        ),
      )
  );
}

void dismissLoadingWidget() {
  Get.back();
}

showSnackBar(String title, String message, Color backgroundColor) {
  return SnackBar(
    backgroundColor: backgroundColor,
    behavior: SnackBarBehavior.floating,
    content: Text(title),
    action: SnackBarAction(
      label: message,
      textColor: Colors.white,
      onPressed: () {
      },
    ),
  );
}

