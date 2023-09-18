import 'dart:convert';

class IndicateurModel {
  int idIndicateur;
  var axe;
  var enjeu; 
  var critereNormatif;
  var intitule;
  var annee;
  List<String> processus;
  var unite;
  var type;
  var definition;
  var valRef;
  var cible;
  var ecart;
  Aout realisee;
  Aout janvier;
  Aout fevrier;
  Aout mars;
  Aout avril;
  Aout mai;
  Aout juin;
  Aout juillet;
  Aout aout;
  Aout septembre;
  Aout octobre;
  Aout novembre;
  Aout decembre;

  IndicateurModel({
    required this.idIndicateur,
    required this.axe,
    required this.annee,
    required this.enjeu,
    required this.critereNormatif,
    required this.intitule,
    required this.processus,
    required this.unite,
    required this.type,
    required this.definition,
    required this.valRef,
    required this.cible,
    required this.ecart,
    required this.realisee,
    required this.janvier,
    required this.fevrier,
    required this.mars,
    required this.avril,
    required this.mai,
    required this.juin,
    required this.juillet,
    required this.aout,
    required this.septembre,
    required this.octobre,
    required this.novembre,
    required this.decembre,
  });

  factory IndicateurModel.fromRawJson(String str) => IndicateurModel.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory IndicateurModel.fromJson(Map<String, dynamic> json) => IndicateurModel(
    idIndicateur: json["numero"],
    axe: json["id_axe"],
    annee: json["annee"],
    enjeu: json["enjeu"],
    critereNormatif: json["critereNormatif"],
    intitule: json["intitule"],
    processus: List<String>.from(json["processus"].map((x) => x)),
    unite: json["unite"],
    type: json["type"],
    definition: json["definition"],
    valRef: json["valRef"],
    cible: json["cible"],
    ecart: json["ecart"],
    realisee: Aout.fromJson(json["realisee"]),
    janvier: Aout.fromJson(json["janvier"]),
    fevrier: Aout.fromJson(json["fevrier"]),
    mars: Aout.fromJson(json["mars"]),
    avril: Aout.fromJson(json["avril"]),
    mai: Aout.fromJson(json["mai"]),
    juin: Aout.fromJson(json["juin"]),
    juillet: Aout.fromJson(json["juillet"]),
    aout: Aout.fromJson(json["aout"]),
    septembre: Aout.fromJson(json["septembre"]),
    octobre: Aout.fromJson(json["octobre"]),
    novembre: Aout.fromJson(json["novembre"]),
    decembre: Aout.fromJson(json["decembre"]),
  );

  Map<String, dynamic> toJson() => {
    "numero": idIndicateur,
    "id_axe": axe,
    "id_axe": annee,
    "enjeu": enjeu,
    "critereNormatif": critereNormatif,
    "intitule": intitule,
    "processus": List<dynamic>.from(processus.map((x) => x)),
    "unite": unite,
    "type": type,
    "definition": definition,
    "valRef": valRef,
    "cible": cible,
    "ecart": ecart,
    "realisee": realisee.toJson(),
    "janvier": janvier.toJson(),
    "fevrier": fevrier.toJson(),
    "mars": mars.toJson(),
    "avril": avril.toJson(),
    "mai": mai.toJson(),
    "juin": juin.toJson(),
    "juillet": juillet.toJson(),
    "aout": aout.toJson(),
    "septembre": septembre.toJson(),
    "octobre": octobre.toJson(),
    "novembre": novembre.toJson(),
    "decembre": decembre.toJson(),
  };
}

class Aout {
  int? value;
  int? isValidate;

  Aout({
    required this.value,
    required this.isValidate,
  });

  factory Aout.fromRawJson(String str) => Aout.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory Aout.fromJson(Map<String, dynamic> json) => Aout(
    value: json["value"],
    isValidate: json["isValidate"],
  );

  Map<String, dynamic> toJson() => {
    "value": value,
    "isValidate": isValidate,
  };
}
