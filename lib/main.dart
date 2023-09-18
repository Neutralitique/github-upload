import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:perfqse/Views/pilotage/controllers/controllerEntity.dart';
import 'package:perfqse/Views/pilotage/controllers/tableau_controller.dart';
import 'package:perfqse/routes/routes.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'Views/common/forgot_password/controller/reset_password_controller.dart';


void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await Get.put(ResetPassWordController());
  await Get.put(ControllerEntity());
  await Get.put(ControllerTbQSE());
  WidgetsFlutterBinding.ensureInitialized();
  final storage = FlutterSecureStorage();
  await storage.write(key: "app_version", value: "version 0.1.1");
  await Future.delayed(Duration(seconds: 3));
  await Supabase.initialize(
    url: "https://djlcnowdwysqbrggekme.supabase.co",
    anonKey: "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6ImRqbGNub3dkd3lzcWJyZ2dla21lIiwicm9sZSI6ImFub24iLCJpYXQiOjE2OTIxNzc1NjcsImV4cCI6MjAwNzc1MzU2N30.UxvLKjDhQ4ghsGTTY7Sy1Q75YCktx2nXR2pHuLeIMF4",
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

// @override
// Widget build(BuildContext context) {
//   return GetMaterialApp(
//     debugShowCheckedModeBanner: false,
//     title: 'Performance QSE',
//     theme: ThemeData(
//       colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
//       useMaterial3: true,
//     ),
//     initialRoute: "/account/login",
//   );
// }
//
  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      debugShowCheckedModeBanner: false,
      title: 'Performance QSE',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      routerConfig: RouteClass.router,
    );
  }

//     @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       debugShowCheckedModeBanner: false,
//       title: 'Performance QSE',
//       theme: ThemeData(
//         colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
//         useMaterial3: true,
//       ),
//     home: BoxAxe(
//       firsttitle: 'ALIGNEMENT',
//       secondtitle: 'STRATEGIQUE',
//       subtitle: '20 indicateur(s) sur 30 ',
//       color: Colors.green,
//       colorChartSectionFull: Colors.orange,
//       colorChartSectionEmpty: Colors.red,
//       numChartSectionFull: 90,
//     ),
//       );
// }
}

// import 'package:flutter/material.dart';
//
// void main() {
//   runApp(const MyApp());
// }
//
// class MyApp extends StatelessWidget {
//   const MyApp({Key? key}) : super(key: key);
//
//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       // Remove the debug banner
//         debugShowCheckedModeBanner: false,
//         title: 'Kindacode.com',
//         theme: ThemeData(
//           primarySwatch: Colors.indigo,
//         ),
//         home: const HomePage());
//   }
// }
//
// class HomePage extends StatefulWidget {
//   const HomePage({Key? key}) : super(key: key);
//
//   @override
//   State<HomePage> createState() => _HomePageState();
// }
//
// class _HomePageState extends State<HomePage> {
//   // Generating some dummy data
//   final List<Map<String, dynamic>> _items = List.generate(
//       20,
//           (index) => {
//         'id': index,
//         'title': 'Item $index',
//         'description':
//         'This is the description of the item $index. There is nothing important here. In fact, it is meaningless.',
//         'isExpanded': false
//       });
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: const Text('Kindacode.com'),
//       ),
//       body: SingleChildScrollView(
//         child: ExpansionPanelList(
//           elevation: 3,
//           //Controlling the expansion behavior
//           expansionCallback: (index, isExpanded) {
//                       setState(() {
//                         _items[index]['isExpanded'] = !isExpanded;
//                       });
//                     },
//           animationDuration: const Duration(milliseconds: 600),
//           children: _items
//               .map(
//                 (item) => ExpansionPanel(
//               canTapOnHeader: true,
//               backgroundColor:
//               item['isExpanded'] == true ? Colors.amber : Colors.white,
//               headerBuilder: (_, isExpanded) => Container(
//                   padding: const EdgeInsets.symmetric(
//                       vertical: 15, horizontal: 30),
//                   child: Text(
//                     item['title'],
//                     style: const TextStyle(fontSize: 20),
//                   )),
//               body: Container(
//                 padding: const EdgeInsets.symmetric(
//                     vertical: 15, horizontal: 30),
//                 child: Text(item['description']),
//               ),
//               isExpanded: item['isExpanded'],
//             ),
//           )
//               .toList(),
//         ),
//       ),
//     );
//   }
// }

//
// import 'package:flutter/material.dart';
// import 'package:perfqse/Views/pilotage/home/widgets/listefilliale.dart';
//
// void main() => runApp(const MyApp());
//
// class MyApp extends StatelessWidget {
//   const MyApp({Key? key}) : super(key: key);
//   static const String _title = 'Flutter Tutorial';
//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       title: _title,
//       home: Scaffold(
//         appBar: AppBar(title: const Text(_title)),
//         body: const Steps(),
//       ),
//     );
//   }
// }
//
// class Process {
//   Process(
//       this.title,
//       this.body,
//       [this.isExpanded = false]
//       );
//   String title;
//   List<String> body;
//   bool isExpanded;
// }
//
// List<Process> getProcess() {
//   return [
//     Process('Processus Généraux',["Processus COM","Processus DAP","Processus RE","Processus SI","Processus MG"]),
//     Process('Processus Transversaux', ["Processus ACHAT","Processus LOG","Processus RH","Processus QSE","Processus MI"]),
//     Process('Processus MI',["Trechville","Bouaflé","Sicodis","Yopougon LBI","Yopougon Toit Rouge","Yopougon ZI"]),
//   ];
// }
//
// class Steps extends StatefulWidget {
//   const Steps({Key? key}) : super(key: key);
//   @override
//   State<Steps> createState() => _StepsState();
// }
//
// class _StepsState extends State<Steps> {
//     final List<Map<String,dynamic>> _items = List.generate(
//         filliale.length,
//           (index) => {
//         'ville':filliale[index]["name"],
//             "prefix":filliale[index]["prefix"]
//       });
//
//   final List<Process> _process = getProcess();
//   @override
//   Widget build(BuildContext context) {
//     return SingleChildScrollView(
//       child: Container(
//         child: _renderSteps(),
//       ),
//     );
//   }
//   Widget _renderSteps() {
//     return ExpansionPanelList(
//       expansionCallback: (int index, bool isExpanded) {
//         setState(() {
//           _process[index].isExpanded = !isExpanded;
//         });
//       },
//       animationDuration: const Duration(milliseconds: 600),
//       children: _process.map<ExpansionPanel>((Process process) {
//         return ExpansionPanel(
//           canTapOnHeader: true,
//              backgroundColor:
//              process.isExpanded == true ? Colors.red : Colors.white,
//                headerBuilder: (_, isExpanded) => Container(
//                   padding: const EdgeInsets.symmetric(
//                       vertical: 2, horizontal: 0),
//                    child: Text(
//                      process.title,
//                      style: const TextStyle(fontSize: 20,fontWeight: FontWeight.bold,color:Colors.black),
//                    )),
//           body:Column(
//               mainAxisAlignment: MainAxisAlignment.start,
//                crossAxisAlignment: CrossAxisAlignment.start,
//                children: _items.map((item){
//                 return TextButton.icon(
//                   icon:CircleAvatar(radius: 15,child:Text(item["prefix"]),) ,
//                   onPressed: () {  },
//                   label: Text(item["ville"]),);
//               }).toList()
//           ),
//           isExpanded: process.isExpanded,
//         );
//       }).toList(),
//     );
//   }
// }
