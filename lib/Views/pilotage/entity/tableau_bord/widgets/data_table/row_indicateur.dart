import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:perfqse/Views/pilotage/entity/tableau_bord/widgets/data_table/row_critNormatif.dart';
import '../../../../../../models/pilotage/indicateur_model.dart';
import '../../../../controllers/tableau_controller.dart';
import '../utils_TB.dart';
import 'dashboard_utils.dart';

class RowIndicateur extends StatefulWidget {
  final IndicateurModel indicateur;
  final String mois;
  const RowIndicateur({Key? key, required this.indicateur, required this.mois})
      : super(key: key);

  @override
  State<RowIndicateur> createState() => _RowIndicateurState();
}

class _RowIndicateurState extends State<RowIndicateur> {
  bool isHovering = false;
  final ControllerTbQSE _controllerTbQSE=Get.find();
  bool? dataMoisValidation;
  bool? dataAnneeValidation;
  String? dataAnneeValue="";


  void calculeRealise(){
    for (int i=0;i<containIndicateur.length;i++) {
      if (containIndicateur[i].idIndicateur == widget.indicateur.idIndicateur && widget.indicateur.type=="Primaire" ) {
        int calculeRealisee = 0;
        if (containIndicateur[i].janvier.isValidate == 1)
          calculeRealisee += containIndicateur[i].janvier.value!;
        if (containIndicateur[i].fevrier.isValidate == 1)
          calculeRealisee += containIndicateur[i].fevrier.value!;
        if (containIndicateur[i].mars.isValidate == 1)
          calculeRealisee += containIndicateur[i].mars.value!;
        if (containIndicateur[i].avril.isValidate == 1)
          calculeRealisee += containIndicateur[i].avril.value!;
        if (containIndicateur[i].mai.isValidate == 1)
          calculeRealisee += containIndicateur[i].mai.value!;
        if (containIndicateur[i].juin.isValidate == 1)
          calculeRealisee += containIndicateur[i].juin.value!;
        if (containIndicateur[i].juillet.isValidate == 1)
          calculeRealisee += containIndicateur[i].juillet.value!;
        if (containIndicateur[i].aout.isValidate == 1)
          calculeRealisee += containIndicateur[i].aout.value!;
        if (containIndicateur[i].septembre.isValidate == 1)
          calculeRealisee += containIndicateur[i].septembre.value!;
        if (containIndicateur[i].octobre.isValidate == 1)
          calculeRealisee += containIndicateur[i].octobre.value!;
        if (containIndicateur[i].novembre.isValidate == 1)
          calculeRealisee += containIndicateur[i].novembre.value!;
        if (containIndicateur[i].decembre.isValidate == 1)
          calculeRealisee += containIndicateur[i].decembre.value!;
        containIndicateur[i].realisee.value = calculeRealisee;
        containIndModifer.add(containIndicateur[i]);
      }
    }
  }

 void initialisation(){
   dataAnneeValidation = widget.indicateur.realisee.isValidate==1?true:false;
   for (int i=0;i<containIndicateur.length;i++){
     if(containIndicateur[i].idIndicateur==widget.indicateur.idIndicateur){
       switch(widget.mois){
         case "Janvier":
           dataMoisValidation=containIndicateur[i].janvier.isValidate==1?true:false;
         case "Février":
           dataMoisValidation=containIndicateur[i].fevrier.isValidate==1?true:false;
         case "Mars":
           dataMoisValidation=containIndicateur[i].mars.isValidate==1?true:false;
         case "Avril":
           dataMoisValidation=containIndicateur[i].avril.isValidate==1?true:false;
         case "Mai":
           dataMoisValidation=containIndicateur[i].mai.isValidate==1?true:false;
         case "Juin":
           dataMoisValidation=containIndicateur[i].juin.isValidate==1?true:false;
         case "Juillet":
           dataMoisValidation=containIndicateur[i].juillet.isValidate==1?true:false;
         case "Aout":
           dataMoisValidation=containIndicateur[i].aout.isValidate==1?true:false;
         case "Septembre":
           dataMoisValidation=containIndicateur[i].septembre.isValidate==1?true:false;
         case "Octobre":
           dataMoisValidation=containIndicateur[i].octobre.isValidate==1?true:false;
         case "Novembre":
           dataMoisValidation=containIndicateur[i].novembre.isValidate==1?true:false;
         case "Decembre":
           dataMoisValidation=containIndicateur[i].decembre.isValidate==1?true:false;
       }
     }
   }

 }

