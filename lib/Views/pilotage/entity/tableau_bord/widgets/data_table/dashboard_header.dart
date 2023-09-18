import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../controllers/tableau_controller.dart';

class DashBoardHeader extends StatefulWidget {
  const DashBoardHeader({Key? key}) : super(key: key);

  @override
  State<DashBoardHeader> createState() => _DashBoardHeaderState();
}

class _DashBoardHeaderState extends State<DashBoardHeader> {
  final ControllerTbQSE _controllerTbQSE=Get.find();
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(left: 2.0,right: 15),
      child: Container(
        height: 30,
        width: double.maxFinite,

        decoration: BoxDecoration(
            color: Colors.brown,
          borderRadius: BorderRadius.only(topRight:Radius.circular(20),topLeft:Radius.circular(20))
        ),
        child: Row(
          children: [
            DashBoardHeaderTitle(color: Colors.brown, size: 50,title: "Num",),
            IndicateurTitle(color: Colors.brown, size:100,title: "Intitulé",),
            DashBoardHeaderTitle(color: Colors.brown, size:100,title: "Definition",),
            DashBoardHeaderTitle(color: Colors.brown, size: 70,title: "Type",),
            DashBoardHeaderTitle(color: Colors.brown, size: 80,title: "Unite",),
            DashBoardHeaderTitle(color: Colors.brown, size: 100,title: "Processus",),
            DashBoardHeaderTitle(color: Colors.brown, size: 170,title: "Réalisé 2023",),
            Obx(() =>  MonthHeader(color: Colors.brown, size: 150,title: "${_controllerTbQSE.dropdownMois.value}",),
            ),
            DashBoardHeaderTitle(color: Colors.brown, size: 100,title: "Cible",),
            DashBoardHeaderTitle(color: Colors.brown, size: 104,title: "Ecart",),
          ],
        ),
      ));
  }
}


class MonthHeader extends StatefulWidget {
  final double size;
  final Color color;
  final String title;
  const MonthHeader({super.key, required this.size, required this.color, required this.title});

  @override
  State<MonthHeader> createState() => _MonthHeaderState();
}

class _MonthHeaderState extends State<MonthHeader> {
  bool isHovering = false;
  late TextEditingController _mois_control=TextEditingController();
  @override
  void initState() {
    _mois_control = TextEditingController();
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: (){},
      onHover: (value){
        setState(() {
          isHovering = value;
        });
      },
        mouseCursor:SystemMouseCursors.click,
      child: Container(
        padding: const EdgeInsets.only(left: 2.0),
        width: widget.size,
        color: isHovering ? Color(0xFF8B735C) :widget.color,
        alignment: Alignment.centerLeft,
        child:Text("${widget.title}",style: TextStyle(color: Colors.white,fontSize: 15,fontWeight: FontWeight.bold),),
      ),
    );;
  }
}


class DashBoardHeaderTitle extends StatefulWidget {
  final double size;
  final Color color;
  final String title;
  const DashBoardHeaderTitle({Key? key, required this.size, required this.color, required this.title}) : super(key: key);

  @override
  State<DashBoardHeaderTitle> createState() => _DashBoardHeaderTitleState();
}

class _DashBoardHeaderTitleState extends State<DashBoardHeaderTitle> {
  bool isHovering = false;
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: (){},
      onHover: (value){
        setState(() {
          isHovering = value;
        });
      },
      child: Container(
        padding: const EdgeInsets.only(left: 2.0),
        width: widget.size,
        color: isHovering ? Color(0xFF8B735C) :widget.color,
        alignment: Alignment.centerLeft,
        child: Text("${widget.title}",style: TextStyle(color: Colors.white,fontSize: 15,fontWeight: FontWeight.bold),),
      ),
    );
  }
}


class IndicateurTitle extends StatefulWidget {
  final double size;
  final Color color;
  final String title;
  const IndicateurTitle({Key? key, required this.size, required this.color, required this.title}) : super(key: key);

  @override
  State<IndicateurTitle> createState() => _IndicateurTitleState();
}

class _IndicateurTitleState extends State<IndicateurTitle> {
  bool isHovering = false;
  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: InkWell(
        onTap: (){},
        onHover: (value){
          setState(() {
            isHovering = value;
          });
        },
        child: Container(
          width:double.infinity,
          padding: const EdgeInsets.only(left: 2.0),
          color: isHovering ? Color(0xFF8B735C) :widget.color,
          alignment: Alignment.centerLeft,
          child: Text("${widget.title}",style: TextStyle(color: Colors.white,fontSize: 15,fontWeight: FontWeight.bold),),
        ),
      ),
    );
  }
}

