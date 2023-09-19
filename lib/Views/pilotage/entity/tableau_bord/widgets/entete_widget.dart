import 'package:path/path.dart' as path;
import 'package:animated_custom_dropdown/custom_dropdown.dart';
import 'package:easy_container/easy_container.dart';
import 'package:excel_kit/excel_kit.dart';
import 'package:excel_kit/sheet.dart';
import 'package:filter_list/filter_list.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:go_router/go_router.dart';
import 'package:perfqse/Views/pilotage/entity/tableau_bord/widgets/processus.dart';
import 'package:selector_wheel/selector_wheel/models/selector_wheel_value.dart';
import 'package:selector_wheel/selector_wheel/selector_wheel.dart';
import 'package:stylish_dialog/stylish_dialog.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:iconsax/iconsax.dart';
import 'package:perfqse/Views/pilotage/entity/tableau_bord/widgets/utils_TB.dart';
import '../../../../../api/api_indicateur.dart';
import '../../../../../constants/colors.dart';
import '../../../../../helpers/helper_methods.dart';
import '../../../../../models/pilotage/axeModel.dart';
import '../../../../../models/pilotage/critereModel.dart';
import '../../../../../models/pilotage/enjeuModel.dart';
import '../../../../../widgets/customtext.dart';
import '../../../../../widgets/unimpleted_widget.dart';
import '../../../controllers/tableau_controller.dart';
import '../../widgets/get_info_espace.dart';
import 'data_table/row_axe.dart';
import 'data_table/row_critNormatif.dart';

class EnteteTableauBord extends StatefulWidget {
  const EnteteTableauBord({Key? key}) : super(key: key);

  @override
  State<EnteteTableauBord> createState() => _EntityWidgetWidgetState();
}

class _EntityWidgetWidgetState extends State<EnteteTableauBord> {
  String espace = InfoEspace().getNameEspace();
  int year = DateTime.now().year;
  String? selectedValueYear;
  String? selectedValueMonth;
  final ControllerTbQSE _controllerTbQSE=Get.find();
  final ApiTableau_Bord api_TB = ApiTableau_Bord();
  late TextEditingController mois_controller = TextEditingController();
  List<ProcessM>ProcessEntity=
  [
    ProcessM("ACHATS"),
    ProcessM("RH"),
    ProcessM("QSE"),
    ProcessM("MAINTENANCE"),
    ProcessM("LOG"),
    ProcessM("FABRICATION"),
    ProcessM("CONTROLE QUALITE"),
    ProcessM("CONDITIONNEMENT"),
  ];


void getAxe(){
  var id_axe=_controllerTbQSE.axeSelect.value;
  var name_axe=_controllerTbQSE.nameAxeSelect.value;
  RowAxe(idAxe: "${id_axe}",title: "${name_axe}",color: Colors.brown);
}

  void getCritInd()async {
    try {
      StylishDialog dialog1 = StylishDialog(
        context: context,
        alertType: StylishDialogType.PROGRESS,
        style: DefaultStyle(),
        controller: _controller,
        title: Text('Traitement...'),
      );
      //show stylish dialog
      await api_TB.getAxe();
      await api_TB.getEnjeu();
      await api_TB.getCritere();
      await api_TB.getIndicateur(reference: "Q",
          annee: _controllerTbQSE.dropdownAnnee.value,
          entity:espace);
      dialog1.show();
      await Future.delayed(Duration(seconds: 2));
      dialog1.dismiss();
      ScaffoldMessenger.of(context).showSnackBar(showSnackBar("Succès","Indicateurs Chargés avec succès",Colors.green));
    }on Exception catch (e) {
      final message = e.toString().split("Exception: ").join("");
      ScaffoldMessenger.of(context).showSnackBar(showSnackBar("Echec",message,Colors.red));
    }
  }

  void updateIndic()async{
    try{
      StylishDialog dialog1 = StylishDialog(
        context: context,
        alertType: StylishDialogType.PROGRESS,
        style: DefaultStyle(),
        controller: _controller,
        title: Text('Sauvegarde'),
      );
      //show stylish dialog
      dialog1.show();
      await Future.delayed(Duration(seconds: 2));
      dialog1.dismiss();
      await api_TB.updateIndicateur(reference:"Q", annee: _controllerTbQSE.dropdownAnnee.value, containIndic: containIndModifer,  );
    }on Exception catch (e){
      final message = e.toString().split("Exception: ").join("");
      await Future.delayed(Duration(seconds: 2));
      ScaffoldMessenger.of(context).showSnackBar(showSnackBar("Echec",message,Colors.red));
    }
  }
  DialogController _controller = DialogController(
    listener: (status) {
      if (status == DialogStatus.Showing) {
        debugPrint("Dialog is showing");
      } else if (status == DialogStatus.Changed) {
        debugPrint("Dialog type changed");
      } else if (status == DialogStatus.Dismissed) {
        debugPrint("Dialog dismissed");
      }
    },
  );


