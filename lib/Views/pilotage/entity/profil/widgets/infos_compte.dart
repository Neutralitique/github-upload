import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import '../../../../../api/supabase.dart';
import '../../../../../helpers/helper_methods.dart';
import '../../../../../models/common/user_model.dart';
import '../../../../../models/pilotage/acces_pilotage_model.dart';
import '../../../../../module/styled_scrollview.dart';
import '../../../../../widgets/customtext.dart';
import '../../../../../widgets/menu_deroulant.dart';
import '../controller/profil_pilotage_controller.dart';

class InfosCompte extends StatefulWidget {
  final UserModel userModel;
  final AccesPilotageModel accesPilotageModel;
  const InfosCompte(
      {Key? key, required this.userModel, required this.accesPilotageModel})
      : super(key: key);

  @override
  State<InfosCompte> createState() => _InfosCompteState();
}

class _InfosCompteState extends State<InfosCompte> {
  final DataBaseController dbController = DataBaseController();
  final ProfilPilotageController userController = Get.find();
  String? dropDownLangue = "fr";

  void updateLanguage(langue) async {
    final result = await dbController.updateUserLanguage(
        email: widget.userModel.email, langue: langue);
    if (result) {
      userController.userModel.value.langue = langue;
      ScaffoldMessenger.of(context).showSnackBar(showSnackBar(
          "Succès", "Modification éffectuée avec succès", Colors.green));
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
          showSnackBar("Echec", "Un problème est survenu", Colors.red));
    }
  }

  @override
  Widget build(BuildContext context) {
    return StyledScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(
            height: 10,
          ),
          Card(
            child: Padding(
              padding: const EdgeInsets.all(20.0),
              child: MediaQuery.of(context).size.width > 900
                  ? Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          CustomText(
                            text: "Email utilisateur",
                            size: 15,
                          ),
                          SizedBox(
                            height: 5,
                          ),
                          textNonModifiable(
                              "${widget.accesPilotageModel.email}"),
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
                            text: "Type d'accès",
                            size: 15,
                          ),
                          SizedBox(
                            height: 5,
                          ),
                          textNonModifiable(
                              getAccesType(widget.accesPilotageModel)),
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
                            text: "Langue",
                            size: 15,
                          ),
                          SizedBox(
                            height: 5,
                          ),
                          MenuDeroulant(
                            indication: "",
                            initValue: widget.userModel.langue == "fr"
                                ? "Française"
                                : widget.userModel.langue == "en"
                                ? "English"
                                : "",
                            width: double.maxFinite,
                            height: 50,
                            items: ["Française", "English"],
                            onChanged: (value) {
                              dropDownLangue = value!;
                            },
                          )
                        ],
                      )),
                ],
              )
                  : Center(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        CustomText(
                          text: "Email utilisateur",
                          size: 15,
                        ),
                        SizedBox(
                          height: 5,
                        ),
                        textNonModifiable(
                            "${widget.accesPilotageModel.email}"),
                      ],
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        CustomText(
                          text: "Type d'accès",
                          size: 15,
                        ),
                        SizedBox(
                          height: 5,
                        ),
                        textNonModifiable(
                            getAccesType(widget.accesPilotageModel)),
                      ],
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        CustomText(
                          text: "Langue",
                          size: 15,
                        ),
                        SizedBox(
                          height: 5,
                        ),
                        MenuDeroulant(
                          indication: "",
                          initValue: widget.userModel.langue == "fr"
                              ? "Française"
                              : dropDownLangue == "en"
                              ? "English"
                              : "",
                          width: double.maxFinite,
                          height: 50,
                          items: ["Française", "English", " "],
                        )
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),
          SizedBox(
            height: 20,
          ),
          Center(
            child: InkWell(
              onTap: () {
                updateLanguage(dropDownLangue ?? "Française");
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
          )
        ],
      ),
    );
  }

  String getAccesType(AccesPilotageModel accesPilotageModel) {
    if (accesPilotageModel.estAdmin ?? false) {
      return "Admin";
    }
    if (accesPilotageModel.estValidateur ?? false) {
      return "Validateur";
    }
    if (accesPilotageModel.estCollecteur ?? false) {
      return "Collecteur";
    }
    if (accesPilotageModel.estSpectateur ?? false) {
      return "Spectateur";
    }
    return "";
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
