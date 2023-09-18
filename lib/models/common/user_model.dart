import 'dart:convert';

class UserModel {
  String email;
  dynamic nom;
  String? titre;
  String? prenom;
  String? accesPilotage;
  String? accesEvaluation;
  String? fonction;
  String? entreprise;
  String? langue;
  String? addresse;
  String? ville;
  String? pays;
  String? numero;
  String? photoProfil;
  String? tokenCode;
  DateTime? expirationTime;

  UserModel({
    required this.email,
    this.nom,
    this.prenom,
    this.accesPilotage,
    this.accesEvaluation,
    this.fonction,
    this.titre,
    this.entreprise,
    this.langue,
    this.addresse,
    this.ville,
    this.pays,
    this.numero,
    this.photoProfil,
    this.tokenCode,
    this.expirationTime,
  });

  factory UserModel.init() => UserModel(email: "");

  factory UserModel.fromRawJson(String str) => UserModel.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory UserModel.fromJson(Map<dynamic, dynamic> json) => UserModel(
    email: json["email"],
    nom: json["nom"],
    titre: json["titre"],
    prenom: json["prenom"],
    accesPilotage: json["acces_pilotage"],
    accesEvaluation: json["acces_evaluation"],
    fonction: json["fonction"],
    entreprise: json["entreprise"],
    langue: json["langue"],
    addresse: json["addresse"],
    ville: json["ville"],
    pays: json["pays"],
    numero: json["numero"],
    photoProfil: json["photo_profil"],
    tokenCode: json["token_code"],
    expirationTime: json["expiration_time"],
  );

  Map<dynamic, dynamic> toJson() => {
    "email": email,
    "nom": nom,
    "titre":titre,
    "prenom": prenom,
    "acces_pilotage": accesPilotage,
    "acces_evaluation": accesEvaluation,
    "fonction": fonction,
    "entreprise": entreprise,
    "langue": langue,
    "addresse": addresse,
    "ville": ville,
    "pays": pays,
    "numero": numero,
    "photo_profil": photoProfil,
    "token_code": tokenCode,
    "expiration_time": expirationTime?.toIso8601String(),
  };
}