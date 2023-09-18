import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import '../../../../helpers/helper_methods.dart';
import '../widgets/privacy_widget.dart';
import 'overview_pilotage.dart';

class ScreenOverviewPilotage extends StatefulWidget {
  /// Constructs a [ScreenOverviewPilotage] widget.
  const ScreenOverviewPilotage({super.key});

  @override
  State<ScreenOverviewPilotage> createState() => _ScreenOverviewPilotageState();
}

class _ScreenOverviewPilotageState extends State<ScreenOverviewPilotage> {
  bool _isLoaded = false;
  late ScrollController _scrollController;

  void loadScreen() async {
    await Future.delayed(Duration(seconds: 2));
    setState(() {
      _isLoaded = true;
    });
  }

  bool _showFab = true;


  void _handleScroll() {
    if (_scrollController.position.userScrollDirection == ScrollDirection.reverse) {
      setState(() {
        _showFab = false;
      });
    }
    if (_scrollController.position.userScrollDirection == ScrollDirection.forward) {
      setState(() {
        _showFab = true;
      });
    }
  }

  @override
  void dispose() {
    _scrollController.removeListener(_handleScroll);
    _scrollController.dispose();
    super.dispose();
  }



  @override
  void initState() {
    super.initState();
    loadScreen();
    _scrollController = ScrollController();
    _scrollController.addListener(_handleScroll);
  }

  @override
  Widget build(BuildContext context) {
    int width = MediaQuery.of(context).size.width as int;
    return Scaffold(
      body: Padding(
        padding: EdgeInsets.only(top: 16,left: 10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text("Accueil",style: TextStyle(fontSize: 24,color: Color(0xFF3C3D3F),fontWeight: FontWeight.bold),),
            SizedBox(height: 10,),
            _isLoaded ? Expanded(child: Theme(
              data: Theme.of(context).copyWith(scrollbarTheme: ScrollbarThemeData(
                trackColor:  MaterialStateProperty.all(Colors.black12),
                trackBorderColor: MaterialStateProperty.all(Colors.black38),
                thumbColor: MaterialStateProperty.all(Color(0xFF80868B)),
                interactive: true,
              )),
              child:SingleChildScrollView(
                child: const Padding(
                  padding: EdgeInsets.only(right: 15),
                  child:  Column(
                    children:  [
                      OverviewPilotage(),
                      SizedBox(height: 5,),
                    ],
                  ),
                ),
              ),
            )) : Expanded(
              child: Column(
                children: [
                  Expanded(child: Center(
                    child: loadingPageWidget(),//const SpinKitRipple(color: Colors.blue,),
                  )),
                  // const SizedBox(height: 20,),
                  // // const PrivacyWidget(),
                  // // const SizedBox(height: 20,),
                ],
              ),
            ),
            PrivacyWidget(),
            SizedBox(height: 2,),
          ],
        ),
      ),
    );
  }
}