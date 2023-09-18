import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:get/get.dart';
import 'package:go_router/go_router.dart';
import '../../../../helpers/helper_methods.dart';
import '../../../../utils/utils.dart';
import '../../../../widgets/customtext.dart';
import '../controller/reset_password_controller.dart';

class ConfirmResetCode extends StatefulWidget {
  const ConfirmResetCode({Key? key}) : super(key: key);

  @override
  State<ConfirmResetCode> createState() => _ConfirmResetCodeState();
}

class _ConfirmResetCodeState extends State<ConfirmResetCode> {

  final ResetPassWordController resetPassWordController = Get.find();
  late final TextEditingController _codeController;
  final _formKey = GlobalKey<FormState>();
  bool isLoadedPage = false;

  void confirmResetCode() async{
    setState(() {
      isLoadedPage = true;
    });
    await Future.delayed(Duration(seconds: 2));
    if (_codeController.text == resetPassWordController.resetCode.value) {
      resetPassWordController.resetStep.value = 3;
    }else {
      ScaffoldMessenger.of(context).showSnackBar(showSnackBar("Echec","Le code renseigné est incorrect .",Colors.red));
    }
    setState(() {
      isLoadedPage = false;
    });

  }


  @override
  void initState() {
    _codeController = TextEditingController();
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
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  CustomText(text: "Veuillez fournir ou confirmer les renseignements suivants :",size: 18,color: Color(0xFF9D6E16),),
                  SizedBox(height: 20,),
                  CustomText(text: "Inscrivez le code de vérification qui a été envoyé à votre adresse courriel, puis cliquez sur « VALIDER LE CODE ».",size: 13,),
                  Form(
                    autovalidateMode: AutovalidateMode.onUserInteraction,
                    key: _formKey,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(height: 20,),
                        Column(
                          children: [
                            TextFormField(
                              controller: _codeController,
                              validator: (value) {
                                if (value == null || value.isEmpty || !verifyCode(value)) {
                                  return 'Entrez un code de 6 chiffres.';
                                }
                                return null;
                              },
                              decoration: InputDecoration(
                                  hintText: "Code de vérification",
                                  prefixIcon: Icon(Icons.person),
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
                              //controller: _emailController,
                            ),
                          ],
                        ),
                        SizedBox(height: 30,),
                        Center(
                          child: ElevatedButton(
                              onPressed: isLoadedPage ? null : () async {
                                if (_formKey.currentState!.validate()){
                                  confirmResetCode();
                                }
                              },
                              style: ElevatedButton.styleFrom(
                                backgroundColor: Colors.amber,
                                shape: const StadiumBorder(),
                              ),
                              child: Container(
                                alignment: Alignment.center,
                                width: 200,
                                height: 40,
                                padding: const EdgeInsets.symmetric(vertical: 10),
                                child: isLoadedPage ? const SpinKitWave(color: Colors.amber, size: 20,): const CustomText(
                                  text: "VALIDER LE CODE",
                                  color: Colors.white,
                                ),
                              )),
                        ),
                        SizedBox(height: 30,),
                        CustomText(
                          text: "Obtenir un nouveau code",
                          color: Colors.grey,
                        )
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
