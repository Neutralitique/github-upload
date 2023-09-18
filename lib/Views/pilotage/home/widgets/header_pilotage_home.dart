import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../../../../widgets/customtext.dart';
import '/views/common/main_page/widget/banniere.dart';
import 'listefilliale.dart';


class HeaderPilotageHome extends StatefulWidget {
  const HeaderPilotageHome({Key? key}) : super(key: key);

  @override
  State<HeaderPilotageHome> createState() => _HeaderPilotageHomeState();
}

class _HeaderPilotageHomeState extends State<HeaderPilotageHome> {

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [

            Padding(
              padding: EdgeInsets.all(5),
              child: RichText(text:TextSpan(
                  text:"PILOTAGE",style: TextStyle(fontSize: 35,color:Colors.black,fontWeight: FontWeight.bold),
                  children: [
                    TextSpan(text:" Q",style: TextStyle(fontSize: 35,color:Color.fromRGBO(172,28,12,1),fontWeight: FontWeight.bold),),
                    TextSpan(text:"S",style: TextStyle(fontSize: 35,color:Color.fromRGBO(206,131,0,1),fontWeight: FontWeight.bold),),
                    TextSpan(text:"E",style: TextStyle(fontSize: 35,color:Color.fromRGBO(42,77,4,1),fontWeight: FontWeight.bold),)
                  ]
              ),

              )
            ),

          ],
        ),
        //const SizedBox(height:15,),
        Container(
          height: 250,
          width: 1200,
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Expanded(
                  flex: 6,
                  child: Card(
                    elevation: 5,
                    child: Container(
                      height: 250,
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(17),
                          boxShadow: [
                            BoxShadow(
                                offset: const Offset(0, 6),
                                color: Colors.green.withOpacity(.1),
                                blurRadius: 12)
                          ],
                         ),
                      child: ClipRRect(
                          borderRadius: BorderRadius.circular(15.0),
                          child: Image.asset(
                            'assets/images/banniereQSE.png',
                            fit: BoxFit.contain,
                          )),
                    ),
                  )),
            ],
          ),
        ),
      ],
    );
  }
}
//
// Container(
// height: 200,
// width: 250,
// margin: EdgeInsets.only(left: 20),
// child: Container(
// width: 200,
// decoration: BoxDecoration(
// borderRadius: BorderRadius.circular(20),
// border: Border.all(color: Colors.red, width: 2.0)),
// child: Column(
// crossAxisAlignment: CrossAxisAlignment.start,
// children: [
// Container(
// height: 30,
// width: double.maxFinite,
// decoration: BoxDecoration(
// color: Colors.black54,
// borderRadius: BorderRadius.circular(20)),
// child: const Center(
// child: CustomText(
// text: "Ressources",
// color: Colors.black,
// weight: FontWeight.bold,
// ),
// ),
// ),
// TextButton.icon(
// onPressed: () {
// context.go('/pilotage/ressoures/organigramme');
// },
// icon: const Icon(
// Icons.account_tree,
// color: Colors.red,
// ),
// label: Text("Organigramme",
// style: TextStyle(color: Colors.black))
// ),
// TextButton.icon(
// onPressed: () {},
// icon: Icon(
// Icons.telegram,
// color: Colors.green,
// ),
// label: Text("Stratégie",
// style: TextStyle(color:Colors.black))
// ),
// TextButton.icon(
// onPressed: () {},
// icon: Icon(
// Icons.person,
// color: Colors.orange,
// ),
// label: Text("Contributeurs",
// style: TextStyle(color:Colors.black))),
// TextButton.icon(
// onPressed: () {},
// icon: Icon(
// Icons.batch_prediction,
// color: Colors.brown,
// ),
// label: Text(
// "Politique QSE",
// style: TextStyle(color:Colors.black),
// ))
// ],
// ),
// ),
// ),