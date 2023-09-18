import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:get/get.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import '../../../../helpers/helper_methods.dart';
import '../../../../widgets/customtext.dart';
import '../controller/reset_password_controller.dart';

class ResetPasswordCode extends StatefulWidget {
  const ResetPasswordCode({Key? key}) : super(key: key);

  @override
  State<ResetPasswordCode> createState() => _ResetPasswordCodeState();
}

class _ResetPasswordCodeState extends State<ResetPasswordCode> {

  final ResetPassWordController resetPassWordController = Get.find();
  late final TextEditingController _emailController;
  final _formKey = GlobalKey<FormState>();

  final supabase = Supabase.instance.client;

  bool isLoadedPage = false;


  void sendResetCode() async{
    setState(() {
      isLoadedPage = true;
    });
    try {
      await supabase.auth.resetPasswordForEmail(_emailController.text);
      resetPassWordController.resetStep.value = 2;
      resetPassWordController.email.value = _emailController.text;
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
    _emailController = TextEditingController();
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
                  CustomText(text: "Inscrivez votre adresse courriel, puis cliquez sur « DEMANDER UN CODE DE VÉRIFICATION ».",size: 13,),
                  Form(
                    autovalidateMode: AutovalidateMode.onUserInteraction,
                    key: _formKey,
                    child: Column(
                      mainAxisAlignment:
                      MainAxisAlignment.spaceAround,
                      children: [
                        SizedBox(height: 20,),
                        Column(
                          children: [
                            TextFormField(
                              validator: (value) {
                                if (value == null || value.isEmpty || !GetUtils.isEmail(value)) {
                                  return 'Svp veuillez entrer un e-mail correct.';
                                }
                                return null;
                              },
                              decoration: InputDecoration(
                                  hintText: "Adresse courriel",
                                  prefixIcon: Icon(Icons.email),
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
                              controller: _emailController,
                            ),
                          ],
                        ),
                        SizedBox(height: 30,),
                        ElevatedButton(
                            onPressed: isLoadedPage ? null : () async {
                              if (_formKey.currentState!.validate()){
                                sendResetCode();
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
                              child: isLoadedPage ? const SpinKitWave(color: Colors.amber, size: 20,):  const CustomText(
                                text: "DEMANDER UN CODE DE VERIFICATION",
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
