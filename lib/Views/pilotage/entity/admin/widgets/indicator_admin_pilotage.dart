import 'package:data_table_2/data_table_2.dart';
import 'package:flutter/material.dart';

import '../../../../../module/styled_scrollview.dart';

class IndicatorAdmin extends StatefulWidget {
  const IndicatorAdmin({Key? key}) : super(key: key);

  @override
  State<IndicatorAdmin> createState() => _IndicatorAdminState();
}

class _IndicatorAdminState extends State<IndicatorAdmin> {
  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      body: Padding(
        padding: const EdgeInsets.only(top: 8.0, bottom: 8.0),
        child: ClipRRect(
          borderRadius: const BorderRadius.only(topRight: Radius.circular(10),topLeft:Radius.circular(10)),
          child: StyledScrollView(
            axis: Axis.horizontal,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  height: 600,
                  width: 1500,
                  color: Colors.transparent,
                  child: DataTable2(
                    headingRowColor: MaterialStateColor.resolveWith((states) => Color(0xFFF5B907)),
                    headingTextStyle: const TextStyle(
                      fontSize: 15,
                      color: Colors.black,
                    ),
                    headingRowHeight: 40,
                    columnSpacing: 0,
                    dividerThickness: 2,
                    columns: const [
                      DataColumn(label: Text("Réf")),
                      DataColumn(label: Text("Inititulé")),
                      DataColumn2(label: Text("Type"),size: ColumnSize.S),
                      DataColumn2(label: Text("Unité"),size: ColumnSize.S),
                      DataColumn(label: Text("Processus")),
                      DataColumn(label: Text("Enjeux")),
                      DataColumn(label: Text("Pilier")),
                      DataColumn2(label: Text("ODD"),size: ColumnSize.S),
                      DataColumn2(label: Text("GRI"),size: ColumnSize.S),
                      DataColumn(label: Text("Mode de calcul")),
                      DataColumn(label: Text("Fréquence de collecte")),
                    ],
                    rows: [],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
      backgroundColor: Colors.transparent,
    );
  }
}
