import 'package:auto_animated/auto_animated.dart';
import 'package:flutter/material.dart';
import 'package:just_the_tooltip/just_the_tooltip.dart';
import 'package:perfqse/Views/pilotage/entity/archive/BoxText/boxprocess.dart';
import 'package:perfqse/module/styled_scrollview.dart';

import '../../../../../../constants/colors.dart';

class CollecteGlobale extends StatefulWidget {
  const CollecteGlobale({
    Key? key,
  }) : super(key: key);

  @override
  State<CollecteGlobale> createState() => _CollecteGlobaleState();
}

class _CollecteGlobaleState extends State<CollecteGlobale> {
  dynamic ProcessInfos = [
    {
      "nom":"PC ACHATS",
      "2022":65,
      "2023":78
    },
    {
      "nom":"PC CONDITIONNEMENT",
      "2022":25,
      "2023":68
    },
    {
      "nom":"PC CONTROLE QUALITE",
      "2022":70,
      "2023":45
    },
    {
      "nom":"PC FABRICATION",
      "2022":69,
      "2023":80
    },

    {
      "nom":"PC LOG",
      "2022":69,
      "2023":80
    },
    {
      "nom":"PC MAINTENANCE",
      "2022":69,
      "2023":80
    },
    {
      "nom":"PC QSE",
      "2022":69,
      "2023":80
    },
    {
      "nom":"PC RH",
      "2022":69,
      "2023":80
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Container(
      padding:  EdgeInsets.all(defaultPadding),
      decoration: const BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.all(Radius.circular(10)),
      ),
      child: Column(
        children: [
          Text("Progrès de collecte Processus",style: Theme.of(context).textTheme.titleMedium,),
          const SizedBox(height: 18,),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children:[
              Container(
                height: 800,
                width:400,
                child: LiveList(
                  showItemInterval: Duration(milliseconds: 500),
                  showItemDuration: Duration(seconds: 1),
                  scrollDirection: Axis.vertical,
                  itemCount: ProcessInfos.length,
                  itemBuilder: _buildAnimatedItem,
                ),
              ),
            ]
          ),
        ],
      ),
    );
  }
  Widget _buildAnimatedItem(BuildContext context,
      int index,
      Animation<double> animation,) =>
      FadeTransition(
        opacity: Tween<double>(
          begin: 0,
          end: 1,
        ).animate(animation),
        child: SlideTransition(
          position: Tween<Offset>(
            begin: Offset(0, -0.1),
            end: Offset.zero,
          ).animate(animation),
          child: _buildCard(index),
        ),
      );

  Widget _buildCard(dynamic index) =>
      Builder(
        builder: (context) =>
            BoxProcess(firstvalue:ProcessInfos[index]["2022"],
                secondvalue: ProcessInfos[index]["2023"], process: ProcessInfos[index]["nom"]));


  DataRow dataRow(Map entityInfo) {
    return DataRow(
      cells: [
        DataCell(
            JustTheTooltip(
              preferredDirection: AxisDirection.left,
              backgroundColor: Color(0xFF616161),
              waitDuration: Duration(milliseconds: 500),
              content: Container(
                padding: const EdgeInsets.all(8.0),
                child: Text(entityInfo["nom"],style: TextStyle(color: Colors.white),),
              ),
              child: TextButton(onPressed: () {  },
              child: Text(entityInfo["nom"].length>9?
              entityInfo["nom"][0]+ entityInfo["nom"][1]+
                  entityInfo["nom"][2]+ entityInfo["nom"][3]+ entityInfo["nom"][4]+
                  entityInfo["nom"][5]+ entityInfo["nom"][6]+
                  entityInfo["nom"][7]+ entityInfo["nom"][8]+entityInfo["nom"][9]+"...":entityInfo["nom"])),
            )),
        //child: Text("${entityInfo["nom"]}"))),
        DataCell(Text("${entityInfo["2022"]} %",style: TextStyle(fontWeight: FontWeight.bold,color: entityInfo["2022"] < 30 ?  Colors.red :
        entityInfo["2022"] < 60 ? Colors.yellow : entityInfo["2022"] < 75 ?
        Colors.green : Colors.blue),)),
        DataCell(Text("${entityInfo["2023"]} %",style: TextStyle(fontWeight: FontWeight.bold,color: entityInfo["2023"] < 30 ?  Colors.red :
        entityInfo["2023"] < 60 ? Colors.yellow : entityInfo["2023"] < 75 ?
        Colors.green : Colors.blue),))
      ],
    );
  }
}

// List.generate(ProcessInfos.length, (processvalue) =>
// BoxProcess(firstvalue:ProcessInfos[processvalue]["2022"],
// secondvalue: ProcessInfos[processvalue]["2023"], process: ProcessInfos[processvalue]["nom"])
// ),