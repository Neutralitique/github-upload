import 'package:flutter/material.dart';

import '../../../../widgets/customtext.dart';


class OverviewCard extends StatelessWidget {
  final String title;
  final Color titleColor;
  final List<Widget>? children;

  const OverviewCard(
      {Key? key,
      required this.title,
      required this.titleColor,
      required this.children})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(2),
      margin: const EdgeInsets.all(5),
      width: 250,
      constraints: const BoxConstraints(minHeight: 180),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(17),
        boxShadow: [
          BoxShadow(
              offset: const Offset(0, 6),
              color:Colors.red.withOpacity(.1),
              blurRadius: 12)
        ],
        border: Border.all(color: Colors.red, width: .5),
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(15),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Expanded(
                    child: Container(
                      color: titleColor, height: 25,
                      child: Padding(
                        padding: const EdgeInsets.only(left: 8), child: CustomText(
                        text: title,
                        color: Colors.white,
                        weight: FontWeight.bold,
                      )),
                ))
              ],
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: children ?? [],
            )
          ],
        ),
      ),
    );
  }
}
