import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../../../../../api/supabase.dart';
import '../../../../../helpers/helper_methods.dart';
import '../../../../../models/common/user_model.dart';
import '../../../../../models/pilotage/acces_pilotage_model.dart';
import '../../../../../module/styled_scrollview.dart';
import '../../../../../widgets/custom_text_form_field.dart';
import '../../../../../widgets/customtext.dart';
import '../../../../../widgets/menu_deroulant.dart';

class InfosPilote extends StatefulWidget {
  final UserModel userModel;
  final AccesPilotageModel accesPilotageModel;
  const InfosPilote(
      {Key? key, required this.userModel, required this.accesPilotageModel})
      : super(key: key);

  @override
  State<InfosPilote> createState() => _InfosPiloteState();
}

class _InfosPiloteState extends State<InfosPilote> {
  late TextEditingController nomTextEditingController;
  late TextEditingController prenomTextEditingController;
  late TextEditingController villeTextEditingController;
  late TextEditingController adresseTextEditingController;
  late TextEditingController numeroTextEditingController;
  late TextEditingController fonctionTextEditingController;
  String? dropDownPays;
  String pays = "";
  var dropDownTitre;
  String? nom = "";
  String? prenom = "";
  String? email = "";
  final DataBaseController dbController = DataBaseController();

  @override
  void initState() {
    nomTextEditingController = TextEditingController();
    prenomTextEditingController = TextEditingController();
    villeTextEditingController = TextEditingController();
    adresseTextEditingController = TextEditingController();
    numeroTextEditingController = TextEditingController();
    fonctionTextEditingController = TextEditingController();
    super.initState();
  }

