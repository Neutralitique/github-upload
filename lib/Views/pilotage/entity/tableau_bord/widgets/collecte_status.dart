import 'package:flutter/material.dart';

import '../../../../../widgets/customtext.dart';
import '../../../../../widgets/progress_bar.dart';

class CollecteStatus extends StatefulWidget {
  const CollecteStatus({Key? key}) : super(key: key);

  @override
  State<CollecteStatus> createState() => _CollecteStatusState();
}

class _CollecteStatusState extends State<CollecteStatus> {
  @override
  Widget build(BuildContext context) {
    return Row(
      children: const [
        CustomText(
          text: "Il reste 20 jours pour la collecte des données.",
          size: 15,
        ),
        SizedBox(width: 10,),
        ProgressBar(),
        SizedBox(width:3,),
        CustomText(
          text: "Le progrès de collecte est égale à 47,17 % pour ce mois-ci.",
          size: 15,
        ),
      ],
    );
  }
}
