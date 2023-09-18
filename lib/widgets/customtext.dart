import 'package:flutter/material.dart';

class CustomText extends StatelessWidget {
  final String text;
  final double? size;
  final Color? color;
  final FontWeight? weight;
  final bool? isTooltip;

  const CustomText(
      {Key? key,
        required this.text,
        this.size,
        this.color,
        this.weight,
        this.isTooltip})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    if (isTooltip == true) {
      return Tooltip(
        message: text,
        preferBelow: false,
        child: Text(
          text,
          style: TextStyle(
              fontSize: size ?? 16,
              color: color ?? Colors.black,
              fontWeight: weight ?? FontWeight.normal),
        ),
      );
    } else {
      return Text(
        text,
        style: TextStyle(
            fontSize: size ?? 16,
            color: color ?? Colors.black,
            fontWeight: weight ?? FontWeight.normal),
      );
    }
  }
}
