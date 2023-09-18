import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';

import '../../../../../../constants/colors.dart';
import '../../../../../../widgets/customtext.dart';
import '../../../../../../widgets/menu_deroulant.dart';
import '../../../../../../widgets/unimpleted_widget.dart';

class EnteteSuivi extends StatefulWidget {
  const EnteteSuivi({Key? key}) : super(key: key);

  @override
  State<EnteteSuivi> createState() => _EnteteSuiviState();
}

class _EnteteSuiviState extends State<EnteteSuivi> {
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        const CustomText(text: "Filtre",size: 20,),
        const SizedBox(width: 5,),
        Container(height: 30,width: 1,color: Colors.grey,),
        const SizedBox(width: 5,),
        const CustomText(text: "Entité",size: 20,),
        const SizedBox(width: 5,),
        MenuDeroulant(
          indication: "",
          items: ["Sucrivoire Siège","Sucrivoire Zuénoula","Sucrivoire Borotou-Koro"],
          width: 200,
          initValue: "Sucrivoire Siège",
          onChanged: (value){
          },
        ),
        const SizedBox(width: 20,),
        const CustomText(text: "Année",size: 20,),
        const SizedBox(width: 5,),
        MenuDeroulant(
          indication: "",
          initValue: "2023",
          items: ["2022","2023"],
          width: 100,
          onChanged: (value){
          },
        ),
        Expanded(child: Container()),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: IconButton(
              onPressed: () async {},
              splashRadius: 20,
              padding: EdgeInsets.zero,
              icon: const Icon(Iconsax.refresh,color: Color(0xFF4F80B5),)),
        ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: TextButton.icon(
              style: ButtonStyle(
                  backgroundColor: MaterialStateProperty.all(Colors.blue)),
              onPressed: () {
                UnimplementedWidget.showDialog();
              },
              icon: const Icon(Iconsax.printer,color: Colors.white,),
              label: const CustomText(
                text: "Imprimer",
                color: light,
                size: 15,
              )),
        ),
      ],
    );
  }
}