  updateInfoPilote(context) async {
    final result = await dbController.updateUser(
        email: widget.userModel.email,
        nom: nomTextEditingController.text.trim(),
        prenom: prenomTextEditingController.text.trim(),
        ville: villeTextEditingController.text.trim(),
        adresse: adresseTextEditingController.text.trim(),
        numero: numeroTextEditingController.text.trim(),
        fonction: fonctionTextEditingController.text.trim(),
        pays: dropDownPays!,
        titre: dropDownTitre);
    if (result == true) {
      final location = GoRouter.of(context).location;
      GoRouter.of(context).go("/reload-page", extra: location);
      ScaffoldMessenger.of(context).showSnackBar(showSnackBar(
          "Succès", "Modification éffectuée avec succès", Colors.green));
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
          showSnackBar("Echec", "La Modification a échoué", Colors.red));
    }
  }

  @override
  Widget build(BuildContext context) {
    nom = widget.userModel.nom;
    prenom = widget.userModel.prenom!.trim();
    email = widget.userModel.email;
    final entite = widget.accesPilotageModel.entite;
    final filliale = widget.userModel.entreprise;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SizedBox(
          height: 10,
        ),
        Expanded(
            child: Container(
          child: StyledScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Card(
                  elevation: 4,
                  child: Padding(
                    padding: EdgeInsets.all(8.0),
                    child: ListTile(
                      leading: CircleAvatar(
                        radius: 30,
                        backgroundColor: Color(0xFFFFFF00),
                        child: Center(
                          child: CustomText(
                            text: "${nom![0]} ${prenom![0]}",
                            color: Color(0xFFF1C232),
                            weight: FontWeight.bold,
                          ),
                        ),
                      ),
                      title: Text(
                        '${prenom} ${nom}',
                        style: TextStyle(
                            fontSize: 15, fontWeight: FontWeight.bold),
                      ),
                      subtitle: Text('${email}'),
                    ),
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                MediaQuery.of(context).size.width > 1000 ?
                Row(children: [
                          Expanded(
                              flex: 1,
                              child: Container(
                                height: 350,
                                child: piloteInfoPilote(),
                              )),
                          Expanded(
                              flex: 3,
                              child: Container(
                                  height: 350,
                                  child: contactPilote(
                                      entite: entite, filliale: filliale))),
                      ],
                      ) :
                Column(children: [
                        const CustomText(
                          text: "Pilote",
                          size: 20,
                          weight: FontWeight.bold,
                        ),
                        Card(
                          child: Padding(
                            padding: const EdgeInsets.all(20.0),
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Expanded(
                                    child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    CustomText(
                                      text: "Prénom",
                                      size: 15,
                                    ),
                                    SizedBox(
                                      height: 5,
                                    ),
                                    CustomTextFormField(
                                      controller: prenomTextEditingController,
                                    ),
                                    SizedBox(
                                      height: 10,
                                    ),
                                    CustomText(
                                      text: "Titre",
                                      size: 15,
                                    ),
                                    SizedBox(
                                      height: 5,
                                    ),
                                    MenuDeroulant(
                                      indication: "",
                                      initValue: dropDownTitre,
                                      height: 50,
                                      items: ["M.", "Mme", "Mlle.", "Miss"],
                                      onChanged: (value) {
                                        dropDownTitre = value;
                                      },
                                    ),
                                  ],
                                )),
                                SizedBox(
                                  width: 20,
                                ),
                                Expanded(
                                    child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    CustomText(
                                      text: "Nom",
                                      size: 15,
                                    ),
                                    SizedBox(
                                      height: 5,
                                    ),
                                    CustomTextFormField(
                                      controller: nomTextEditingController,
                                    ),
                                  ],
                                ))
                              ],
                            ),
                          ),
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        const CustomText(
                          text: "Contacts",
                          size: 20,
                          weight: FontWeight.bold,
                        ),
                        Card(
                          child: Padding(
                            padding: const EdgeInsets.all(20.0),
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Expanded(
                                    child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    CustomText(
                                      text: "Numéro de téléphone",
                                      size: 15,
                                    ),
                                    SizedBox(
                                      height: 5,
                                    ),
                                    CustomTextFormField(
                                      controller: numeroTextEditingController,
                                    ),
                                    SizedBox(
                                      height: 10,
                                    ),
                                    CustomText(
                                      text: "Pays",
                                      size: 15,
                                    ),
                                    SizedBox(
                                      height: 5,
                                    ),
                                    MenuDeroulant(
                                      indication: "",
                                      initValue: dropDownPays,
                                      height: 50,
                                      items: [
                                        "${dropDownPays}",
                                        "GHANA",
                                        "FRANCE",
                                        "LIBERAI"
                                      ],
                                      onChanged: (value) {
                                        dropDownPays = value;
                                      },
                                    ),
                                    SizedBox(
                                      height: 10,
                                    ),
                                    CustomText(
                                      text: "Ville",
                                      size: 15,
                                    ),
                                    SizedBox(
                                      height: 5,
                                    ),
                                    CustomTextFormField(
                                      controller: villeTextEditingController,
                                    ),
                                    SizedBox(
                                      height: 10,
                                    ),
                                    CustomText(
                                      text: "Adresse",
                                      size: 15,
                                    ),
                                    SizedBox(
                                      height: 5,
                                    ),
                                    CustomTextFormField(
                                      controller: adresseTextEditingController,
                                    ),
                                  ],
                                )),
                                SizedBox(
                                  width: 20,
                                ),
                                Expanded(
                                    child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    CustomText(
                                      text: "Filiale",
                                      size: 15,
                                    ),
                                    SizedBox(
                                      height: 5,
                                    ),
                                    textNonModifiable("$filliale"),
                                    SizedBox(
                                      height: 10,
                                    ),
                                    CustomText(
                                      text: "Entité",
                                      size: 15,
                                    ),
                                    SizedBox(
                                      height: 5,
                                    ),
                                    textNonModifiable("$entite"),
                                    SizedBox(
                                      height: 10,
                                    ),
                                    CustomText(
                                      text: "Fonction",
                                      size: 15,
                                    ),
                                    SizedBox(
                                      height: 5,
                                    ),
                                    CustomTextFormField(
                                      controller: fonctionTextEditingController,
                                    ),
                                  ],
                                ))
                              ],
                            ),
                          ),
                        ),
                      ])
              ],
            ),
          ),
        )),
        SizedBox(
          height: 20,
        ),
        Container(
          height: 120,
          child: Center(
            child: InkWell(
              onTap: () {
                updateInfoPilote(context);
              },
              child: Container(
                height: 50,
                width: 200,
                decoration: BoxDecoration(
                    color: Colors.amber,
                    border: Border.all(
                      color: Colors.amber,
                    ),
                    borderRadius: BorderRadius.all(Radius.circular(40))),
                child: Center(
                    child: CustomText(
                  text: "Enregistrer",
                  size: 20,
                  weight: FontWeight.bold,
                  color: Colors.white,
                )),
              ),
            ),
          ),
        )
      ],
    );
  }

  Widget piloteInfoPilote() {
    nom = widget.userModel.nom;
    prenom = widget.userModel.prenom!.trim();
    dropDownTitre = widget.userModel.titre;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const CustomText(
          text: "Pilote",
          size: 20,
          weight: FontWeight.bold,
        ),
        Card(
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                    child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const CustomText(
                      text: "Titre",
                      size: 15,
                    ),
                    const SizedBox(
                      height: 5,
                    ),
                    MenuDeroulant(
                      width: 290,
                      indication: "",
                      initValue: dropDownTitre,
                      height: 50,
                      items: const ["M.", "Mme", "Mlle.", "Miss"],
                      onChanged: (value) {
                        dropDownTitre = value;
                      },
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    const CustomText(
                      text: "Nom",
                      size: 15,
                    ),
                    const SizedBox(
                      height: 5,
                    ),
                    CustomTextFormField(
                      controller: nomTextEditingController,
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    const CustomText(
                      text: "Prénom",
                      size: 15,
                    ),
                    const SizedBox(
                      height: 5,
                    ),
                    CustomTextFormField(
                      controller: prenomTextEditingController,
                    ),
                  ],
                ))
              ],
            ),
          ),
        ),
      ],
    );
  }

  Widget contactPilote({required entite, required filliale}) {
    dropDownPays = widget.userModel.pays;
    pays = widget.userModel.pays!;

    nomTextEditingController.text = widget.userModel.nom!;
    prenomTextEditingController.text = widget.userModel.prenom!;
    villeTextEditingController.text = widget.userModel.ville!;
    adresseTextEditingController.text = widget.userModel.addresse!;
    numeroTextEditingController.text = widget.userModel.numero!;
    fonctionTextEditingController.text = widget.userModel.fonction!;
    return Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
      const CustomText(
        text: "Contacts",
        size: 20,
        weight: FontWeight.bold,
      ),
      Card(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                  child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  CustomText(
                    text: "Numéro de téléphone",
                    size: 15,
                  ),
                  SizedBox(
                    height: 5,
                  ),
                  CustomTextFormField(
                    controller: numeroTextEditingController,
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  CustomText(
                    text: "Pays",
                    size: 15,
                  ),
                  SizedBox(
                    height: 5,
                  ),
                  MenuDeroulant(
                    indication: "",
                    initValue: dropDownPays,
                    height: 50,
                    items: ["COTE D'IVOIRE", "GHANA", "FRANCE", "LIBERIA"],
                    onChanged: (value) {
                      dropDownPays = value;
                    },
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  CustomText(
                    text: "Ville",
                    size: 15,
                  ),
                  SizedBox(
                    height: 5,
                  ),
                  CustomTextFormField(
                    controller: villeTextEditingController,
                  ),
                ],
              )),
              SizedBox(
                width: 10,
              ),
              Expanded(
                  child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const CustomText(
                    text: "Filiale",
                    size: 15,
                  ),
                  const SizedBox(
                    height: 5,
                  ),
                  textNonModifiable("$filliale"),
                  const SizedBox(
                    height: 10,
                  ),
                  const CustomText(
                    text: "Entité",
                    size: 15,
                  ),
                  const SizedBox(
                    height: 5,
                  ),
                  textNonModifiable("$entite"),
                  const SizedBox(
                    height: 10,
                  ),
                  const CustomText(
                    text: "Fonction",
                    size: 15,
                  ),
                  const SizedBox(
                    height: 5,
                  ),
                  CustomTextFormField(
                    controller: fonctionTextEditingController,
                  ),
                ],
              )),
              SizedBox(
                width: 10,
              ),
              Expanded(
                  child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  CustomText(
                    text: "Adresse",
                    size: 15,
                  ),
                  SizedBox(
                    height: 5,
                  ),
                  CustomTextFormField(
                    controller: adresseTextEditingController,
                  ),
                ],
              ))
            ],
          ),
        ),
      ),
    ]);
  }

  Widget textNonModifiable(String text) {
    return Container(
        height: 50,
        alignment: Alignment.centerLeft,
        width: double.maxFinite,
        decoration: const BoxDecoration(
            color: Color(0xFFF2F4F5),
            borderRadius: BorderRadius.all(Radius.circular(10))),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: SelectableText(
            text,
            style: const TextStyle(
                color: Colors.blue, fontWeight: FontWeight.bold, fontSize: 15),
          ),
        ));
  }
}
