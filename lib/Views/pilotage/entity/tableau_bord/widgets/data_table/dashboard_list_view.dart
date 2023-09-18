import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../../controllers/tableau_controller.dart';
import 'row_axe.dart';

class DashBoardListView extends StatefulWidget {
  const DashBoardListView({Key? key}) : super(key: key);

  @override
  State<DashBoardListView> createState() => _DashBoardListViewState();
}

class _DashBoardListViewState extends State<DashBoardListView> {
  late ScrollController _scrollController;
  final ControllerTbQSE _controllerTbQSE=Get.find();


  @override
  void initState() {
    super.initState();
    _scrollController = ScrollController();
  }

  @override
  Widget build(BuildContext context) {
      return Theme(
        data: Theme.of(context).copyWith(scrollbarTheme: ScrollbarThemeData(
          trackColor:  MaterialStateProperty.all(Colors.black12),
          trackBorderColor: MaterialStateProperty.all(Colors.black38),
          thumbColor: MaterialStateProperty.all(Colors.black),
          interactive: true,
        )),
        child: Scrollbar(
          controller: _scrollController,
          thumbVisibility: true,
          thickness: 8,
          child: ScrollConfiguration(
            behavior: ScrollConfiguration.of(context).copyWith(scrollbars: true),
            child: SingleChildScrollView(
              controller: _scrollController,
              physics: const BouncingScrollPhysics(),
              child: Container(
                //padding: const EdgeInsets.only(right: 10.0),
                child: Column(
                  children: [
                    Obx(() {
                      var id_axe=_controllerTbQSE.axeSelect.value;
                      var name_axe=_controllerTbQSE.nameAxeSelect.value;
                      return  RowAxe(idAxe: "${id_axe}",title: "${name_axe}",color: Colors.brown);
                    }
                    )
                  ],
                ),
              ),
            ),
          ),
        ),
      );
    //});
  }
}
