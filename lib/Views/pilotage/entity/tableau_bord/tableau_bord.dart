import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:perfqse/Views/pilotage/entity/tableau_bord/strategy_card.dart';
import 'package:perfqse/Views/pilotage/entity/tableau_bord/widgets/utils_TB.dart';

import '../../controllers/tableau_controller.dart';
import '../widgets/privacy_widget.dart';

class TableauBord extends StatefulWidget {
  const TableauBord({super.key});

  @override
  State<TableauBord> createState() => _TableauBordState();
}

class _TableauBordState extends State<TableauBord> {
  late ScrollController _scrollController;
  final ControllerTbQSE _controllerTbQSE=Get.find();
  @override
  void initState() {
    super.initState();
    _scrollController = ScrollController();
  }
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(top: 16,left: 10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Text("Tableau de bord",style: TextStyle(fontSize: 24,color: Color(0xFF3C3D3F),fontWeight: FontWeight.bold),),
            Spacer(flex:4),
              ElevatedButton(onPressed: (){
                _controllerTbQSE.InitValue();
              },style: ElevatedButton.styleFrom(
              backgroundColor: Colors.red,
            ) ,child: Text("Generale",style:TextStyle(
              color:Colors.white,
              fontWeight: FontWeight.bold
            ),)),
              SizedBox(width: 20,)
            ],
          ),
          SizedBox(height: 5,),
          Expanded(child: Theme(
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
                child: Center(
                  child: const Padding(
                    padding: EdgeInsets.only(right: 15),
                    child: //QSE(),
                    NewTableauBord(),
                  ),
                ),
              ),
            ),
          )),
          SizedBox(height: 5,),
          PrivacyWidget(),
          SizedBox(height: 10,)
        ],
      ),
    );
  }
}
