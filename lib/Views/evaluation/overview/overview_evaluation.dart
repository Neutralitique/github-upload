import "package:flutter/material.dart";

import "../../../module/styled_scrollview.dart";
import 'widget/listEvaluation.dart';
import "widget/header_card_overview.dart";
import "widget/listes_audits_widget.dart";

class OverviewEvaluation extends StatefulWidget {
  const OverviewEvaluation({super.key});

  @override
  State<OverviewEvaluation> createState() => _OverviewEvaluationState();
}



class _OverviewEvaluationState extends State<OverviewEvaluation> {
  int viewListAudit=1;
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 560,
      width: 1100,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
          children: [
        Row(children: [
          Text("Statistiques des audits"),
          SizedBox(width: 150,),
          Expanded(
            child: Container(
              height: 30,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(60),
                  border: Border.fromBorderSide(BorderSide(
                    width: 2,
                    color: Colors.grey,
                  ))),
              child: Text("   Apercu de l'audit N'AUDIT-20-05-2022",textAlign:TextAlign.start),
            ),
          )
        ]),
        SizedBox(height: 10,),
        SizedBox(
          width:1100,
          height: 200,
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
                itemCount:ListCardHeader.length,
                itemBuilder: (context, index) {
                  return HeaderCardOverviewEvaluation(
                      title:ListCardHeader[index]["title"]?[0] ,
                      footTitle:ListCardHeader[index]["footTitle"]?[0],
                      child:ListCardHeader[index]["card"]?[0]=="circle"?
                      Container(
                        width: 100,
                        height: 100,
                        decoration: BoxDecoration(
                          color: Colors.blue,
                          borderRadius: BorderRadius.circular(120)
                        ),
                      ):Expanded(
                        child: Container(
                          width: 230,
                          height: 200,
                          color: Colors.blue,
                        ),
                      ),
                      children:ListCardHeader[index]["elements"]??[]
                  );
                })),
            SizedBox(height: 3,),
                const Text("Listes des Audits",style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 17
                ),),
                SizedBox(height: 10,),
            Expanded(
              flex:6,
                  child: Container(
                    height: 300,
                    width:1000,
                    child:ListView.builder(
                        scrollDirection: Axis.vertical,
                        itemCount:viewListAudit,itemBuilder:(context,index){
                      return ListEvaluation(
                        date: "20-05-2023",
                        statut: "validé",
                      );
                    }),
                  ),
                ),
                SizedBox(
                  height: 50,
                  child: Row(
                    children: [
                      Expanded(child: Container(),),
                      OutlinedButton(
                      onPressed: (){
                        setState(() {
                          viewListAudit+=1;
                        });
                      },
                      child: Text("Tout Affiché",style: TextStyle(
                        color:Colors.amber,
                        fontSize: 14
                      ),),
                    )
                    ],
                  ),
                )
      ]),
    );
  }
}
