import 'package:flutter/material.dart';
import 'package:file_picker/file_picker.dart';

import '../../../../widgets/customtext.dart';


class ScreenSupportClient extends StatefulWidget {
  const ScreenSupportClient({super.key});

  @override
  State<ScreenSupportClient> createState() => _ScreenSupportClientState();
}

class _ScreenSupportClientState extends State<ScreenSupportClient> {

  final _formKey = GlobalKey<FormState>();
  late final TextEditingController _sujetController;
  late final TextEditingController _requestController;

  @override
  void initState() {
    _sujetController = TextEditingController();
    _requestController = TextEditingController();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: EdgeInsets.only(top: 16,left: 10),
        child: Form(
          key: _formKey,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text("Support client",style: TextStyle(fontSize: 24,color: Color(0xFF3C3D3F),fontWeight: FontWeight.bold),),
              SizedBox(height: 5,),
              Card(
                elevation: 3,
                child: Container(
                  width: 1000,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(height: 5,),
                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: 20,vertical: 5),
                        child: Text("Ouvrir un nouveau ticket",style: TextStyle(fontSize: 16,color: Color(0xFF3C3D3F),fontWeight: FontWeight.bold),),
                      ),
                      SizedBox(height: 5,),
                      Divider(),
                      SizedBox(height: 5,),
                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: 20,vertical: 5),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text("Sujet",style: TextStyle(fontSize: 16,color: Color(0xFF3C3D3F)),),
                            SizedBox(height: 10),
                            sujetWidget(),
                            SizedBox(height: 20),
                            Text("Votre requête",style: TextStyle(fontSize: 16,color: Color(0xFF3C3D3F)),),
                            SizedBox(height: 20),
                            requestWidget(),
                            SizedBox(height: 20),
                            Text("Joindre un document",style: TextStyle(fontSize: 16,color: Color(0xFF3C3D3F)),),
                            SizedBox(height: 10),
                            filePickerWidget(),
                            SizedBox(height: 20),
                            buttonEnvoyer(),
                            SizedBox(height: 20),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }


  Widget filePickerWidget() {
    return InkWell(
      onTap: (){
        _pickFile();
      },
      child: Container(
        height: 60,
        width: 400,
        decoration: BoxDecoration(
            border: Border.all(color: Color(0xFFEAEAEA),width: 3),
            borderRadius: BorderRadius.circular(10)
        ),
        child: Padding(
          padding: EdgeInsets.all(8.0),
          child: Row(
            children: [
              Icon(Icons.add_circle_outline_sharp,color: Colors.grey,),
              SizedBox(width: 10,),
              Text("Cliquer ici pour télécharger un fichier.",style: TextStyle(fontSize: 16,color: Color(0xFF3C3D3F)),),
            ],
          ),
        ),
      ),
    );
  }


  void _pickFile() async {
    FilePickerResult? result = await FilePicker.platform.pickFiles(
      type: FileType.custom,
      allowedExtensions: ['jpg', 'pdf','png','jpeg'],
    );

    if (result != null) {
      String filePath = result.files.single.path!;
      // Utilisez le chemin du fichier sélectionné selon vos besoins
      print('Chemin du fichier sélectionné : $filePath');
    } else {
      // L'utilisateur a annulé la sélection du fichier
      print('Aucun fichier sélectionné.');
    }
  }

  Widget requestWidget() {
    return Container(
      height: 150,
      child: TextFormField(
        controller: _requestController,
        maxLines: 5,
        validator: (value) {
          if (value!=null && value.length < 20 ) {
            return "Une erreur est survenue.";
          }
        },
        decoration: InputDecoration(
            hintText: "",
            border: OutlineInputBorder(),
            focusedBorder: OutlineInputBorder(
                borderSide: BorderSide(
                    color: Theme.of(context).primaryColor,
                    width: 2
                )
            )
        ),
      ),
    );
  }

  Widget sujetWidget() {
    return TextFormField(
      controller: _sujetController,
      validator: (value) {
        if (value!=null && value.length < 10 ) {
          return "Une erreur est survenue.";
        }
      },
      decoration: InputDecoration(
          hintText: "",
          contentPadding: const EdgeInsets.only(left: 10.0, right: 10.0),
          border: OutlineInputBorder(),
          focusedBorder: OutlineInputBorder(
              borderSide: BorderSide(
                  color: Theme.of(context).primaryColor,
                  width: 2
              )
          )
      ),
    );
  }

  Widget buttonEnvoyer () {
    return  Center(
      child: InkWell(
        radius: 20,
        borderRadius: BorderRadius.circular(35),
        onTap: () {
        },
        child: Container(
          height: 50,
          width: 200,
          decoration: BoxDecoration(
              color: Colors.amber,
              border: Border.all(
                color: Colors.amber,
              ),
              borderRadius: BorderRadius.all(Radius.circular(40))),
          child:  Center(
              child: CustomText(
                text: "Envoyer",
                size: 20,
                weight: FontWeight.bold,
                color: Colors.white,
              )),
        ),
      ),
    );
  }
}
