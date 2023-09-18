

import 'package:flutter/material.dart';
import 'package:perfqse/Views/pilotage/entity/archive/BoxText/pie_chart.dart';

class BoxAxe extends StatefulWidget {
  final String firsttitle;
  final String secondtitle;
  final String subtitle;
  final double width_1;
  final double width_2;
  final Color color;
  final Color colorChartSectionFull;
  final Color colorChartSectionEmpty;
  final double numChartSectionFull;
  const BoxAxe({super.key,
    required this.firsttitle,
    required this.secondtitle,
    required this.subtitle,
    required this.color,
    required this.colorChartSectionFull,
    required this.colorChartSectionEmpty,
    required this.numChartSectionFull, required this.width_1, required this.width_2,
  });

  @override
  State<BoxAxe> createState() => _BoxAxeState();
}

class _BoxAxeState extends State<BoxAxe> {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: widget.width_1,
      height: 120,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        color:Colors.white,
      ),
      child: Card(
        elevation: 4,
        shape:RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20)
        ),
        child: Row(
          children: [
            Container(
              width: 30,
              height: double.infinity,
              decoration: BoxDecoration(
                  color:widget.color,
                  borderRadius: BorderRadius.only(topLeft:Radius.circular(20),bottomLeft: Radius.circular(20) )
              ),
            ),
            Expanded(child: Container(
                decoration: BoxDecoration(
                    color:Colors.white70,
                    borderRadius: BorderRadius.only(topRight: Radius.circular(20),bottomRight: Radius.circular(20))
                ),
                child:Row(
                  children: [
                    Container(
                      width: widget.width_2,
                      height: double.infinity,
                      child:  Column(
                        children: [
                          const SizedBox(height: 10,),
                          Text(widget.firsttitle,style: TextStyle(
                              fontSize: 17,color: Colors.black,fontWeight: FontWeight.bold
                          ),),
                          Text(widget.secondtitle,style: TextStyle(
                              fontSize: 17,color: Colors.black,fontWeight: FontWeight.bold
                          ),),
                          const SizedBox(height: 9,),
                          Text(widget.subtitle,style: TextStyle(
                              fontSize:11,color: Colors.black
                          ),)
                        ],
                      ),
                    ),
                    SizedBox(
                      width: 8,
                      height:double.infinity,
                      child: Center(
                        child: Container(
                          width: 2,
                          height: 50,
                          color: Colors.black,
                        ),
                      ),
                    ),
                    SizedBox(
                      width: 100,
                      height: double.infinity,
                      child: PieChartDonnut(
                        numFull:widget.numChartSectionFull,
                        colorFull:widget.colorChartSectionFull,
                        colorEmpty:widget.colorChartSectionEmpty,
                      ),
                    )
                  ],
                )
            ))
          ],
        ),
      ),
    );
  }
}
