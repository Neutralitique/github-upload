import 'dart:js';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:perfqse/Views/pilotage/controllers/tableau_controller.dart';
import 'package:perfqse/models/common/user_model.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import '../Views/pilotage/entity/tableau_bord/widgets/utils_TB.dart';
import '../helpers/helper_methods.dart';
import '../models/pilotage/axeModel.dart';
import '../models/pilotage/critereModel.dart';
import '../models/pilotage/enjeuModel.dart';
import '../models/pilotage/indicateur_model.dart';

class ApiTableau_Bord {

  static const String baseUrl = "http://127.0.0.1:5000";

  Future<void> getIndicateur({required reference,required annee,required entity}) async {
    final response = await http.post(
      Uri.parse(baseUrl + "/indicateur/getlist"),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(<String, dynamic>{
        'reference': reference,
        'annee':annee,
        "entity":entity
      }),
    );
    if (response.statusCode == 200) {
      DataIndicateur=[];
      var indicator =jsonDecode(response.body);
      //print(indicator);
      for(int i=0;i<indicator.length;i++){
        final indelem=IndicateurModel.fromJson(indicator[i]);
        DataIndicateur.add(indelem);
      }
      print( DataIndicateur);
    } else if (response.statusCode == 400) {
      DataIndicateur=[];
      final jsonData = jsonDecode(response.body);
      String message=jsonData["message"];
      throw Exception(jsonData["message"]);
    }
    else {
      throw Exception('La connexion a échoué.');
    }
  }

Future<void> getCritere() async {
  final response = await http.get(
    Uri.parse(baseUrl + "/critere/getlist"),
    headers: <String, String>{
      'Content-Type': 'application/json; charset=UTF-8',
    },
  );

  if (response.statusCode == 200) {
    DataCritere=[];
    var critere =jsonDecode(response.body);
    for(int i=0;i<critere.length;i++){
      final crielem=CritereModel.fromJson(critere[i]);
      DataCritere.add(crielem);
    }
    print(DataCritere);
  } else if (response.statusCode == 400) {
    final jsonData = jsonDecode(response.body);
    String message=jsonData["message"];
    throw Exception(message);
  }
  else {
  throw Exception("Echec de la connection");
  }
}

Future<void> getAxe() async {
  final response = await http.get(
    Uri.parse(baseUrl + "/axe/getlist"),
    headers: <String, String>{
      'Content-Type': 'application/json; charset=UTF-8',
    },
  );

  if (response.statusCode == 200) {
    DataAxe=[];
    var axe =jsonDecode(response.body);
    for(int i=0;i<axe.length;i++){
      final axe_elem=AxeModel.fromJson(axe[i]);
      DataAxe.add(axe_elem);
    }
    print(DataAxe);
  } else if (response.statusCode == 400) {
    final jsonData = jsonDecode(response.body);
    String message=jsonData["message"];
  throw Exception(message);
  }
  else {
throw Exception("Echec de la connection");
  }
}

Future<void> getEnjeu() async {
  final response = await http.get(
    Uri.parse(baseUrl + "/enjeu/getlist"),
    headers: <String, String>{
      'Content-Type': 'application/json; charset=UTF-8',
    },
  );

  if (response.statusCode == 200) {
    DataEnjeu=[];
    var enjeu =jsonDecode(response.body);
    for(int i=0;i<enjeu.length;i++){
      final enjeu_elem=EnjeuModel.fromJson(enjeu[i]);
      DataEnjeu.add(enjeu_elem);
    }
    print( DataEnjeu);
  } else if (response.statusCode == 400) {
    final jsonData = jsonDecode(response.body);
    String message=jsonData["message"];
throw Exception(message);
  }
  else {
throw Exception("Echec de la connection");
  }
}

Future<void> updateIndicateur({required reference,
  required annee,
  required containIndic
}) async {
  final response = await http.post(
    Uri.parse(baseUrl + "/indicateur/updatelist"),
    headers: <String, String>{
      'Content-Type': 'application/json; charset=UTF-8',
    },
    body: jsonEncode(<String, dynamic>{
      'reference': reference,
      'annee':annee,
      'container':containIndic
    }),
  );
  if (response.statusCode == 200) {
    final jsonData = jsonDecode(response.body);
    String message=jsonData["message"];
  } else if (response.statusCode == 400) {
    final jsonData = jsonDecode(response.body);
    String message=jsonData["message"];
    throw Exception(jsonData["message"]);
  }
  else {
    throw Exception('La connexion a échoué.');
  }
}

Future<void> export(
{required containInd}
    ) async {
  final response = await http.post(
    Uri.parse(baseUrl + "/export/list"),
    headers: <String, String>{
      'Content-Type': 'application/json; charset=UTF-8',
    },body: jsonEncode(<String, dynamic>{
      'containInd': containInd,
      }),
  );

  if (response.statusCode == 200) {

  } else if (response.statusCode == 400) {
    final jsonData = jsonDecode(response.body);
    String message=jsonData["message"];
    throw Exception(message);
  }
  else {
    throw Exception("La Connection a echoué");
  }
}

}