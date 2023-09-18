import 'package:flutter/material.dart';
import 'package:perfqse/Views/pilotage/entity/tableau_bord/tableau_bord.dart';
import '../../../../helpers/helper_methods.dart';
import '../widgets/privacy_widget.dart';
import 'indicateur_screen.dart';
import 'strategy_card.dart';

class ScreenTableauBordPilotage extends StatefulWidget {
  /// Constructs a [ScreenTableauBordPilotage] widget.
  const ScreenTableauBordPilotage({super.key});

  @override
  State<ScreenTableauBordPilotage> createState() => _ScreenTableauBordPilotageState();
}

class _ScreenTableauBordPilotageState extends State<ScreenTableauBordPilotage> {
  bool _isLoaded = false;


  void loadScreen() async {
    await Future.delayed(Duration(seconds: 2));
    setState(() {
      _isLoaded = true;
    });
  }

  @override
  void initState() {
    super.initState();
    loadScreen();
  }

  @override
  Widget build(BuildContext context) {
    int width = MediaQuery.of(context).size.width.round();
    return Scaffold(
      body: Padding(
        padding: EdgeInsets.only(top: 16,left: 10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text("Tableau de bord",style: TextStyle(fontSize: 24,color: Color(0xFF3C3D3F),fontWeight: FontWeight.bold),),
            SizedBox(height: 10,),
            // Center(
            //   child: Card(
            //     elevation: 3,
            //     shape: RoundedRectangleBorder(
            //       borderRadius: BorderRadius.circular(20.0),
            //     ),
            //     child: Container(
            //       width: 450,
            //       decoration: BoxDecoration(
            //         color: Colors.amber,
            //         borderRadius: BorderRadius.circular(20)
            //       ),
            //       padding: EdgeInsets.symmetric(vertical: 20),
            //       child: Center(child: Text(
            //         "GOUVERNANCE ET STRATEGIE DD",
            //         style: TextStyle(color: Colors.white,fontSize: 25,fontWeight: FontWeight.bold),)),
            //     ),
            //   ),
            // ),
            // SizedBox(height: 10,),
            _isLoaded ? Expanded(
              child: SingleChildScrollView(
                child: Container(
                  width: double.infinity,
                  child: Column(
                    children: [
                      TableauBord(),//IndicateurScreen(),//NewTableauBord(),
                      SizedBox(height: 10,),
                      PrivacyWidget(),
                      SizedBox(height: 10,),
                    ],
                  ),
                ),
              ),
            ) : Expanded(
              child: Column(
                children: [
                  Expanded(child: Center(
                    child: loadingPageWidget(),//const SpinKitRipple(color: Colors.blue,),
                  )),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}