 @override
  void initState() {
   initialisation();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {

    return InkWell(
      mouseCursor: SystemMouseCursors.basic,
      onTap: () {},
      onHover: (value) {
        setState(() {
          isHovering = value;
        });
      },
      child: Material(
        elevation: isHovering ? 10 : 0,
        child: Container(
          padding: const EdgeInsets.only(left: 2.0),
          decoration: BoxDecoration(
            border: isHovering ? Border.all(color: Colors.black, width: 1.0) : null,
            color: widget.indicateur.type != "Primaire" ? Color(0xFFFDDDCC) : Colors.transparent,
          ),
          height: 40,
          child: Row(
            children: [
              // Réf
              Container(
                height: 40,
                width: 50,
                alignment: Alignment.centerLeft,
                color: Colors.transparent,
                child: Row(
                  children: [
                    if (isHovering)
                      const Icon(
                        Icons.mouse,
                        size: 12,
                      ),
                    if (isHovering)
                      const SizedBox(
                        width: 2,
                      ),
                    Text(
                      "#${widget.indicateur.idIndicateur} ",//${widget.indicateur.reference}",
                      style: const TextStyle(fontSize: 12), 
                    ),
                  ],
                ),
              ),
              // Intitule
              Expanded(child: Container(
                height: 40,
                width: 450,
                color: Colors.transparent,
                alignment: Alignment.centerLeft,
                child: Text(
                  "${widget.indicateur.intitule}",
                  style: const TextStyle(fontWeight: FontWeight.bold,fontSize: 13),
                  overflow: TextOverflow.ellipsis,
                  maxLines: 3,
                ),
              ),),
              //definition
              Container(
                height: 40,
                width: 60,
                color: Colors.transparent,
                alignment: Alignment.center,
                child:IconButton(
                  onPressed: () async {
                      showDialog(
                        context: context,
                        builder: (BuildContext context) {
                          return AlertDialog(
                            title: Text('${widget.indicateur.intitule}',style: TextStyle(color: Colors.black),),
                            content: SingleChildScrollView(
                              child: Center(
                                child: Column(
                                  children: <Widget>[
                                    Text('${widget.indicateur.definition}',maxLines:12,style: TextStyle(
                                      color: Colors.black,
                                    ),),
                                  ],
                                ),
                              ),
                            ),
                            actionsAlignment: MainAxisAlignment.center,
                            actions: <Widget>[
                              OutlinedButton(
                                onPressed: () {
                                  Navigator.pop(context);
                                },
                                child: Text('OK'),
                              ),
                            ],
                          );
                        },);
                    },
                  icon: Icon(Icons.receipt_long,size:18,color: Colors.black,),
                )
              ),
              //type
              Container(
                height: 40,
                width: 80,
                color: Colors.transparent,
                alignment: Alignment.center,
                child: Text(
                  "${widget.indicateur.type}",
                  style: const TextStyle(fontWeight: FontWeight.bold,fontSize: 13),
                  overflow: TextOverflow.ellipsis,
                  maxLines: 3,
                ),
              ),
              //unite
              Container(
                height: 40,
                width: 70,
                color: Colors.transparent,
                alignment: Alignment.center,
                child: Text(
                  "${widget.indicateur.unite}",
                  style: const TextStyle(fontWeight: FontWeight.bold,fontSize: 13),
                  overflow: TextOverflow.ellipsis,
                  maxLines: 3,
                ),
              ),
              // Processus
              InkWell(
                onTap:()async {
                  showDialog(
                    context: context,
                    builder: (BuildContext context) {
                      return AlertDialog(
                        icon:Icon(Icons.bookmark_add),
                        title: Text(widget.indicateur.intitule,overflow: TextOverflow.ellipsis,style: TextStyle(color: Colors.black),),
                        content: SingleChildScrollView(
                          child: Center(
                            child: Column(
                              children:List.generate(widget.indicateur.processus.length,
                                      (index) =>Text("${widget.indicateur.processus[index]}",
                                          style: const TextStyle(fontStyle: FontStyle.italic,fontSize: 17)) ),
                            ),
                          ),
                        ),
                        actionsAlignment: MainAxisAlignment.center,
                        actions: <Widget>[
                          OutlinedButton(
                            onPressed: () {
                              Navigator.pop(context);
                            },
                            child: Text('OK'),
                          ),
                        ],
                      );
                    },);
                },
                child: Container(
                  height: 40,
                  width: 50,
                  color: Colors.transparent,
                  alignment: Alignment.center,
                  child:Text(widget.indicateur.processus.length>1?"${widget.indicateur.processus[0]}...":widget.indicateur.processus[0],
                      style: const TextStyle(fontStyle: FontStyle.italic,fontSize: 12,overflow:TextOverflow.ellipsis)),
                ),
              ),
              // Réalise Annuel
              Container(
                  height: 40,
                  width: 220,
                  color: Colors.transparent,
                  alignment: Alignment.center,
                  child: buildRealiseAnColumn(
                       widget.indicateur.realisee.value//widget.indicateur as num?
                  )),
              // Réalise Mois
              Container(
                height: 40,
                width: 140,
                color: Colors.transparent,
                alignment: Alignment.center,
                child: buildRealiseMoisColumn(context,
                  widget.mois=="Janvier"?
                  widget.indicateur.janvier.value:
                  widget.mois=="Février"?
                  widget.indicateur.fevrier.value:
                  widget.mois=="Mars"?
                  widget.indicateur.mars.value:
                  widget.mois=="Avril"?
                  widget.indicateur.avril.value:
                  widget.mois=="Mai"?
                  widget.indicateur.mai.value:
                  widget.mois=="Juin"?
                  widget.indicateur.juin.value:
                  widget.mois=="Juillet"?
                  widget.indicateur.juillet.value:
                  widget.mois=="Aout"?
                  widget.indicateur.aout.value:
                  widget.mois=="Septembre"?
                  widget.indicateur.septembre.value:
                  widget.mois=="Octobre"?
                  widget.indicateur.octobre.value:
                  widget.mois=="Novembre"?
                  widget.indicateur.novembre.value:
                  widget.mois=="Decembre"?
                  widget.indicateur.decembre.value:0,

                  widget.mois=="Janvier"?
                  dataMoisValidation=widget.indicateur.janvier.isValidate==1?true:false:
                  widget.mois== "Février"?
                  dataMoisValidation=widget.indicateur.fevrier.isValidate==1?true:false:
                  widget.mois== "Mars"?
                  dataMoisValidation=widget.indicateur.mars.isValidate==1?true:false:
                  widget.mois== "Avril"?
                  dataMoisValidation=widget.indicateur.avril.isValidate==1?true:false:
                  widget.mois== "Mai"?
                  dataMoisValidation=widget.indicateur.mai.isValidate==1?true:false:
                  widget.mois== "Juin"?
                  dataMoisValidation=widget.indicateur.juin.isValidate==1?true:false:
                  widget.mois== "Juillet"?
                  dataMoisValidation=widget.indicateur.juillet.isValidate==1?true:false:
                  widget.mois== "Aout"?
                  dataMoisValidation=widget.indicateur.aout.isValidate==1?true:false:
                  widget.mois== "Septembre"?
                  dataMoisValidation=widget.indicateur.septembre.isValidate==1?true:false:
                  widget.mois== "Octobre"?
                  dataMoisValidation=widget.indicateur.octobre.isValidate==1?true:false:
                  widget.mois== "Novembre"?
                  dataMoisValidation=widget.indicateur.novembre.isValidate==1?true:false:
                  widget.mois== "Decembre"?
                  dataMoisValidation=widget.indicateur.decembre.isValidate==1?true:false:false

                )),
              //cible
              Container(
                height: 40,
                width: 120,
                color: Colors.transparent,
                alignment: Alignment.center,
                child: const Text("XXXX",
                    style: TextStyle(color: Colors.blueAccent)),
              ),
              //ecart
              Container(
                height: 40,
                width: 80,
                color: Colors.transparent,
                alignment: Alignment.center,
                child: const Text("+XX %", style: TextStyle(color: Colors.green)),
              ),
              //const SizedBox(width: 10,),
              //const Center(child: Icon(Icons.more_vert_sharp))
            ],
          ),
        ),
      ),
    );
  }

  Widget buildRealiseAnColumn(num? data) {
    return  Row(
        children: [
          Container(
            height: 40,
            width: 100,
            alignment: Alignment.center,
            child: Row(
              children: [
                Text(data ==null ?"": "${data} ",
                  textAlign: TextAlign.center,
                  overflow: TextOverflow.ellipsis,
                  maxLines: 1,
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
                Text(
                  "(${widget.indicateur.unite!})",
                  style: TextStyle(fontStyle: FontStyle.italic,fontSize: 12),
                )
              ],
            ),
          ),
          SizedBox(width:2,),
          Checkbox(checkColor: Colors.white,fillColor: dataAnneeValidation == true ? MaterialStateProperty.all(Colors.green) : null,
          onChanged: (bool? value){
            for (int i=0;i<containIndicateur.length;i++){
            if(containIndicateur[i].idIndicateur==widget.indicateur.idIndicateur){
              containIndicateur[i].realisee.isValidate= value! ? 1:0;
              containIndModifer.add(containIndicateur[i]);
              dataAnneeValidation=containIndicateur[i].realisee.isValidate==1?true:false;
            }
            }
          }, value: dataAnneeValidation,),
          SizedBox(width:10,),
          Container(height: 35,color: Colors.grey,width: 2,)
        ],
      );
  }

  Widget buildRealiseMoisColumn(BuildContext context,num? data,bool? dataMoisValidation) {
    List<Icon> icons = [
      const Icon(
        Icons.verified,
        color: Colors.green,
      ),
      const Icon(
        Icons.circle,
        color: Colors.yellow,
      ),
      const Icon(
        Icons.circle,
        color: Colors.red,
      ),
    ];

    final num? dataValue = data;
    final estConsolide = false;

    return Row(
        children: [
          Container(width:30,height: 40,alignment: Alignment.center,child: Text("${dataValue ?? " -- "}")),
          Container(width: 30,height: 40,alignment: Alignment.center,
            child: (widget.indicateur.type == "Primaire" && dataMoisValidation != true) ? IconButton(splashRadius: 20,splashColor: Colors.amber,
            onPressed: () {
              renseignerLaDonnee(context,widget.indicateur,dataValue,"${_controllerTbQSE.dropdownMois.value}");
            },icon: const Icon(Icons.edit, size: 12,)):null
          ),
          Container(width: 30,height: 40,alignment: Alignment.center,
            child:  Padding(padding: const EdgeInsets.only(right: 2.0, left: 2.0),
              child: Checkbox(checkColor: Colors.white,fillColor: dataMoisValidation == true ? MaterialStateProperty.all(Colors.green) : null,
                onChanged: (bool? value){
                for (int i=0;i<containIndicateur.length;i++){
                  if(containIndicateur[i].idIndicateur==widget.indicateur.idIndicateur){
                    switch(widget.mois){
                      case "Janvier":
                        containIndicateur[i].janvier.isValidate= value! ? 1 : 0;
                        dataMoisValidation=containIndicateur[i].janvier.isValidate==1?true:false;
                        containIndModifer.add(containIndicateur[i]);
                      case "Février":
                        containIndicateur[i].fevrier.isValidate=value! ? 1 : 0;
                        dataMoisValidation=containIndicateur[i].fevrier.isValidate==1?true:false;
                        containIndModifer.add(containIndicateur[i]);
                      case "Mars":
                        containIndicateur[i].mars.isValidate=value! ? 1 : 0;
                        dataMoisValidation=containIndicateur[i].mars.isValidate==1?true:false;
                        containIndModifer.add(containIndicateur[i]);
                      case "Avril":
                        containIndicateur[i].avril.isValidate=value! ? 1 : 0;
                        dataMoisValidation=containIndicateur[i].avril.isValidate==1?true:false;
                        containIndModifer.add(containIndicateur[i]);
                      case "Mai":
                        containIndicateur[i].mai.isValidate=value! ? 1 : 0;
                        dataMoisValidation=containIndicateur[i].mai.isValidate==1?true:false;
                        containIndModifer.add(containIndicateur[i]);
                      case "Juin":
                        containIndicateur[i].juin.isValidate=value! ? 1 : 0;
                        dataMoisValidation=containIndicateur[i].juin.isValidate==1?true:false;
                        containIndModifer.add(containIndicateur[i]);
                      case "Juillet":
                        containIndicateur[i].juillet.isValidate=value! ? 1 : 0;
                        dataMoisValidation=containIndicateur[i].juillet.isValidate==1?true:false;
                        containIndModifer.add(containIndicateur[i]);
                      case "Aout":
                        containIndicateur[i].aout.isValidate=value! ? 1 : 0;
                        dataMoisValidation=containIndicateur[i].aout.isValidate==1?true:false;
                        containIndModifer.add(containIndicateur[i]);
                      case "Septembre":
                        containIndicateur[i].septembre.isValidate=value! ? 1 : 0;
                        dataMoisValidation=containIndicateur[i].septembre.isValidate==1?true:false;
                        containIndModifer.add(containIndicateur[i]);
                      case "Octobre":
                        containIndicateur[i].octobre.isValidate=value! ? 1 : 0;
                        dataMoisValidation=containIndicateur[i].octobre.isValidate==1?true:false;
                        containIndModifer.add(containIndicateur[i]);
                      case "Novembre":
                        containIndicateur[i].novembre.isValidate=value! ? 1 : 0;
                        dataMoisValidation=containIndicateur[i].novembre.isValidate==1?true:false;
                        containIndModifer.add(containIndicateur[i]);
                      case "Decembre":
                        containIndicateur[i].decembre.isValidate=value! ? 1 : 0;
                        dataMoisValidation=containIndicateur[i].decembre.isValidate==1?true:false;
                        containIndModifer.add(containIndicateur[i]);
                    }
                  }
                }
                calculeRealise();
                },
                value: dataMoisValidation,
              ),
            )
          ),
          Container(width:10,height: 40,alignment: Alignment.center,
            child: dataMoisValidation != true ? dataValue == null ? icons[2] : icons[1] : icons[0],
          ),
          SizedBox(width: 20,),
          Container(height: 35,color: Colors.grey,width: 2,)
        ],
      );
  }


  String getIdDoc(String idIndicateur) {
    return idIndicateur;
  }

  Future validateDataIndicator(bool? value, int numeroIndicateur) async {}

  Future<bool> renseignerLaDonnee(BuildContext context,IndicateurModel indicator, num? value, String? mois) async {
    if (indicator.intitule != null && mois != null) {
      DashBoardUtils.editDataRow(context,indicator, value, mois);
      return true;
    }
    return false;
  }

  Future<void> _showDefinition({@required context}) async {
    return showDialog<void>(
      context: context,
      barrierDismissible: true, // user must tap button!
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('${widget.indicateur.intitule}',style: TextStyle(color: Colors.black),),
          content: SingleChildScrollView(
            child: ListBody(
              children: <Widget>[
                Text('${widget.indicateur.definition}',maxLines:12,style: TextStyle(
                  color: Colors.black,
                ),),
              ],
            ),
          ),
        );
      },
    );
  }


  Future<void> _showProcessus({@required context}) async {
    return showDialog<void>(
      context: context,
      barrierDismissible: true, // user must tap button!
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Processus : ${widget.indicateur.intitule}',style: TextStyle(color: Colors.black),),
          content: SingleChildScrollView(
            child: Column(
              children: List.generate(widget.indicateur.processus.length, (index){
                return Text("${widget.indicateur.processus[index]}",style: TextStyle(
                  color: Colors.black,
                  backgroundColor: Colors.grey,
                  fontSize: 17,
                  fontWeight: FontWeight.bold,
                  fontStyle: FontStyle.italic
                ),);
              }),
            )
          ),
        );
      },
    );
  }
}
