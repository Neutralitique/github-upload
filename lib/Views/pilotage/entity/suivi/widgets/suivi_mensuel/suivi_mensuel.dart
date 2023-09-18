import 'package:flutter/material.dart';

class SuiviMensuel extends StatefulWidget {
  const SuiviMensuel({Key? key}) : super(key: key);

  @override
  State<SuiviMensuel> createState() => _SuiviMensuelState();
}

class _SuiviMensuelState extends State<SuiviMensuel> {
  @override
  Widget build(BuildContext context) {
    return Container(
        padding: const EdgeInsets.all(5),
        width: double.infinity,
        decoration: const BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.all(Radius.circular(10)),
        ),
        child: Image.asset("assets/images/monthly-average-rainfall.png",scale: 1,)
    );
  }
}
