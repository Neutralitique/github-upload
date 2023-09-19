import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:go_router/go_router.dart';
import 'package:perfqse/Views/pilotage/entity/tableau_bord/widgets/data_table/dashboard_list_view.dart';
import '../../../../api/api_indicateur.dart';
import '../../../../helpers/helper_methods.dart';
import '../../controllers/tableau_controller.dart';
import '../widgets/get_info_espace.dart';
import '../widgets/privacy_widget.dart';
import 'widgets/collecte_status.dart';
import 'widgets/dasboard_filtre.dart';
import 'widgets/data_table/dashboard_header.dart';
import 'widgets/entete_widget.dart';

class IndicateurScreen extends StatefulWidget {
  const IndicateurScreen({super.key});

  @override
  State<IndicateurScreen> createState() => _IndicateurScreenState();
}

class _IndicateurScreenState extends State<IndicateurScreen> {
  String espace = InfoEspace().getNameEspace();
  final ControllerTbQSE _controllerTbQSE =  Get.find();
  final ApiTableau_Bord api_TB = ApiTableau_Bord();
  late ScrollController _scrollController;
  bool _isLoaded = false;
  void getCritere()async{
     await api_TB.getAxe();
     await api_TB.getEnjeu();
    await api_TB.getCritere();
    await api_TB.getIndicateur(reference: "Q", annee:_controllerTbQSE.dropdownAnnee.value, entity: espace);
  }

  void loadScreen() async {
    await Future.delayed(Duration(seconds: 2));
    setState(() {
      _isLoaded = true;
    });
  }

  @override
  initState() {
    super.initState();
    loadScreen();
    getCritere();
    _scrollController = ScrollController();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(top: 16,left: 10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _controllerTbQSE.Size.value==400?Text("Tableau de bord",style: TextStyle(fontSize: 24,color: Color(0xFF3C3D3F),fontWeight: FontWeight.bold),)
            :Row(
            children: [
              Text("Tableau de bord",style: TextStyle(fontSize: 24,color: Color(0xFF3C3D3F),fontWeight: FontWeight.bold),),
              Spacer(flex:4),
              ElevatedButton(onPressed: (){
                _controllerTbQSE.Size.value=280;
                _controllerTbQSE.enjeuSelect.value="";
                context.go("/pilotage/espace/Trechville/tableau-de-bord");
              },style: ElevatedButton.styleFrom(
                backgroundColor: Colors.red,
              ) ,child: Text("Generale",style:TextStyle(
                  color:Colors.white,
                  fontWeight: FontWeight.bold
              ),)),
              SizedBox(width: 20,)
            ],
          ),
          EnteteTableauBord(),
          CollecteStatus(),
          SizedBox(height: 5,),
          Expanded(child: SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Container(
              width: 1200,
              height: 500,
              child:Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  DashBoardHeader(),
                _isLoaded ?  Expanded(child: Theme(
                    data: Theme.of(context).copyWith(scrollbarTheme: ScrollbarThemeData(
                      trackColor:  MaterialStateProperty.all(Colors.black12),
                      trackBorderColor: MaterialStateProperty.all(Colors.black38),
                      thumbColor: MaterialStateProperty.all(Color(0xFF80868B)),
                      interactive: true,
                    )),
                    child: Scrollbar(
                      controller: _scrollController,
                      thumbVisibility: true,
                      thickness: 8,
                      child: SingleChildScrollView(
                        controller: _scrollController,
                        physics: const BouncingScrollPhysics(),
                        child: const Padding(
                          padding: EdgeInsets.only(right: 15),
                          child: Column(
                            children: [
                              DashBoardListView(),
                            ],
                          ),
                        ),
                      ),
                    ),
                  )):Expanded(
                child: Column(
                children: [
                    Expanded(child: Center(
                          child: loadingPageWidget(),
                    )),]
                )
                ),
                ],
              )
            ),
          )),
          SizedBox(height: 20,),
          PrivacyWidget(),
          SizedBox(height: 20,)
        ],
      ),
    );
  }
}
