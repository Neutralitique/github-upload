import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:go_router/go_router.dart';
import 'package:perfqse/Views/pilotage/home/widgets/expand_element.dart';
import '../../../../module/styled_scrollview.dart';
import '../../../../widgets/customtext.dart';
import '../../controllers/controllerEntity.dart';
import 'contentbox.dart';
import 'listefilliale.dart';
import 'overview_card.dart';
import 'overview_item.dart';

class ContentPilotageHome extends StatefulWidget {
  const ContentPilotageHome({Key? key}) : super(key: key);

  @override
  State<ContentPilotageHome> createState() => _ContentPilotageHomeState();
}

class _ContentPilotageHomeState extends State<ContentPilotageHome> {
  final ControllerEntity _controllerEntity =Get.find();
  ScrollController scrollController = ScrollController();

     final List<Map<String,dynamic>> _filliale = List.generate(
         filliale.length,
           (index) => {
         'commune':filliale[index]["commune"],
       });
  final List<Map<String,dynamic>> _processTrans = List.generate(
      processTrans.length,
          (index) => {
        'processTrans':processTrans[index]["name"],
        "prefix":processTrans[index]["prefix"]
      });
  final List<Map<String,dynamic>> _processGene = List.generate(
      processGene.length,
          (index) => {
        'processGene':processGene[index]["name"],
        "prefix":processGene[index]["prefix"]
      });

  final List<Map<String,dynamic>> _smqse = List.generate(
      smqse.length,
          (index) => {
        "first":smqse[index]["first"],
        "second":smqse[index]["second"]
      });
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(left: 25),
      child: Row(
        children: [
        Column(
          children: [
            Container(
              width: 750 ,
              padding:EdgeInsets.all(3),
              decoration:BoxDecoration(
                  borderRadius: BorderRadius.circular(60),
                  border:const Border.fromBorderSide(
                      BorderSide(
                        width: 2,
                        color: Colors.black,
                      )
                  )
              ),
              child: Container(
                height: 40,
                decoration: BoxDecoration(
                  color:Colors.red,
                  borderRadius: BorderRadius.circular(60)
                ),
                child: Center(child: Text("Suivi des Indicateurs",style:TextStyle(
                  fontWeight: FontWeight.bold,fontSize: 23,color:Colors.white
                ),)),
              ),
            ),
            const SizedBox(height:10,),
            Row(
              children: [
                SizedBox(width:3,),
                ContentBox(
                  title: Text("PROCESSUS GENERAUX",style: TextStyle(
                      fontSize: 17,fontWeight: FontWeight.bold,color: Colors.white
                  ),),
                  width: 210,
                  height: 211,
                  children: _processGene.map((item){
                    return TextButton(onPressed:(){
                      if(item["villefirst"]=="Trechville"){
                        _controllerEntity.selectedEntity.value=item["villefirst"];
                        context.go("/pilotage/espace/Trechville/accueil");
                      }
                    }, child:Text(item["processGene"]!,
                      style: TextStyle(fontWeight: FontWeight.bold,color: Colors.black,
                          fontSize: 16),));
                  }).toList(),
                ),
                SizedBox(width: 10,),
                ContentBox(
                  title: Text("PROCESSUS TRANSVERSEAUX",style: TextStyle(
                      fontSize: 17,fontWeight: FontWeight.bold,color: Colors.white
                  ),),
                  width:260,
                  height: 210,
                  children: _processTrans.map((item){
                    return TextButton(onPressed:(){

                    }, child:Text(item["processTrans"]!,
                      style: TextStyle(fontWeight: FontWeight.bold,color: Colors.black,
                          fontSize: 16),));
                  }).toList(),
                ),
                SizedBox(width: 10,),
                ContentBox(
                  width:200,
                  height:211,
                  title: Text("PROCESSUS MI",style: TextStyle(
                      fontSize: 17,fontWeight: FontWeight.bold,color: Colors.white
                  ),),
                  children:[
                    Center(
                      child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: _filliale.map((item){
                        return TextButton(onPressed:(){
                          if(item["commune"]=="Trechville"){

                            context.go("/pilotage/espace/Trechville/accueil");
                          }
                        }, child:Text(item["commune"]!,
                          style: TextStyle(fontWeight: FontWeight.bold,color: Colors.black,
                              fontSize: 16),));
                      }).toList(),
                  ),
                    ),
              ]
                ),

            ],)
          ],
        ),
          const SizedBox(width: 10,),
          Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Container(
                width:400,
                padding:EdgeInsets.all(3),
                decoration:BoxDecoration(
                    borderRadius: BorderRadius.circular(60),
                    border:const Border.fromBorderSide(
                        BorderSide(
                          width: 2,
                          color: Colors.black,
                        )
                    )
                ),
                child: Container(
                  height: 40,
                  decoration: BoxDecoration(
                      color:Colors.red,
                      borderRadius: BorderRadius.circular(60)
                  ),
                  child: Center(child: Text("Gestion SMQSE",style:TextStyle(
                      fontWeight: FontWeight.bold,fontSize: 23,color:Colors.white
                  ),)),
                ),
              ),
              const SizedBox(
                height:10,
              ),
            Container(
                      width:350,
                      height: 210,
                      padding:EdgeInsets.all(2),
                      decoration: BoxDecoration(
                      color: Color(0xFFF4F4F4),
                      borderRadius: BorderRadius.circular(20),
                      border: Border.fromBorderSide(
                          BorderSide(
                          width: 1,
                          color: Color(0xFFA4A6B3),))),
                      child:StyledScrollView(
                        child: Column(
                            children:[
                              const SizedBox(height: 5,),
                              Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: _smqse.map((item){
                                    return TextButton(onPressed:(){}, child:Text("${item["first"]!}",textAlign:TextAlign.center,
                                      style: TextStyle(fontWeight: FontWeight.bold,color: Colors.black,
                                          fontSize: 16),));
                                  }).toList(),
                              ),
                            ]
                        ),
                      ),
                    ),
            ],
          ),
        ],
      ),
    );
  }
}

