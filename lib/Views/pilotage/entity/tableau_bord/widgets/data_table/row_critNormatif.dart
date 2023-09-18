import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../../../../models/pilotage/indicateur_model.dart';
import '../../../../controllers/tableau_controller.dart';
import '../utils_TB.dart';
import 'row_indicateur.dart';
final ControllerTbQSE _controllerTbQSE =  Get.find();
List<IndicateurModel> containIndicateur=[];
class RowCritereNormatif extends StatefulWidget {
  final String? numero;
  final String idEnjeu;
  final String idCritNormatif;
  final String CritNormatifTitle;
  final Color color;
  const RowCritereNormatif(
      {Key? key,
        required this.CritNormatifTitle,
        required this.idEnjeu,
        required this.idCritNormatif,
        required this.color,
         this.numero})
      : super(key: key);

  @override
  State<RowCritereNormatif> createState() => _RowCritereNormatifState();
}

class _RowCritereNormatifState extends State<RowCritereNormatif> {
bool _press=false;
  //final TableauBordController tableauBordController = Get.find();
late final IndicateurModel indicateur;

@override
  void initState() {

    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          height: 30,
          padding: const EdgeInsets.only(left: 100),
          alignment: Alignment.centerLeft,
          decoration: BoxDecoration(
              color: widget.color.withOpacity(0.7),
              border: Border.all(color: Colors.white),
              borderRadius: BorderRadius.circular(4.0)),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(
                "${widget.CritNormatifTitle}",
                style: const TextStyle(
                    color: Colors.white, fontWeight: FontWeight.bold),
              ),
              Expanded(child: Container()),
              RotatedBox(
                quarterTurns: _press ? 1 : 3,
                child: IconButton(
                  splashRadius: 10,
                  icon: const Icon(
                    Icons.arrow_back_ios_sharp,
                    size: 15,
                    color: Colors.black,
                  ),
                  onPressed: () {
                    setState(() {
                      _press=!_press;
                    });
                  },
                ),
              ),
              const SizedBox(
                width: 15,
              )
            ],
          ),
        ),
        Visibility(
          visible: _press,
          child: Column(
              children: getIndicateurWidget(widget.CritNormatifTitle)
          ),
        )
      ],
    );
  }
}


  List<Widget> getIndicateurWidget(String CritNormatifTitle){
    containIndicateur=[];
  for(int i=0;i<DataIndicateur.length;i++){
    if(DataIndicateur[i].critereNormatif==CritNormatifTitle){
      containIndicateur.add(DataIndicateur[i]);
    }
  }
  return containIndicateur.map((indicateur) => Obx(() =>  RowIndicateur(indicateur: indicateur, mois:_controllerTbQSE.dropdownMois.value,))).toList();
}