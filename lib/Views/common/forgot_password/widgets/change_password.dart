import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:get/get.dart';
import 'package:go_router/go_router.dart';
import '../../../../helpers/helper_methods.dart';
import '../../../../utils/utils.dart';
import '../../../../widgets/customtext.dart';
import '../controller/reset_password_controller.dart';

class ChangePassword extends StatefulWidget {
  const ChangePassword({Key? key}) : super(key: key);

  @override
  State<ChangePassword> createState() => _ChangePasswordState();
}

class _ChangePasswordState extends State<ChangePassword> {

  final ResetPassWordController resetPassWordController = Get.find();
  late final TextEditingController _newPassWord;
  late final TextEditingController _confirmPassWord;
  final _formKey = GlobalKey<FormState>();
  bool isLoadedPage = false;

  bool _obscureNewPassWord = true;
  bool _obscureConfirmPassWord = true;

  void changePassWord(BuildContext context) async{
    setState(() {
      isLoadedPage = true;
    });

    try {
      final hashPwd = hashPassword(_newPassWord.text);

      final result = await {};

      if (result["status"]) {
        await Future.delayed(Duration(seconds: 2));
        ScaffoldMessenger.of(context).showSnackBar(showSnackBar("Succès",result["message"],Colors.green));
        resetPassWordController.initValue();
        context.go("/account/login");

      }

      setState(() {
        isLoadedPage = false;
      });

    } catch (e) {

      final message = e.toString().split("Exception: ").join("");
      await Future.delayed(Duration(seconds: 2));
      setState(() {
        isLoadedPage = false;
      });
      ScaffoldMessenger.of(context).showSnackBar(showSnackBar("Echec",message,Colors.red));

    }

  }

  @override
  void initState() {
    _newPassWord = TextEditingController();
    _confirmPassWord = TextEditingController();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(10),
      width: 700,
      height: 500,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          CustomText(text: "Changement du mot de passe",size: 25,weight: FontWeight.bold,),
          SizedBox(height: 20,),
          Card(
            elevation: 5,
            child: Container(
              padding: EdgeInsets.all(20),
              width: 480,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  CustomText(text: "Veuillez fournir ou confirmer les renseignements suivants :",size: 18,color: Colors.amber,),
                  SizedBox(height: 10,),
                  CustomText(text: "Inscrivez votre nouveau mot passe.",size: 13,),
                  Form(
                    autovalidateMode: AutovalidateMode.disabled,
                    key: _formKey,
                    child: Column(
                      mainAxisAlignment:
                      MainAxisAlignment.spaceAround,
                      children: [
                        SizedBox(height: 20,),
                        Column(
                          children: [
                            TextFormField(
                              decoration: InputDecoration(
                                  hintText: "Nouveau mot de passe",
                                  prefixIcon: Icon(Icons.password),
                                  suffixIcon: GestureDetector(
                                    onTap: () {
                                      setState(() {
                                        _obscureNewPassWord =
                                        !_obscureNewPassWord;
                                      });
                                    },
                                    child: Icon(_obscureNewPassWord
                                        ? Icons.visibility
                                        : Icons
                                        .visibility_off),
                                  ),
                                  contentPadding: const EdgeInsets.only(
                                      left: 20.0,
                                      right: 20.0),
                                  border: OutlineInputBorder(),
                                  focusedBorder: OutlineInputBorder(
                                      borderSide: BorderSide(
                                          color: Theme.of(
                                              context)
                                              .primaryColor,
                                          width: 2))),
                              controller: _newPassWord,
                              obscureText: _obscureNewPassWord,
                              validator: (value) { if (value == null || value.isEmpty || value.length < 8) {
                                return 'Le mot de passe doit avoir au moins de 8 caractères.';
                              }
                              return null;
                              },
                            ),
                            SizedBox(height: 20,),
                            TextFormField(
                              decoration: InputDecoration(
                                  hintText: "Confirmer le nouveau mot de passe",
                                  prefixIcon: Icon(Icons.password),
                                  suffixIcon: GestureDetector(
                                    onTap: () {
                                      setState(() {
                                        _obscureConfirmPassWord = !_obscureConfirmPassWord;
                                      });
                                    },
                                    child: Icon(_obscureConfirmPassWord
                                        ? Icons.visibility
                                        : Icons
                                        .visibility_off),
                                  ),
                                  contentPadding: const EdgeInsets.only(
                                      left: 20.0,
                                      right: 20.0),
                                  border: OutlineInputBorder(),
                                  focusedBorder: OutlineInputBorder(
                                      borderSide: BorderSide(
                                          color: Theme.of(
                                              context)
                                              .primaryColor,
                                          width: 2))),
                              controller: _confirmPassWord,
                              obscureText: _obscureConfirmPassWord,
                              validator: (value) {
                                if(value == null || value.isEmpty) {
                                  return "Ce champ est vide.";
                                }
                                if (value!=_newPassWord.text ){
                                  return "Les mots de passe renseignés ne sont identiques.";
                                }
                                return null;
                              },
                            ),
                          ],
                        ),
                        SizedBox(height: 30,),
                        ElevatedButton(
                            onPressed: isLoadedPage ? null : () async {
                              if (_formKey.currentState!.validate()){
                                changePassWord(context);
                              }
                            },
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.amber,
                              shape: const StadiumBorder(),
                            ),
                            child: Container(
                              alignment: Alignment.center,
                              width: double.maxFinite,
                              height: 40,
                              padding: const EdgeInsets.symmetric(vertical: 10),
                              child: isLoadedPage ? const SpinKitWave(color: Colors.amber, size: 20,) : const CustomText(
                                text: "CONFIRMER",
                                color: Colors.white,
                              ),
                            )),
                        SizedBox(height: 20,),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
