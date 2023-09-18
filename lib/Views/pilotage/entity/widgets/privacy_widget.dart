import 'package:flutter/material.dart';
import '../../../../utils/utils.dart';
class PrivacyWidget extends StatefulWidget {
  const PrivacyWidget({super.key});

  @override
  State<PrivacyWidget> createState() => _PrivacyWidgetState();
}

class _PrivacyWidgetState extends State<PrivacyWidget> {
  @override
  Widget build(BuildContext context) {
    int width = MediaQuery.of(context).size.width.round();
    String responsive = responsiveRule(width);
    return responsive == "cas-0"? Container() : Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        SizedBox(width: 130,),
        Text("© 2023 Vision & Stratégie Groupe",style: TextStyle(fontSize: responsive =="cas-1"? 12 : null),),
        SizedBox(width: 15,),
        TextButton(onPressed: () {  },
        child: Text("Confidentialité",style: TextStyle(color: Color(0xFF114693),fontSize: responsive =="cas-1"? 12 : null),)),
        SizedBox(width: 15,),
        TextButton(onPressed: () {  },child: Text("Conditions d'utilisation",style: TextStyle(color: Color(0xFF114693),fontSize: responsive =="cas-1"? 12 : null),))
      ],
    );
  }
}
