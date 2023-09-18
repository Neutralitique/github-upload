import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import '../../../../../api/supabase.dart';
import '../../../../../helpers/helper_methods.dart';
import '../../../../../models/common/user_model.dart';
import '../../../../../models/pilotage/acces_pilotage_model.dart';
import '../../../../../module/styled_scrollview.dart';
import '../../../../../widgets/custom_text_form_field.dart';
import '../../../../../widgets/customtext.dart';

class PasswordPilote extends StatefulWidget {
  final UserModel userModel;
  final AccesPilotageModel accesPilotageModel;
  const PasswordPilote({Key? key, required this.userModel, required this.accesPilotageModel}) : super(key: key);

  @override
  State<PasswordPilote> createState() => _PasswordPiloteState();
}



class _PasswordPiloteState extends State<PasswordPilote> {

  late TextEditingController currentPasswordTextEditingController;
  late TextEditingController newPasswordTextEditingController;
  late TextEditingController checkNewPasswordTextEditingController;
  final DataBaseController dbController = DataBaseController();
  final storage = const FlutterSecureStorage();
  final RegExp regex = RegExp(r'^(?=.*[a-z])(?=.*[A-Z])(?=.*\d).{8,}$');
  final _formKey = GlobalKey<FormState>();
  bool containUpperCase = false;
  bool containLowerCase = false;
  bool containDigit = false;

  void updatePassword(context) async {
    final lastPassword = currentPasswordTextEditingController.text;
    final newPassword = newPasswordTextEditingController.text;
    final checkPassword = checkNewPasswordTextEditingController.text;
    final email = await storage.read(key: "email");
    try {
      await Supabase.instance.client.auth.signInWithPassword(
        email: email,
        password: lastPassword,
      );
      if (newPassword == checkPassword) {
        final result = await dbController.updatePasswordUser(
            email: email!, checkPassWord: checkPassword);
        if (result) {
          currentPasswordTextEditingController.text = "";
          newPasswordTextEditingController.text = "";
          checkNewPasswordTextEditingController.text = "";
          ScaffoldMessenger.of(context).showSnackBar(showSnackBar(
              "Succès", "Modification éffectué avec succès", Colors.green));
        } else {
          ScaffoldMessenger.of(context).showSnackBar(
              showSnackBar("Echec", "un Problème est survenue", Colors.red));
        }
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
            showSnackBar("Echec", "Mots de passe différents", Colors.red));
      }
    } on Exception catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
          showSnackBar("Echec", "Mot de Passe Incorrecte", Colors.red));
    }
  }

  @override
  void initState() {
    currentPasswordTextEditingController = TextEditingController();
    newPasswordTextEditingController = TextEditingController();
    checkNewPasswordTextEditingController = TextEditingController();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return StyledScrollView(
      child: Form(
        key: _formKey,
        autovalidateMode: AutovalidateMode.disabled,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(
              height: 10,
            ),
            SizedBox(
              width: double.infinity,
              child: Card(
                child: Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: MediaQuery.of(context).size.width > 900
                      ? Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Expanded(
                          child: Column(crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const CustomText(
                                text: "Mot de passe actuel",
                                size: 15,
                              ),
                              const SizedBox(
                                height: 5,
                              ),
                              CustomTextFormField(
                                controller: currentPasswordTextEditingController,
                                validator: (value) {
                                  if (!regex.hasMatch(value!)) {
                                    return 'Svp  votre mot de passe doit contenir 8 chiffres,des majuscules et des minuscules';
                                  }
                                  return null;
                                },
                              ),
                            ],
                          )),
                      const SizedBox(
                        width: 10,
                      ),
                      Expanded(
                          child: Column(crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              CustomText(
                                text: "Nouveau mot de passe",
                                size: 15,
                              ),
                              SizedBox(
                                height: 5,
                              ),
                              CustomTextFormField(
                                controller: newPasswordTextEditingController,
                                validator: (value) {
                                  if (!regex.hasMatch(value!)) {
                                    return 'Svp  votre mot de passe doit contenir 8 chiffres,des majuscules et des minuscules';
                                  }
                                  return null;
                                },
                              ),
                            ],
                          )),
                      const SizedBox(
                        width: 10,
                      ),
                      Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              CustomText(
                                text: "Vérification du mot de passe",
                                size: 15,
                              ),
                              SizedBox(
                                height: 5,
                              ),
                              CustomTextFormField(
                                controller:checkNewPasswordTextEditingController,
                                validator: (value) {
                                  if (!regex.hasMatch(value!)) {
                                    return 'Svp  votre mot de passe doit contenir 8 chiffres,des majuscules et des minuscules';
                                  }
                                  return null;
                                },
                              ),
                            ],
                          ))
                    ],
                  )
                      : Center(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        CustomText(
                          text: "Mot de passe actuel",
                          size: 15,
                        ),
                        SizedBox(
                          height: 5,
                        ),
                        CustomTextFormField(
                          controller: currentPasswordTextEditingController,
                          validator: (value) {
                            if (!regex.hasMatch(value!)) {
                              return 'Svp  votre mot de passe doit contenir 8 chiffres,des majuscules et des minuscules';
                            }
                            return null;
                          },
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        CustomText(
                          text: "Nouveau mot de passe",
                          size: 15,
                        ),
                        SizedBox(
                          height: 5,
                        ),
                        CustomTextFormField(
                            controller: newPasswordTextEditingController,
                            validator: (value) {
                              if (!regex.hasMatch(value!)) {
                                return 'Svp  votre mot de passe doit contenir 8 chiffres,des majuscules et des minuscules';
                              }
                              return null;
                            }
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        CustomText(
                          text: "Vérification du mot de passe",
                          size: 15,
                        ),
                        SizedBox(
                          height: 5,
                        ),
                        CustomTextFormField(
                          controller: checkNewPasswordTextEditingController,
                          validator: (value) {
                            if (!regex.hasMatch(value!)) {
                              return 'Svp  votre mot de passe doit contenir 8 chiffres,des majuscules et des minuscules';
                            }
                            return null;
                          },
                        )
                      ],
                    ),
                  ),
                ),
              ),
            ),
            SizedBox(
              height: 20,
            ),
            Center(
              child: InkWell(
                onTap: () async {
                  if (_formKey.currentState!.validate()) {
                    updatePassword(context);
                  }
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
      ),
    );
  }
}
