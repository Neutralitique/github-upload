import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:perfqse/widgets/customtext.dart';

class Specialcopyright extends StatelessWidget {
  const Specialcopyright({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
        children: [
       const Text(
              "@ 2023 vision & strategie groupe",
              style:TextStyle(color: Colors.black),
            ),
        SizedBox(
          width: 10,
        ),
        TextButton(
            onPressed: () {
              context.go('');
            },
            child: const CustomText(
              text: "Confidentialité",
              color: Colors.blue,
            )),
        SizedBox(
          width: 10,
        ),
        TextButton(
            onPressed: () {
              context.go('');
            },
            child: const CustomText(
              text: "Conditions d'utilisation",
              color: Colors.blue,
            )),
    ]);
  }
}
