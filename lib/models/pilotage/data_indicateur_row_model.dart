import 'dart:convert';

class DataIndicateurRowModel {
  final String id;
  final String entite;
  final int annee;
  final int numeroIndicateur;
  final String referenceIndicateur;
  final DataCellModel realise;
  final DataCellModel janvier;
  final DataCellModel fevrier;
  final DataCellModel mars;
  final DataCellModel avril;
  final DataCellModel mai;
  final DataCellModel juin;
  final DataCellModel juillet;
  final DataCellModel aout;
  final DataCellModel septembre;
  final DataCellModel octobre;
  final DataCellModel novembre;
  final DataCellModel decembre;

  DataIndicateurRowModel({
    required this.id,
    required this.entite,
    required this.annee,
    required this.numeroIndicateur,
    required this.referenceIndicateur,
    required this.realise,
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

  factory DataIndicateurRowModel.fromRawJson(String str) => DataIndicateurRowModel.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory DataIndicateurRowModel.fromJson(Map<String, dynamic> json) => DataIndicateurRowModel(
    id: json["_id"],
    entite: json["entite"],
    annee: json["annee"],
    numeroIndicateur: json["numero_indicateur"],
    referenceIndicateur: json["reference_indicateur"],
    realise: DataCellModel.fromJson(json["realise"]),
    janvier: DataCellModel.fromJson(json["janvier"]),
    fevrier: DataCellModel.fromJson(json["fevrier"]),
    mars: DataCellModel.fromJson(json["mars"]),
    avril: DataCellModel.fromJson(json["avril"]),
    mai: DataCellModel.fromJson(json["mai"]),
    juin: DataCellModel.fromJson(json["juin"]),
    juillet: DataCellModel.fromJson(json["juillet"]),
    aout: DataCellModel.fromJson(json["aout"]),
    septembre: DataCellModel.fromJson(json["septembre"]),
    octobre: DataCellModel.fromJson(json["octobre"]),
    novembre: DataCellModel.fromJson(json["novembre"]),
    decembre: DataCellModel.fromJson(json["decembre"]),
  );

  Map<String, dynamic> toJson() => {
    "_id": id,
    "entite": entite,
    "annee": annee,
    "numero_indicateur": numeroIndicateur,
    "reference_indicateur": referenceIndicateur,
    "realise": realise.toJson(),
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

class DataCellModel {
  num? valeur;
  bool? estValide;

  DataCellModel({
    this.valeur,
    this.estValide,
  });

  factory DataCellModel.fromRawJson(String str) => DataCellModel.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory DataCellModel.fromJson(Map<String, dynamic> json) => DataCellModel(
    valeur: json["valeur"],
    estValide: json["est_valide"],
  );

  Map<String, dynamic> toJson() => {
    "valeur": valeur,
    "est_valide": estValide,
  };
}
