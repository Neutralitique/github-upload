import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';
import 'package:perfqse/Views/pilotage/entity/tableau_bord/widgets/data_table/row_enjeu.dart';
import '../../../../../../models/pilotage/enjeuModel.dart';
import '../../../../controllers/tableau_controller.dart';
import '../utils_TB.dart';
import '/models/pilotage/indicateur_model.dart';
import 'row_critNormatif.dart';
import 'row_indicateur.dart';

class RowAxe extends StatefulWidget {
  final String idAxe;
  final String title;
  final Color color;
  const RowAxe({Key? key, required this.title, required this.color, required this.idAxe}) : super(key: key);

  @override
  State<RowAxe> createState() => _RowAxeState();
}

class _RowAxeState extends State<RowAxe> {
  final ControllerTbQSE _controllerTbQSE=Get.find();

  bool _press=false;
  var listIconData = {
   "axe1":Icons.manage_accounts, "axe2":Icons.money,
    "axe3":Iconsax.people, "axe4":Iconsax.tree,
  };



  @override
  Widget build(BuildContext context) {
    return Card(
        elevation: 5,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              padding: EdgeInsets.zero,
              decoration: BoxDecoration(
                color:Colors.transparent,
                border: Border.all(color: widget.color,width: 2.0),
                borderRadius: const BorderRadius.only(topLeft: Radius.circular(4.0),topRight: Radius.circular(4.0)),
              ),
              child: Padding(
                padding: const EdgeInsets.only(top: 4,bottom: 4,right: 14,left: 20),
                child: Row(
                  children: [
                    Icon(listIconData[widget.idAxe],color: widget.color,size: 24,),
                    SizedBox(width: 20,),
                    Text(widget.title,style: TextStyle(color: widget.color,fontSize: 16,fontWeight: FontWeight.bold),),
                    Expanded(child: Container()),
                    RotatedBox(
                      quarterTurns: _press ? 1:3,
                      child: IconButton(
                        icon: const Icon(Icons.arrow_back_ios_sharp,color: Colors.black,),
                        splashRadius: 20,
                        onPressed: (){
                          setState(() {
                            _press=!_press;
                          });
                        },
                      ),
                    )
                  ],
                ),
              ),
            ),
            Visibility(
              visible: _press,//widget.dropDownState["value"],
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: getAxeSubWidget(widget.idAxe,_controllerTbQSE.enjeuSelect.value)
              ),
            )
          ],
        )
    );
  }



  // List<Widget> getAxeSubWidget(String idAxe,String Enjeu  ){
  //   List<EnjeuModel> containEnjeu=[];
  //     for (int i = 0; i < DataEnjeu.length; i++) {
  //       if (DataEnjeu[i].idAxe == idAxe) {
  //         if (Enjeu!=""){
  //           containEnjeu.add(DataEnjeu[i]);
  //           break;
  //         }
  //         else{
  //           containEnjeu.add(DataEnjeu[i]);
  //         }
  //       }
  //     }
  //     return containEnjeu.map((enjeu) =>
  //         RowEnjeu(numero: "${enjeu.idEnjeu.substring(4, 5)}",
  //           idAxe: enjeu.idAxe,
  //           idEnjeu: enjeu.idEnjeu,
  //           EnjeuTitle: enjeu.libelle,
  //           color: widget.color,)).toList();
  // }

  List<Widget> getAxeSubWidget(String idAxe,String enjeu ){
    Map<String,dynamic> nameEnjeu={
      "enjeu1":"Contexte du SMQSE",
      "enjeu2":"Leadership et engagement de la direction",
      "enjeu3":"Management du QSE",
      "enjeu4":"Maitrise des impacts et des effets indesirables",
      "enjeu5":"Ressources",
      "enjeu6":"Planification",
      "enjeu7":"Conception et Modifiaction",
      "enjeu8":"Realisation , Liberation des produits et externalisation",
      "enjeu9":"Efficacite et Conformite du SMQSE",
      "enjeu10":"",
    };
    switch(idAxe){
      // case "pilier0" :
      //   return getIndicateurWidgetGeneral();
      case "axe1" :
        if(enjeu!=""){
          return [
          RowEnjeu(numero:"1",idAxe: widget.idAxe,idEnjeu:enjeu,EnjeuTitle:nameEnjeu[enjeu],color: widget.color,)
    ];
    }
        return [
          SizedBox(height: 1,),
          RowEnjeu(numero:"${"enjeu1".substring(5, 6)}",idAxe: widget.idAxe,idEnjeu: "enjeu1",EnjeuTitle: "Contexte du SMQSE",color: widget.color,),
          SizedBox(height: 1,),
          RowEnjeu(numero:"${"enjeu2".substring(5, 6)}",idAxe: widget.idAxe,idEnjeu: "enjeu2",EnjeuTitle: "Leadership et engagement de la direction",color: widget.color,),
        ];
      case "axe2" :
        if(enjeu!=""){
          return [
            RowEnjeu(numero:"1",idAxe: widget.idAxe,idEnjeu:enjeu,EnjeuTitle:nameEnjeu[enjeu],color: widget.color,)
          ];
        }
        return [
          SizedBox(height: 1,),
          RowEnjeu(numero:"${"enjeu3".substring(5, 6)}",idAxe: widget.idAxe,idEnjeu: "enjeu3",EnjeuTitle: "Management du QSE",color: widget.color,),
          SizedBox(height: 1,),
          RowEnjeu(numero:"${"enjeu4".substring(5, 6)}",idAxe: widget.idAxe,idEnjeu: "enjeu4",EnjeuTitle: "Maitrise des impacts et effets indesirables",color: widget.color,),
          SizedBox(height: 1,),
          RowEnjeu(numero:"${"enjeu5".substring(5, 6)}",idAxe: widget.idAxe,idEnjeu: "enjeu5",EnjeuTitle: "Ressource",color: widget.color,),
          SizedBox(height: 1,),
          RowEnjeu(numero:"${"enjeu6".substring(5, 6)}",idAxe: widget.idAxe,idEnjeu: "enjeu6",EnjeuTitle: "Planification",color: widget.color,),
          SizedBox(height: 1,),
          RowEnjeu(numero:"${"enjeu7".substring(5, 6)}",idAxe: widget.idAxe,idEnjeu: "enjeu7",EnjeuTitle: "Conception et modification",color: widget.color,),
          SizedBox(height: 1,),
          RowEnjeu(numero:"${"enjeu8".substring(5, 6)}",idAxe: widget.idAxe,idEnjeu: "enjeu8",EnjeuTitle: "Realisation,liberation des produits et externalisation",color: widget.color,),
        ];
      case "axe3" :
        if(enjeu!=""){
          return [
            RowEnjeu(numero:"1",idAxe: widget.idAxe,idEnjeu:enjeu,EnjeuTitle:nameEnjeu[enjeu],color: widget.color,)
          ];
        }
        return [
          SizedBox(height: 1,),
          RowEnjeu(numero:"${"enjeu9".substring(5, 6)}",idAxe: widget.idAxe,idEnjeu: "enjeu9",EnjeuTitle: "Efficacite et Conformite du SMQSE",color: widget.color,),
        ];
      case "axe4" :
        return [];
      default:
        return [
          Text("default"),
        ];
    }
  }



}
