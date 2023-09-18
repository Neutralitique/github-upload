import 'package:flutter/material.dart';

Future<void> _showMyDialog({@required context}) async {
  return showDialog<void>(
    context: context,
    barrierDismissible: true, // user must tap button!
    builder: (BuildContext context) {
      return AlertDialog(
        title: Text('Accès refusé'),
        content: SingleChildScrollView(
          child: ListBody(
            children: <Widget>[
              Text("Vous n'avez pas l'accès à cet espace."),
              SizedBox(height: 20,),
              Image.asset("assets/images/forbidden.png",width: 50,height: 50,)
            ],
          ),
        ),
      );
    },
  );
}