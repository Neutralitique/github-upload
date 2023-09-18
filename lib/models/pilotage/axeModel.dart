import 'dart:convert';

class AxeModel {
  String idAxe;
  String libelle;

  AxeModel({
    required this.idAxe,
    required this.libelle,
  });

  factory AxeModel.fromRawJson(String str) => AxeModel.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory AxeModel.fromJson(Map<String, dynamic> json) => AxeModel(
    idAxe: json["id_axe"],
    libelle: json["libelle"],
  );

  Map<String, dynamic> toJson() => {
    "id_axe": idAxe,
    "libelle": libelle,
  };
}
