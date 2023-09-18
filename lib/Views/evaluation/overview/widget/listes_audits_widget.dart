import 'package:flutter/material.dart';

class ListEvaluation extends StatefulWidget {
  final String date;
  final String statut;
  const ListEvaluation({super.key, required this.date, required this.statut});

  @override
  State<ListEvaluation> createState() => _ListEvaluationState();
}

class _ListEvaluationState extends State<ListEvaluation> {
  bool visible=true;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 10.0,top:2.0),
      child: Container(
        height:100,
        width:600,
        decoration: BoxDecoration(borderRadius: BorderRadius.circular(20),border: Border.fromBorderSide(BorderSide(width: 2,color:Colors.grey))),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height:7,),
                Text("Identifiants: AUDIT-${widget.date}"),
                SizedBox(height: 5,),
                RichText(text:TextSpan(text:"Date:     ",style: TextStyle(color: Colors.grey,),children: [
                  TextSpan(text: widget.date,style: const TextStyle(color: Colors.black,)),
                  const TextSpan(text:"     Status:    ",style: TextStyle(color: Colors.black,)),
                  TextSpan(text: widget.statut,style: const TextStyle(color: Colors.green,)),
                ])),
               const SizedBox(height:6,),
               Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      TextButton.icon(onPressed:(){}, icon:Icon(Icons.analytics_outlined,color: Colors.amber,), label:Text("Performances",style: TextStyle(
                        fontSize: 17,
                        fontWeight: FontWeight.bold,
                      ),)),
                      SizedBox(width: 20,),
                      TextButton.icon(onPressed:(){}, icon:Icon(Icons.book_online,color: Colors.amber,), label:Text("Rapport D'audit",style: TextStyle(
                        fontSize: 17,
                        fontWeight: FontWeight.bold,
                      ),))
                    ],
                  ),
                  Row(
                    children: [
                      Text("visible"),
                      SizedBox(width: 20,),
                      Switch(value:visible, onChanged:(value){
                        setState(() {
                          visible=true;
                        });
                      })
                    ],
                  ),
                ],
               )
          ],
        ),
      ),
    );
  }
}