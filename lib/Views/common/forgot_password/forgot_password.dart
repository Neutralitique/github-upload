import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../../../widgets/customtext.dart';
import '../../pilotage/entity/widgets/privacy_widget.dart';
import '../../../constants/colors.dart';
import 'controller/reset_password_controller.dart';
import 'widgets/ask_mail.dart';
import 'widgets/change_password.dart';
import 'package:get/get.dart';
import 'widgets/validate_code.dart';

class ResetPassword extends StatefulWidget {

  const ResetPassword({Key? key}) : super(key: key);

  @override
  State<ResetPassword> createState() => _ResetPasswordState();

}

class _ResetPasswordState extends State<ResetPassword> {
  var onHoverLogin = false;
  final resetPassWordController = Get.put(ResetPassWordController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(image: DecorationImage(image: AssetImage("assets/images/fond_accueil.jpg",), fit: BoxFit.fill)),
        child: Column(
          children: [
            Container(
              height: 60,
              color: headerApp,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                    margin: EdgeInsets.only(left: 100),
                    child: Center(
                      child: Image.asset(
                        "assets/logos/perf_rse.png",
                        height: 50,
                      ),
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.only(right: 100),
                    child: Row(
                      children: [
                        InkWell(
                            onTap: () {
                              context.go('/account/login');
                            },
                            onHover: (value) {
                              if (value) {
                                setState(() {
                                  onHoverLogin = true;
                                });
                              } else {
                                setState(() {
                                  onHoverLogin = false;
                                });
                              }
                            },
                            child: CustomText(
                              text: "Se Connecter",
                              color: onHoverLogin ? Colors.white : Colors.black,
                            )),
                        SizedBox(
                          width: 20,
                        ),
                        Icon(
                          Icons.language,
                          color: Colors.white,
                        ),
                        SizedBox(
                          width: 10,
                        ),
                        CustomText(
                          text: "FR",
                          color: Colors.white,
                        )
                      ],
                    ),
                  )
                ],
              ),
            ),
            Expanded(
                child: Center(
                  child: Container(alignment: Alignment.center, padding: EdgeInsets.all(20), child: Obx(() {
                    final step = resetPassWordController.resetStep.value;
                    if (step == 1 ) {
                      return ResetPasswordCode();
                    } else if (step == 2) {
                      return ConfirmResetCode();
                    } else if ( step == 3 ) {
                      return ChangePassword();
                    }
                    return Container();
                  }),
                  ),
                )),
            SizedBox(height: 20,),
            PrivacyWidget(),
            SizedBox(height: 20,),
          ],
        ),
      ),
    );
  }
}
