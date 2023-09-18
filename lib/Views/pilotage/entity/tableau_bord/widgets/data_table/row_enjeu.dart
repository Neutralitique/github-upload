import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:perfqse/Views/pilotage/entity/tableau_bord/widgets/data_table/row_critNormatif.dart';
import 'package:perfqse/models/pilotage/critereModel.dart';
import '../../../../../../models/pilotage/indicateur_model.dart';
import '../../../../controllers/tableau_controller.dart';
import '../utils_TB.dart';
import 'row_critNormatif.dart';

class RowEnjeu extends StatefulWidget {
  final String numero;
  final String idAxe;
  final String idEnjeu;
  final String EnjeuTitle;
  final Color color;
  const RowEnjeu(
      {Key? key,
        required this.EnjeuTitle,
        required this.idEnjeu,
        required this.color,
        required this.idAxe,
        required this.numero})
      : super(key: key);

  @override
  State<RowEnjeu> createState() => _RowEnjeuState();
}

class _RowEnjeuState extends State<RowEnjeu> {
bool _press=false;
final ControllerTbQSE _controllerTbQSE = Get.find();

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
                "${widget.numero}. ${widget.EnjeuTitle}",
                style: const TextStyle(
                    color: Colors.white, fontWeight: FontWeight.bold),
              ),
              Expanded(child: Container()),
              RotatedBox(
                quarterTurns:_press ? 1 : 3,
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
              children: getCritereNormatifWidget(widget.idEnjeu)
          ),
        )
      ],
    );
  }
}


List<Widget> getCritereNormatifWidget(String idEnjeu ){
  List<CritereModel>containCritere=[];
  for(int i=0;i<DataCritere.length;i++){
    print(DataCritere[i]);
    if(DataCritere[i].idEnjeu==idEnjeu){
      containCritere.add(DataCritere[i]);
    }
  }
  return containCritere.map((critere) =>RowCritereNormatif(idEnjeu:critere.idEnjeu,idCritNormatif:critere.idCritere,CritNormatifTitle:critere.libelle,color: Colors.lightBlue,), ).toList();
}