  @override
  void initState() {
    mois_controller=TextEditingController();
    super.initState();
  }
  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }
  List<String> tb_elem=[
    "Critères","Enjeux","Axes"
  ];
  List<CritereModel>? selectedCritereList = [];
  List<EnjeuModel>? selectedEnjeuList = [];
  List<AxeModel>? selectedAxeList = [];
  List<ProcessM>? selectedProcessList = [];

  List<EnjeuModel>DataEnj=DataEnjeu;
  List<CritereModel>DataCrit=DataCritere;
  List<AxeModel>DataAx=DataAxe;


  @override
  Widget build(BuildContext context) {
    void _openTabbedDialog(BuildContext context) {
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return TabbedDialog();
        },
      );
    }
    selectedValueYear="${year}";
    return  Container(
        alignment: Alignment.bottomRight,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text("Annee",style:TextStyle(
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                    fontSize: 18
                )),
                SizedBox(height:2,),
                EasyContainer(
                  onTap:(){
                    showDialog(
                      context:context,
                      builder:(BuildContext context){
                        return AlertDialog(
                          title:Text("Selectionner l'année"),
                          content:Container(
                            height: 170,
                            child: Column(
                              children: [
                                SizedBox(
                                  width:200,
                                  height: 150,
                                  child: SelectorWheel(
                                    width:double.infinity,
                                    childCount: 10,
                                    selectedItemIndex:1,
                                    convertIndexToValue: (int index) {
                                      return SelectorWheelValue(
                                        label: "${year-index}",
                                        value: year-index,
                                        index:year-index,
                                      );
                                    },
                                    onValueChanged: (SelectorWheelValue<int> value) {
                                      setState(() {
                                        _controllerTbQSE.dropdownAnnee_last.value="${value.value}";
                                      });
                                    },
                                  ),
                                ),

                              ],
                            ),
                          ),
                            actions:[
                              OutlinedButton(onPressed:(){
                                Navigator.pop(context);
                              }, child: Text("Annuler")),
                              OutlinedButton(onPressed:(){
                                setState(() {
                                  _controllerTbQSE.dropdownAnnee.value=_controllerTbQSE.dropdownAnnee_last.value;
                                  Navigator.of(context).pop();
                                  getCritInd();
                                });
                              }, child: Text("Sauvegarder"))
                            ]

                        );
                      }
                    );
                  },
                  mouseCursor: SystemMouseCursors.click,
                  width: 120,
                    height: 50,
                    showBorder:true,
                    color: Colors.white,
                    customBorderRadius:BorderRadius.circular(10),
                    child: Center(child: Obx(()=>Text("${ _controllerTbQSE.dropdownAnnee.value}",style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 18,
                      ),),
                    ))
                )
              ],
            ),
            const SizedBox(width: 10,),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text("Mois",style:TextStyle(
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                    fontSize: 18
                )),
                SizedBox(height: 3,),
                Container(
                  width: 120,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      border: Border.fromBorderSide(
                          BorderSide(
                              width: 1,
                              color: Colors.black
                          )
                      )
                  ),
                  child: CustomDropdown.search(
                    hintText: "Mois",
                    items:  ["Janvier","Février","Mars","Avril","Mai","Juin","Juillet","Aout","Septembre","Octobre","Novembre","Decembre"],
                    controller: mois_controller,
                  ),
                ),
              ],
            ),
            const SizedBox(width: 10,),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text("Filtre",style:TextStyle(
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                  fontSize: 18
                )),
                SizedBox(height: 3,),
                Row(
                  children: [
                    PopupMenuButton(
                      tooltip:"Filtrer",
                      icon: Icon(Icons.filter_alt),
                      iconSize:25,
                      shape: RoundedRectangleBorder(
                          side:BorderSide(
                            width:1,
                            color:Colors.black
                          )
                      ),
                      itemBuilder: (BuildContext context) {
                        return [
                          PopupMenuItem(
                              child: EasyContainer(
                                  onTap: (){
                                    _openAxeFilterDialog();
                                  },
                                  mouseCursor:SystemMouseCursors.click,width:100,height: 50,color:Colors.red, child:Text("Axes",style: TextStyle(color:Colors.white,fontSize: 15),)),
                          ),
                          PopupMenuItem(
                            child: EasyContainer(
                              onTap: (){
                                _openEnjeuFilterDialog();
                              },
                                mouseCursor:SystemMouseCursors.click,
                                width: 100,height: 50,color:Colors.red, child:Text("Enjeux",style: TextStyle(color:Colors.white,fontSize: 15),)),
                          ),
                          PopupMenuItem(
                            child: EasyContainer(
                                onTap: (){
                                  _openCritereFilterDialog();
                                },
                        mouseCursor:SystemMouseCursors.click,width: 100,height: 50,color:Colors.red, child:Text("Critéres",style: TextStyle(color:Colors.white,fontSize: 15),)),
                          ),
                          PopupMenuItem(
                            onTap: (){
                              _openProcessusFilterDialog();
                            },
                            mouseCursor:SystemMouseCursors.click,
                            child: EasyContainer(
                                onTap: (){
                                  _openProcessusFilterDialog();
                                },
                                mouseCursor:SystemMouseCursors.click,width: 100,height: 50,color:Colors.red, child:Text("Processus",style: TextStyle(color:Colors.white,fontSize: 15),)),
                          ),
                        ];
                      },
                    ),
                    IconButton(
                        tooltip:"Filtrer",
                        onPressed:(){
                          _openTabbedDialog(context);
                        },
                        icon: Icon(Icons.filter_alt,size: 25,)),
                    SizedBox(width:3,),
                    IconButton(
                        tooltip:"Désactiver les filtres",
                        onPressed:(){
                          setState(() {
                            selectedCritereList = [];
                            selectedEnjeuList = [];
                            selectedAxeList = [];
                          });
                        },
                        icon: Icon(Icons.filter_alt_off_rounded,size: 25,))
                  ],
                ),
            ],),
            Expanded(child: Container()),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: IconButton(
                  splashRadius: 20,padding: EdgeInsets.zero,
                  onPressed: () async{
                    setState(() {
                      _controllerTbQSE.dropdownMois.value=mois_controller.text;
                      // _tb_qse.dropdownAnnee.value=annee_controller.text;
                      //getCritere();
                      print(_controllerTbQSE.dropdownMois.value);
                      getAxe();

                    });
                  },
                  icon: const Icon(Iconsax.refresh,color: Color(0xFF4F80B5),)
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextButton.icon(
                  style: ButtonStyle(backgroundColor: MaterialStateProperty.all(Colors.blue)),
                  onPressed: () {
                   setState(() {

                   });
                  },
                  icon: const Icon(Iconsax.export,color: Colors.white,),
                  label: const CustomText(
                    text: "Exporter",
                    color: light,
                    size: 15,
                  )),
            ),
            InkWell(
              onTap: (){
                setState(() {
                  updateIndic();
                  getCritInd();
                  containIndModifer=[];
                });
              },
              child:Container(
                  padding: const EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    border: Border.all(width: 3.0),
                    borderRadius: const BorderRadius.all(Radius.circular(30.0)),
                  ),
                  child: const CustomText(
                    text: "Sauvegarder",
                    size: 13,
                    color: Colors.green,
                  )),
            )
            // Container(
            //     padding: const EdgeInsets.all(8),
            //     decoration: BoxDecoration(
            //       border: Border.all(width: 3.0),
            //       borderRadius: const BorderRadius.all(Radius.circular(30.0)),
            //     ),
            //     child: const CustomText(
            //       text: "Collecteur",
            //       size: 13,
            //       color: Colors.green,
            //     ))
          ],
        ),
      );
  }
  Future<void> _openCritereFilterDialog() async {
    await FilterListDialog.display<CritereModel>(
        context,
        hideSelectedTextCount: true,
        themeData: FilterListThemeData(
        context,
        choiceChipTheme: ChoiceChipThemeData.light(context),
    ),
    headlineText: 'Sélectionner Critères',
    width: 500,
    height: 500,
      routeSettings:RouteSettings(
        name: "/pilotage/espace/Trechville/tableau-de-bord/indicateurs",
      ),
    listData:DataCrit,
    selectedListData: selectedCritereList,
    choiceChipLabel: (item) => item!.libelle,
    validateSelectedItem: (list, val) => list!.contains(val),
    controlButtons: [ControlButtonType.All, ControlButtonType.Reset],
    onItemSearch: (critere, query) {
    /// When search query change in search bar then this method will be called
    ///
    /// Check if items contains query
    return critere.libelle!.toLowerCase().contains(query.toLowerCase());
    },

    onApplyButtonClick: (list) {
    setState(() {
    selectedCritereList = List.from(list!);
    });
    },

    );

  }

  Future<void> _openEnjeuFilterDialog() async {
    await FilterListDialog.display<EnjeuModel>(
      context,
      hideSelectedTextCount: true,
      themeData: FilterListThemeData(
        context,
        choiceChipTheme: ChoiceChipThemeData.light(context),
      ),
      headlineText: 'Sélectionner Enjeux',
      width: 450,
      height: 300,
      listData:DataEnj,
      selectedListData: selectedEnjeuList,
      choiceChipLabel: (item) => item!.libelle,
      validateSelectedItem: (list, val) => list!.contains(val),
      controlButtons: [ControlButtonType.All, ControlButtonType.Reset],
      onItemSearch: (enjeu, query) {
        /// When search query change in search bar then this method will be called
        ///
        /// Check if items contains query
        return enjeu.libelle!.toLowerCase().contains(query.toLowerCase());
      },

      onApplyButtonClick: (list) {
        setState(() {
          selectedEnjeuList = List.from(list!);
        });
      },

    );

  }


  Future<void> _openProcessusFilterDialog() async {
    await FilterListDialog.display<ProcessM>(
      context,
      hideSelectedTextCount: true,
      themeData: FilterListThemeData(
        context,
        choiceChipTheme: ChoiceChipThemeData.light(context),
      ),
      headlineText: 'Sélectionner Processus',
      width: 300,
      height: 400,
      listData:ProcessEntity,
      selectedListData:selectedProcessList,
      choiceChipLabel: (item) => item!.lib,
      validateSelectedItem: (list, val) => list!.contains(val),
      controlButtons: [ControlButtonType.All, ControlButtonType.Reset],
      onItemSearch: (pc, query) {
        /// When search query change in search bar then this method will be called
        ///
        /// Check if items contains query
        return pc.lib!.toLowerCase().contains(query.toLowerCase());
      },

      onApplyButtonClick: (list) {
        setState(() {
          selectedProcessList = List.from(list!);
        });
      },

    );

  }

  Future<void> _openAxeFilterDialog() async {
    await FilterListDialog.display<AxeModel>(
      context,
      hideSelectedTextCount: true,
      themeData: FilterListThemeData(
        context,
        choiceChipTheme: ChoiceChipThemeData.light(context),
      ),
      headlineText: 'Sélectionner Axes',
      width: 250,
      height: 300,
      listData:DataAx,
      selectedListData: selectedAxeList,
      choiceChipLabel: (item) => item!.libelle,
      validateSelectedItem: (list, val) => list!.contains(val),
      controlButtons: [ControlButtonType.All, ControlButtonType.Reset],
      onItemSearch: (axe, query) {
        /// When search query change in search bar then this method will be called
        ///
        /// Check if items contains query
        return axe.libelle!.toLowerCase().contains(query.toLowerCase());
      },

      onApplyButtonClick: (list) {
        setState(() {
          selectedAxeList = List.from(list!);
        });
        context.go("/pilotage/espace/Trechville/tableau-de-bord/indicateurs");
      },
    );

  }

  }


class TabbedDialog extends StatefulWidget {
  @override
  _TabbedDialogState createState() => _TabbedDialogState();
}

class _TabbedDialogState extends State<TabbedDialog> with SingleTickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text('Tabbed Dialog'),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          TabBar(
            controller: _tabController,
            tabs: [
              Tab(text: 'Tab 1'),
              Tab(text: 'Tab 2'),
            ],
          ),
          SizedBox(height: 20),
          Container(
            width: 500,
            height: 400,
            child: TabBarView(
              controller: _tabController,
              children: [
                Center(child: Text('Content of Tab 1')),
                Center(child: Text('Content of Tab 2')),
              ],
            ),
          ),
        ],
      ),
      actions: [
        ElevatedButton(
          onPressed: () {
            Navigator.of(context).pop();
          },
          child: Text('Close'),
        ),
      ],
    );
  }
}

