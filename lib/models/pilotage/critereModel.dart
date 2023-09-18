import 'dart:convert';

class CritereModel {
  String idEnjeu;
  String idCritere;
  String libelle;

  CritereModel({
    required this.idEnjeu,
    required this.idCritere,
    required this.libelle,
  });

  factory CritereModel.fromRawJson(String str) => CritereModel.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory CritereModel.fromJson(Map<String, dynamic> json) => CritereModel(
    idEnjeu: json["id_enjeu"],
    idCritere: json["id_critere"],
    libelle: json["libelle"],
  );

  Map<String, dynamic> toJson() => {
    "id_enjeu": idEnjeu,
    "id_critere": idCritere,
    "libelle": libelle,
  };
}
