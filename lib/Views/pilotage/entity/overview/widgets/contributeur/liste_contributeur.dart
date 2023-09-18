import 'package:data_table_2/data_table_2.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_svg/svg.dart';
import '../../../../../../constants/colors.dart';
import '../../../../../../helpers/responsive.dart';
import 'contributeur_model.dart';

class ListeContributeur extends StatefulWidget {
  const ListeContributeur({
    Key? key,
  }) : super(key: key);

  @override
  State<ListeContributeur> createState() => _ListeContributeurState();
}

class _ListeContributeurState extends State<ListeContributeur> {

  late ScrollController _scrollController;
  bool _showFab = true;


  void _handleScroll() {
    if (_scrollController.position.userScrollDirection==ScrollDirection.reverse ||_scrollController.position.physics == ScrollDirection.reverse) {
      setState(() {
        _showFab = false;
      });
    }
    if (_scrollController.position.userScrollDirection == ScrollDirection.forward||_scrollController.position.physics == ScrollDirection.forward) {
      setState(() {
        _showFab = true;
      });
    }
  }

  @override
  void dispose() {
    _scrollController.removeListener(_handleScroll);
    _scrollController.dispose();
    super.dispose();
  }



  @override
  void initState() {
    super.initState();
    _scrollController = ScrollController();
    _scrollController.addListener(_handleScroll);
  }

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Container(
        width: double.infinity,
        height: 800,
        //padding:  EdgeInsets.all(defaultPadding),
        decoration: const BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.all(Radius.circular(10)),
        ),
        child: SingleChildScrollView(
          controller: _scrollController,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: 12,),
              Row(
                children: [
                  const SizedBox(width: 20,),
                  Text(
                    "Liste des contributeurs",
                    style: Theme.of(context).textTheme.titleMedium,
                  ),
                  Spacer(flex: 6,),
                  ElevatedButton.icon(
                    style: TextButton.styleFrom(
                      backgroundColor: Colors.red,
                      padding: EdgeInsets.symmetric(
                        horizontal: defaultPadding * 1.5,
                        vertical:
                        defaultPadding / (Responsive.isMobile(context) ? 2 : 1),
                      ),
                    ),
                    onPressed: () {},
                    icon: Icon(Icons.add,color: Colors.white,),
                    label: Text("Ajouter",style: TextStyle(color: Colors.white),),
                  ),
                  const SizedBox(width: 20,),
                ],
              ),
              SizedBox(
                width: double.infinity,
                child: DataTable(
                    columnSpacing: 12,
                    horizontalMargin: 12,
                    columns: const [
                      DataColumn(
                        label: Text("Nom",style: TextStyle(fontWeight: FontWeight.bold,fontSize: 18),),
                      ),
                      DataColumn(
                        label: Text("Filiale",style: TextStyle(fontWeight: FontWeight.bold,fontSize: 18)),
                      ),
                      DataColumn(
                        label: Text("Accès",style: TextStyle(fontWeight: FontWeight.bold,fontSize: 18)),
                      ),
                    ],
                    rows: List.generate(
                      demoContributeurs.length,
                          (index) => contributeursDataRow(demoContributeurs[index]),
                    )
                ),
              )
            ],
          ),
        ),

      ),
    );
  }

  DataRow contributeursDataRow(ContributeurModel fileInfo) {
    return DataRow(
      cells: [
        DataCell(
          Row(
            children: [
              Image.asset(
                fileInfo.photo_url!,
                height: 30,
                width: 30,
              ),
              Padding(
                padding:  EdgeInsets.symmetric(horizontal: defaultPadding),
                child: Text(fileInfo.name!),
              ),
            ],
          ),
        ),
        DataCell(Text(fileInfo.entite!)),
        DataCell(Text(fileInfo.access!)),
      ],
    );
  }
}



