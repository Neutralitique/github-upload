import 'dart:convert';

class AccesPilotageModel {
  String? email;
  String? entite;
  bool? estSpectateur;
  bool? estCollecteur;
  bool? estValidateur;
  bool? estAdmin;
  bool? estBloque;
  int? niveauAdmin;
  List<dynamic>? restrictions;

  AccesPilotageModel({
    this.email,
    this.entite,
    this.estSpectateur,
    this.estCollecteur,
    this.estValidateur,
    this.estAdmin,
    this.estBloque,
    this.niveauAdmin,
    this.restrictions,
  });

  factory AccesPilotageModel.fromRawJson(String str) => AccesPilotageModel.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory AccesPilotageModel.fromJson(Map<dynamic, dynamic> json) => AccesPilotageModel(
    email: json["email"],
    entite: json["entite"],
    estSpectateur: json["est_spectateur"],
    estCollecteur: json["est_collecteur"],
    estValidateur: json["est_validateur"],
    estAdmin: json["est_admin"],
    estBloque: json["est_bloque"],
    niveauAdmin: json["niveau_admin"],
    restrictions: List<dynamic>.from(json["restrictions"].map((x) => x)
    ),
  );

  Map<String, dynamic> toJson() => {
    "email": email,
    "entite": entite,
    "est_spectateur": estSpectateur,
    "est_collecteur": estCollecteur,
    "est_validateur": estValidateur,
    "est_admin": estAdmin,
    "est_bloque": estBloque,
    "niveau_admin": niveauAdmin,
    "restrictions": restrictions,
  };
}