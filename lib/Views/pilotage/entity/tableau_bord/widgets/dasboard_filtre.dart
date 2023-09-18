import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';

import '../../../../../widgets/customtext.dart';
import 'collecte_status.dart';

class DashBoardFiltre extends StatefulWidget {
  const DashBoardFiltre({Key? key}) : super(key: key);

  @override
  State<DashBoardFiltre> createState() => _DashBoardFiltreState();
}

class _DashBoardFiltreState extends State<DashBoardFiltre> {
  @override
  Widget build(BuildContext context) {
    return  Row(
      children: [
        const CustomText(
          text: "Filtre",
          size: 20,
        ),
        const SizedBox(
          width: 10,
        ),
        const SizedBox(
          width: 2,
        ),
        const PilierButton(
          pilier: "Tous",
          isSelected: true,
          iconData: Icons.all_inclusive,
          color: Colors.amber,
        ),
        const SizedBox(
          width: 5,
        ),
        Container(
          color: Colors.black,
          width: 1,
          height: 30,
        ),
        const SizedBox(
          width: 5,
        ),
        const PilierButton(
          pilier: "Genéral",
          isSelected: false,
          iconData: Icons.camera_outlined,
          color: Colors.brown,
        ),
        const SizedBox(
          width: 5,
        ),
        const PilierButton(
          pilier: "Gouverance",
          isSelected: false,
          iconData: Icons.manage_accounts,
          color: Color(0xFFEAB019),
        ),
        const SizedBox(
          width: 5,
        ),
        const PilierButton(
          pilier: "Economie",
          isSelected: false,
          iconData: Iconsax.money,
          color: Color(0xFF20ABE2),
        ),
        const SizedBox(
          width: 5,
        ),
        const PilierButton(
          pilier: "Social",
          isSelected: false,
          iconData: Iconsax.people,
          color: Color(0xFFE64F1A),
        ),
        const SizedBox(
          width: 5,
        ),
        const PilierButton(
          pilier: "Environement",
          isSelected: false,
          iconData: Iconsax.tree,
          color: Color(0xFF4AA83F),
        ),
        const SizedBox(
          width: 5,
        ),
        Expanded(child: Container()),
      ],
    );
  }
}

class PilierButton extends StatefulWidget {
  final String pilier;
  final bool isSelected;
  final IconData iconData;
  final Color color;
  const PilierButton(
      {Key? key,
      required this.pilier,
      required this.isSelected,
      required this.iconData,
      required this.color})
      : super(key: key);

  @override
  State<PilierButton> createState() => _PilierButtonState();
}

class _PilierButtonState extends State<PilierButton> {
  @override
  Widget build(BuildContext context) {
    return InkWell(
      child: Container(
          padding: const EdgeInsets.all(2),
          decoration: widget.isSelected
              ? BoxDecoration(
                  color: widget.color,
                  border: Border.all(width: 1.0),
                  borderRadius: const BorderRadius.all(Radius.circular(15.0)),
                )
              : null,
          child: widget.isSelected ? Row(
                  children: [
                    Icon(
                      widget.iconData,
                      color: Colors.white,
                    ),
                    CustomText(
                      text: "${widget.pilier}",
                      color: Colors.white,
                    ),
                    const SizedBox(
                      width: 10,
                    )
                  ],
                )
              : Row(
                  children: [
                    Icon(
                      widget.iconData,
                      color: widget.color,
                    ),
                    CustomText(
                      text: "${widget.pilier}",
                      color: widget.color,
                    ),
                    const SizedBox(
                      width: 10,
                    )
                  ],
                )),
    );
  }
}
