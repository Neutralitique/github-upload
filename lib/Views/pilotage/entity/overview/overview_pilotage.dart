import 'package:flutter/material.dart';
import '../../../../constants/colors.dart';
import 'widgets/suivi_details/collecte_globale_filiale.dart';
import 'widgets/suivi_details/section_suivi.dart';
import 'widgets/contributeur/liste_contributeur.dart';
import 'widgets/suivi_details/suivi_details.dart';

class OverviewPilotage extends StatelessWidget {
  const OverviewPilotage({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
         SectionSuivi(),
        const SizedBox(height: defaultPadding),
             Row(
             children: [
            ListeContributeur(),
             const SizedBox(width: defaultPadding),
             Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              CollecteGlobale()
            ],),],),
        const SizedBox(width: defaultPadding),
      ],
    );
  }
}
