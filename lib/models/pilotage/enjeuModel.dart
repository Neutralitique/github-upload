import 'dart:convert';

class EnjeuModel {
  String idAxe;
  String idEnjeu;
  String libelle;

  EnjeuModel({
    required this.idAxe,
    required this.idEnjeu,
    required this.libelle,
  });

  factory EnjeuModel.fromRawJson(String str) => EnjeuModel.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory EnjeuModel.fromJson(Map<String, dynamic> json) => EnjeuModel(
    idAxe: json["id_axe"],
    idEnjeu: json["id_enjeu"],
    libelle: json["libelle"],
  );

  Map<String, dynamic> toJson() => {
    "id_axe": idAxe,
    "id_enjeu": idEnjeu,
    "libelle": libelle,
  };
}
