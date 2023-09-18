import 'package:flutter/material.dart';
import '../../../../helpers/helper_methods.dart';
import '../widgets/privacy_widget.dart';
import 'perform_pilotage.dart';
import 'widgets/entete_performance.dart';


class ScreenPilotagePerform extends StatefulWidget {
  /// Constructs a [ScreenPilotagePerform] widget.
  const ScreenPilotagePerform({super.key});

  @override
  State<ScreenPilotagePerform> createState() => _ScreenPilotagePerformState();
}

class _ScreenPilotagePerformState extends State<ScreenPilotagePerform> {
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
            Text("Performances",style: TextStyle(fontSize: 24,color: Color(0xFF3C3D3F),fontWeight: FontWeight.bold),),
            SizedBox(height: 5,),
            const EntetePerformance(),
            SizedBox(height: 5,),
            _isLoaded ? Expanded(
              child: Column(
                children: [
                  Expanded(child: Container(
                    child: PerformPilotage(),
                  )),
                  SizedBox(height: 20,),
                  PrivacyWidget(),
                  SizedBox(height: 20,),
                ],
              ),
            ) : Expanded(
              child: Column(
                children: [
                  Expanded(child: Center(
                    child: loadingPageWidget(),//const SpinKitRipple(color: Colors.blue,),
                  )),
                  SizedBox(height: 20,),
                  PrivacyWidget(),
                  SizedBox(height: 20,),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}