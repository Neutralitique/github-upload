import 'package:flutter/material.dart';

class HeaderCardOverviewEvaluation extends StatefulWidget {
  final String? title;
  final List<dynamic> children;
  final Widget child;
  final String? footTitle;
  const HeaderCardOverviewEvaluation({super.key, this.title,required this.children, required this.child, this.footTitle});

  @override
  State<HeaderCardOverviewEvaluation> createState() => _HeaderCardOverviewEvaluationState();
}

class _HeaderCardOverviewEvaluationState extends State<HeaderCardOverviewEvaluation> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top:8.0,bottom: 8.0,right: 12.0),
      child: Container(
        height: 190,
        width: 250,
        decoration:BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          border:Border.fromBorderSide(
            BorderSide(
              width: 1,color: Colors.grey
            )
          )
        ),
        child: Column(
          children: [
              Center(child: Text(widget.title??"",style:TextStyle(fontSize: 15,fontWeight: FontWeight.bold))),
              Expanded(child: Container(
                child:Row(
                  children: [
                    Padding(
                      padding: EdgeInsets.all(7),
                      child: widget.child,
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children:List.generate(widget.children.length,
                              (index) => Text(widget.children[index])),
                    )
                  ],
                )
              ),),
              Center(child: Text(widget.footTitle??"",style:TextStyle(fontSize: 13,fontWeight: FontWeight.normal))),
              SizedBox(height: 10,)
          ],
        ),
      ),
    );
  }
}