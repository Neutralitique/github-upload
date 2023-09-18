import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:go_router/go_router.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:get/get.dart';
import 'package:perfqse/widgets/copyright.dart';
import 'package:perfqse/widgets/customtext.dart';
import 'package:http/http.dart' as http;
import 'package:supabase_flutter/supabase_flutter.dart';
import '../../../helpers/helper_methods.dart';
import '../main_page/common_home_page.dart';


class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {

    final storage = FlutterSecureStorage();
  final RegExp regex = RegExp(r'^(?=.*[a-z])(?=.*[A-Z])(?=.*\d).{8,}$');
  final _formKey = GlobalKey<FormState>();
  bool _obsureText = true;
  late final TextEditingController _emailController;
  late final TextEditingController _passwordController;

  final supabase = Supabase.instance.client;

  bool isLoadedPage = false;

  bool isHovering = false;

  bool onLogging = false;
  bool isLogging = false;

  void login(BuildContext context) async {
    setState(() {
      isLoadedPage = true;
    });
    try {

      final result = await supabase.auth.signInWithPassword(
        email: _emailController.text,
        password: _passwordController.text,
      );

      final email = result.user?.email;
      final acces_token = result.session?.accessToken;

      if (email !=null && acces_token !=null) {
        await storage.write(key: 'logged', value: "true");
        await storage.write(key: 'email', value: email);
        await Future.delayed(Duration(milliseconds: 500));
        context.go("/");
        setState(() {
          isLoadedPage = false;
        });
      }
      else {
        final message = "Vos identifiants sont incorrectes";
        await Future.delayed(Duration(seconds: 2));
        setState(() {
          isLoadedPage = false;
        });
        ScaffoldMessenger.of(context).showSnackBar(showSnackBar("Echec",message,Colors.red));
      }
    } on Exception catch (e) {
      print(e.toString());
      final message = "Vos identifiants sont incorrectes";
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
    _passwordController = TextEditingController();
    super.initState();
  }


  @override
  void dispose() {
    _passwordController.dispose();
    _emailController.dispose();
    super.dispose();
  }


  @override
  Widget build(BuildContext context) {
    double widthe=MediaQuery.of(context).size.width;
    return Scaffold(
        body: Column(
          children: [
           Expanded(
            child:Container(
                padding: const EdgeInsets.all(20.0),
                decoration: const BoxDecoration(
                image: DecorationImage(
                    image: AssetImage(
                      "assets/images/fond_accueil.jpg",
                    ),
                    fit: BoxFit.fill)),
                child:  Row(
                  children: [
                    widthe>1100? Expanded(
                        flex: 3,
                        child: Center(
                            child:Column(
                              children: [
                                SizedBox(
                                  height: 60,
                                ),
                                Container(
                                  width:600,
                                  height:500,
                                  decoration: BoxDecoration(
                                    image:DecorationImage(
                                      image: AssetImage("assets/images/pc_login.png"),
                                      fit: BoxFit.cover
                                    )
                                  ),
                                ),
                              ],
                            )
                        )
                    ):Container(),
                    Expanded(
                      flex:3,
                      child: Column(
                        children: [
                          const SizedBox(height: 20),
                          Container(
                            width: 400,
                            height: 80,
                              decoration:BoxDecoration(
                                image: DecorationImage(
                                    image: AssetImage("assets/logos/perf_QSE.png")
                                )
                              )
                          ),
                         const  SizedBox(height: 40,),
                          SizedBox(
                            width: 400,
                            height: 390,
                            child: Card(
                              elevation: 10,
                              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.0)),
                              child: Padding(
                                padding: const EdgeInsets.only(right: 20.0,left: 20.0,top: 20.0),
                                child: Form(
                                  autovalidateMode: AutovalidateMode.disabled,
                                  key: _formKey,
                                  child: Column(
                                    mainAxisAlignment:
                                    MainAxisAlignment.spaceAround,
                                    crossAxisAlignment: CrossAxisAlignment.center,
                                    children: [
                                      Text(
                                        "Se connecter",
                                        style: TextStyle(
                                            fontSize: 29,
                                            fontWeight: FontWeight.bold,
                                            color: Colors.black),
                                      ),
                                      const SizedBox(height:5,),
                                      Column(
                                        children: [
                                          TextFormField(
                                            validator: (value) {
                                              if (value == null ||
                                                  value.isEmpty ||
                                                  !GetUtils.isEmail(
                                                      value)) {
                                                return 'Svp veuillez entrer un e-mail correct.';
                                              }
                                              return null;
                                            },
                                            decoration: const InputDecoration(
                                                hintText: "Courriel",
                                                prefixIcon: Icon(Icons.person),
                                                contentPadding:
                                                 EdgeInsets.only(
                                                    left: 20.0,
                                                    right: 20.0),
                                                border: OutlineInputBorder(),
                                                focusedBorder:
                                                OutlineInputBorder(
                                                    borderSide: BorderSide(
                                                        color: Colors.black,
                                                        width: 2))),
                                            controller: _emailController,
                                          ),
                                          SizedBox(
                                            height: 20,
                                          ),
                                          TextFormField(
                                            obscureText: _obsureText,
                                            controller: _passwordController,
                                           validator: (value) {
                                                  if (value == null ||
                                                      value.isEmpty ||
                                                       !regex.hasMatch(value)) {
                                                    return 'Le mot de passe doit avoir au moins de 8 caractères.';
                                                  }
                                                  return null;
                                                },
                                            decoration: InputDecoration(
                                                suffixIcon: GestureDetector(
                                                  onTap: () {
                                                    setState(() {
                                                      _obsureText = !_obsureText;
                                                    });
                                                  },
                                                  child: Icon(_obsureText
                                                      ? Icons.visibility
                                                      : Icons.visibility_off),
                                                ),
                                                hintText: "Mot de passe",
                                                prefixIcon:
                                                Icon(Icons.vpn_key_sharp),
                                                contentPadding:
                                                const EdgeInsets.only(
                                                    left: 20.0,
                                                    right: 20.0),
                                                border:
                                                const OutlineInputBorder(),
                                                focusedBorder:
                                                OutlineInputBorder(
                                                    borderSide: BorderSide(
                                                        color: Colors.black,
                                                        width: 2))),
                                          ),
                                        ],
                                      ),
                                      SizedBox(height: 30,child:const Divider()),
                                      InkWell(
                                        onHover: (value) {
                                            setState(() {
                                              isHovering = value;
                                            });
                                        },
                                        onTap: (){},
                                        child: ElevatedButton(
                                            onPressed: isLoadedPage ? null : () async {
                                              if (_formKey.currentState!.validate()) {
                                                login(context);

                                              }
                                            },
                                            style: ElevatedButton.styleFrom(
                                              backgroundColor: isHovering? Colors.red:Colors.black,
                                              side: BorderSide(width: 1,color: Colors.black),
                                              shape: isHovering ? StadiumBorder() : RoundedRectangleBorder(borderRadius: BorderRadius.circular(4)),
                                            ),
                                            child: Container(
                                              alignment: Alignment.center,
                                              width: double.maxFinite,
                                              height: 50,
                                              padding: const EdgeInsets.symmetric(vertical: 10),
                                              child: isLoadedPage ? SpinKitWave(color: Colors.black,size: 20,) : const CustomText(
                                                text: "Se connecter",
                                                color: Colors.white,
                                                size: 20,
                                              ),
                                            )),
                                      ),
                                      const SizedBox(height: 10,),
                                      TextButton(
                                          onPressed: () async{
                                            context.go("/account/reset-password");
                                          },
                                          child: const CustomText(
                                        text: "J’ai oublié mon mot de passe",
                                        color: Colors.green,
                                      ))
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
            ),
            ),
          const CopyRight()
      ],
    ));
  }
}

