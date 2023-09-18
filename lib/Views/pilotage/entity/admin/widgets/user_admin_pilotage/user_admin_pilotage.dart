
import 'package:data_table_2/data_table_2.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import '../../../../../../api/supabase.dart';
import '../../../../../../models/common/user_model.dart';
import '../../../../../../models/pilotage/acces_pilotage_model.dart';
import '../../../../../../module/styled_scrollview.dart';
import '../../../../../../utils/utils.dart';
import '../../../../../../widgets/menu_deroulant.dart';
import '../../../widgets/menu_deroulant_checkbox.dart';
import 'user_admin_controller.dart';

class UserAdmin extends StatefulWidget {
  const UserAdmin({Key? key}) : super(key: key);

  @override
  State<UserAdmin> createState() => _UserAdminState();

}

class _UserAdminState extends State<UserAdmin> {
  final DataBaseController dbController = DataBaseController();
  final UserAdminController userAdminController=Get.find();
  @override
  void initState() {
    
    super.initState();
  }
  
  @override
  Widget build(BuildContext context) {
    return SelectableRegion(
            selectionControls: materialTextSelectionControls,
            focusNode: FocusNode(),
            child: Scaffold(
              body: Padding(
                padding: const EdgeInsets.only(top: 8.0, bottom: 8.0),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(10),
                  child: StyledScrollView(
                    axis: Axis.horizontal,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          height: 600,
                          width: 1600,
                          color: Colors.transparent,
                          child: DataTable2(
                              headingRowColor: MaterialStateColor.resolveWith(
                                  (states) => Color(0xFFF5B907)),
                              headingTextStyle: const TextStyle(
                                fontSize: 15,
                                color: Colors.black,
                              ),
                              headingRowHeight: 40,
                              columnSpacing: 5,
                              dividerThickness: 2,
                              columns: const [
                                DataColumn2(label: Text("Logo"),fixedWidth: 50),
                                DataColumn2(label: Text("Nom"),fixedWidth: 100),
                                DataColumn2(label: Text("Prénom(s)"),fixedWidth: 150),
                                DataColumn2(label: Text("Email"),fixedWidth: 200),
                                DataColumn2(label: Text("Filiale"), size: ColumnSize.S,fixedWidth: 150),
                                DataColumn2(label: Text("Entités"),fixedWidth: 150),
                                DataColumn2(label: Text("Niveau d'acces"),fixedWidth: 200),
                                DataColumn2(label: Text("Bolqué"),fixedWidth: 100),
                                DataColumn2(label: Text("Fonction"),fixedWidth: 150),
                                DataColumn2(label: Text("Adresse"),fixedWidth: 200),
                                DataColumn(label: Text("Created")),
                                DataColumn(label: Text("Last Signed")),
                              ],
                              rows: List.generate(
                                userAdminController.users.length, 
                                (index) => userViewModel(userAdminController.users[index]))
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              backgroundColor: Colors.transparent,
              floatingActionButton: FloatingActionButton(
                child: Icon(Icons.add),
                onPressed: () {
                  showDialog(barrierDismissible: true,context: context, builder: (context) {
                    return AlertDialog(
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                      scrollable: true,
                      title: Text('Ajouter un pilote'),
                      titlePadding: EdgeInsets.only(top: 20, right: 20, left: 20),
                      content: FormulaireAddUser(),
                      titleTextStyle: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          overflow: TextOverflow.ellipsis),
                    );
                  });
                },
              ),
            ),
          );
  }

  DataRow userViewModel(UserModel userModel) {
    List<AccesPilotageModel> acces=userAdminController.accesPilotage.where((userAcces) =>userAcces.email==userModel.email.trim() ).toList();
    return DataRow(cells: [
      DataCell(CircleAvatar(
        child: FlutterLogo(),
      )),
      DataCell(Text("${userModel.nom}")),
      DataCell(Text("${userModel.prenom}")),
      DataCell(Text(userModel.email)),
      DataCell(Text("${userModel.entreprise}")),
      DataCell(Text("${acces[0].entite}")),
      DataCell(Text(checkAccesType(acces[0])??"aucun")),
      DataCell(Text("${acces[0].estBloque}")),
      DataCell(Text("${userModel.fonction??""}")),
      DataCell(Text("${userModel.addresse??""}")),
      DataCell(Text("")),
      DataCell(Text("")),
    ]);
  }

  String? checkAccesType(AccesPilotageModel acces){
      String?levelAcces="";
      if(acces.estAdmin!) levelAcces+="Administarteur";
      if(acces.estCollecteur!) levelAcces+="Collecteur";
      if(acces.estSpectateur!) levelAcces+="Spectateur";
      if(acces.estValidateur!) levelAcces+="Validateur";

      return levelAcces;
  }

  Widget loadingWidget() {
    return const Scaffold(
      body: Center(
        child: CircularProgressIndicator(),
      ),
    );
  }

  Widget refreshWidget() {
    return Scaffold(
      body: Center(
        child: IconButton(
            onPressed: () {
              userAdminController.initialisation();
            },
            icon: Icon(Icons.refresh)),
      ),
    );
  }
}

class FormulaireAddUser extends StatefulWidget {
  const FormulaireAddUser({Key? key}) : super(key: key);

  @override
  State<FormulaireAddUser> createState() => _FormulaireAddUserState();
}

class _FormulaireAddUserState extends State<FormulaireAddUser> {


  bool _obsureText = true;
  String? entity;
  String? acces;
  bool _obsureTextConfirm = true;
  final _formAddUser = GlobalKey<FormState>();
  final DataBaseController dbController = DataBaseController();
  TextEditingController passWordController = TextEditingController();
  final data = <String, dynamic>{};

  bool enableButton = true;

  bool? formResult ;
  String resultMessage = "";

  String passwordEmail = "";


  Future<void> fetching() async {

  }

  add()async{
    Navigator.pop(context);
    await Future.delayed(Duration(microseconds: 500));
    await dbController.AddUser(email: data["email"], password: data["password"], data: data);
    ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(content: Text("${data["name"]} a été ajouté avec succès. Nous lui avons envoyé ces identifiants par mail."),duration: Duration(seconds: 5),backgroundColor: Colors.green,),
    );
  }

  @override
  void initState() {
    var listKey = [
      "name",
      "lastName",
      "fonction",
      "password",
      "contacts",
      "address",
      "entity",
      "acces",
      "email"
    ];
    listKey.forEach((element) {
      data["$element"] = null;
    });
    super.initState();
  }

  Future sendMail(String fullName,String email,String password) async{
    setState(() {
      enableButton = false;
    });
    var json = {
      "fullName":fullName,
      "email":email,
      "password":password
    };
    setState(() {
      enableButton = true;
    });
  }

  @override
  void dispose() {
    data.clear();
    passWordController.clear();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 540,
      width: 800,
      child: Column(
        children: [
          Expanded(
            child: Row(
              children: [
                Column(
                  children: [
                    Container(
                      height: 150,
                      width: 150,
                      color: Colors.blue,
                      child: Image.asset(
                        "assets/images/profil_person.png",
                        fit: BoxFit.fill,
                      ),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    SizedBox(
                        width: 150,
                        child: ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              elevation: 1,
                              backgroundColor: Color(0xFFFAFAFA),
                              side: BorderSide(width: 1.0, color: Colors.black),
                            ),
                            onPressed: () {},
                            child: Text(
                              "Charger une photo",
                              style:
                                  TextStyle(fontSize: 12, color: Colors.black),
                            ))),
                  ],
                ),
                SizedBox(
                  width: 20,
                ),
                Expanded(
                  child: Form(
                    autovalidateMode: AutovalidateMode.onUserInteraction,
                    key: _formAddUser,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Container(
                              width: 300,
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  // Nom
                                  RichText(
                                    text: TextSpan(
                                      text: 'Nom ',
                                      style: DefaultTextStyle.of(context).style,
                                      children: const <TextSpan>[
                                        TextSpan(
                                            text: '*',
                                            style: TextStyle(
                                                fontWeight: FontWeight.bold,
                                                color: Colors.red)),
                                      ],
                                    ),
                                  ),
                                  const SizedBox(
                                    height: 5,
                                  ),
                                  SizedBox(
                                    width: 300,
                                    height: 60,
                                    child: TextFormField(
                                      onChanged: (value) {
                                        setState(() {
                                          data["name"] = value;
                                        });
                                      },
                                      validator: (value) =>
                                          (value != null && value.length > 2)
                                              ? null
                                              : 'Erreur de saisie',
                                      decoration: InputDecoration(
                                          hintText: "",
                                          contentPadding: const EdgeInsets.only(
                                              left: 10.0, right: 20.0),
                                          border: OutlineInputBorder(),
                                          focusedBorder: OutlineInputBorder(
                                              borderSide: BorderSide(
                                                  color: Theme.of(context)
                                                      .primaryColor,
                                                  width: 2))),
                                    ),
                                  ),
                                  SizedBox(
                                    height: 10,
                                  ),
                                  // Email
                                  RichText(
                                    text: TextSpan(
                                      text: 'Email ',
                                      style: DefaultTextStyle.of(context).style,
                                      children: const <TextSpan>[
                                        TextSpan(
                                            text: '*',
                                            style: TextStyle(
                                                fontWeight: FontWeight.bold,
                                                color: Colors.red)),
                                      ],
                                    ),
                                  ),
                                  SizedBox(
                                    height: 5,
                                  ),
                                  SizedBox(
                                    width: 300,
                                    height: 60,
                                    child: TextFormField(
                                      onChanged: (value) {
                                        setState(() {
                                          data["email"] = value;
                                        });
                                      },
                                      validator: (value) =>
                                          (value != null && verifyEmail(value))
                                              ? null
                                              : 'Addrese mail incorrect',
                                      decoration: InputDecoration(
                                          hintText: "",
                                          contentPadding: const EdgeInsets.only(
                                              left: 10.0, right: 20.0),
                                          border: OutlineInputBorder(),
                                          focusedBorder: OutlineInputBorder(
                                              borderSide: BorderSide(
                                                  color: Theme.of(context)
                                                      .primaryColor,
                                                  width: 2))),
                                    ),
                                  ),
                                  SizedBox(
                                    height: 10,
                                  ),
                                  // Mot de passe
                                  RichText(
                                    text: TextSpan(
                                      text: 'Mot de passe ',
                                      style: DefaultTextStyle.of(context).style,
                                      children: const <TextSpan>[
                                        TextSpan(
                                            text: '*',
                                            style: TextStyle(
                                                fontWeight: FontWeight.bold,
                                                color: Colors.red)),
                                      ],
                                    ),
                                  ),
                                  SizedBox(
                                    height: 5,
                                  ),
                                  SizedBox(
                                    width: 300,
                                    height: 60,
                                    child: TextFormField(
                                      obscureText: _obsureText,
                                      onChanged: (value) {
                                        setState(() {
                                          data["password"] = hashPassword(value);
                                          passwordEmail = value;

                                        });
                                      },
                                      controller: passWordController,
                                      validator: (value) => (value != null &&
                                              validatePassword(value))
                                          ? null
                                          : 'Le mot de passe doit avoir + 8 charactères',
                                      decoration: InputDecoration(
                                          hintText: "",
                                          suffixIcon: GestureDetector(
                                            onTap: () {
                                              setState(() {
                                                _obsureText = !_obsureText;
                                              });
                                            },
                                            child: Icon(_obsureText
                                                ? Icons.visibility
                                                : Icons.visibility_off),
                                          ),
                                          contentPadding: const EdgeInsets.only(
                                              left: 10.0, right: 20.0),
                                          border: const OutlineInputBorder(),
                                          focusedBorder: OutlineInputBorder(
                                              borderSide: BorderSide(
                                                  color: Theme.of(context)
                                                      .primaryColor,
                                                  width: 2))),
                                    ),
                                  ),
                                  SizedBox(
                                    height: 10,
                                  ),
                                  // Entité
                                  RichText(
                                    text: TextSpan(
                                      text: 'Entité ',
                                      style: DefaultTextStyle.of(context).style,
                                      children: const <TextSpan>[
                                        TextSpan(
                                            text: '*',
                                            style: TextStyle(
                                                fontWeight: FontWeight.bold,
                                                color: Colors.red)),
                                      ],
                                    ),
                                  ),
                                  SizedBox(
                                    height: 5,
                                  ),
                                  SizedBox(
                                    width: 300,
                                    height: 40,
                                    child: MenuDeroulant(
                                      indication: '',
                                      selectedValue: entity,
                                      onChanged2: (value) {
                                        setState(() {
                                          entity = value;
                                          data["entity"] = value;
                                        });
                                      },
                                      items: const  [
                                        "SUCRIVOIRE",
                                        "Sucrivoire Siège",
                                        "Sucrivoire Borotou-Koro",
                                        "Sucrivoire Zuénoula"
                                      ],
                                    ),
                                  ),
                                  SizedBox(
                                    height: 10,
                                  ),
                                  // Fonction
                                  RichText(
                                    text: TextSpan(
                                      text: 'Fonction ',
                                      style: DefaultTextStyle.of(context).style,
                                      children: const <TextSpan>[],
                                    ),
                                  ),
                                  const SizedBox(
                                    height: 5,
                                  ),
                                  SizedBox(
                                    width: 300,
                                    height: 40,
                                    child: TextFormField(
                                      onChanged: (value) {
                                        setState(() {
                                          data["fonction"] = value;
                                        });
                                      },
                                      decoration: InputDecoration(
                                          hintText: "",
                                          contentPadding: const EdgeInsets.only(
                                              left: 10.0, right: 20.0),
                                          border: OutlineInputBorder(),
                                          focusedBorder: OutlineInputBorder(
                                              borderSide: BorderSide(
                                                  color: Theme.of(context)
                                                      .primaryColor,
                                                  width: 2))),
                                    ),
                                  ),
                                  SizedBox(
                                    height: 5,
                                  ),
                                ],
                              ),
                            ),
                            Container(
                              width: 300,
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  // LastName
                                  RichText(
                                    text: TextSpan(
                                      text: 'Prénom(s) ',
                                      style: DefaultTextStyle.of(context).style,
                                      children: const <TextSpan>[
                                        TextSpan(
                                            text: '*',
                                            style: TextStyle(
                                                fontWeight: FontWeight.bold,
                                                color: Colors.red)),
                                      ],
                                    ),
                                  ),
                                  const SizedBox(
                                    height: 5,
                                  ),
                                  SizedBox(
                                    width: 300,
                                    height: 60,
                                    child: TextFormField(
                                      onChanged: (value) {
                                        setState(() {
                                          data["lastName"] = value;
                                        });
                                      },
                                      validator: (value) =>
                                          (value != null && value.length > 2)
                                              ? null
                                              : 'Erreur de saisie',
                                      decoration: InputDecoration(
                                          hintText: "",
                                          contentPadding: const EdgeInsets.only(
                                              left: 10.0, right: 20.0),
                                          border: OutlineInputBorder(),
                                          focusedBorder: OutlineInputBorder(
                                              borderSide: BorderSide(
                                                  color: Theme.of(context)
                                                      .primaryColor,
                                                  width: 2))),
                                    ),
                                  ),
                                  const SizedBox(
                                    height: 10,
                                  ),
                                  // Contacts
                                  RichText(
                                    text: TextSpan(
                                      text: 'Contact(s)',
                                      style: DefaultTextStyle.of(context).style,
                                      children: const <TextSpan>[],
                                    ),
                                  ),
                                  const SizedBox(
                                    height: 5,
                                  ),
                                  SizedBox(
                                    width: 300,
                                    height: 60,
                                    child: TextFormField(
                                      onChanged: (value) {
                                        setState(() {
                                          data["contacts"] = value;
                                        });
                                      },
                                      decoration: InputDecoration(
                                          hintText: "",
                                          contentPadding: const EdgeInsets.only(
                                              left: 10.0, right: 20.0),
                                          border: OutlineInputBorder(),
                                          focusedBorder: OutlineInputBorder(
                                              borderSide: BorderSide(
                                                  color: Theme.of(context)
                                                      .primaryColor,
                                                  width: 2))),
                                    ),
                                  ),
                                  const SizedBox(
                                    height: 10,
                                  ),
                                  // Confirmation pass word
                                  RichText(
                                    text: TextSpan(
                                      text: 'Confirmation du mot de passe',
                                      style: DefaultTextStyle.of(context).style,
                                      children: const <TextSpan>[
                                        TextSpan(
                                            text: '*',
                                            style: TextStyle(
                                                fontWeight: FontWeight.bold,
                                                color: Colors.red)),
                                      ],
                                    ),
                                  ),
                                  SizedBox(
                                    height: 5,
                                  ),
                                  SizedBox(
                                    width: 300,
                                    height: 60,
                                    child: TextFormField(
                                      obscureText: _obsureTextConfirm,
                                      validator: (value) => (value != null &&
                                              value == passWordController.text)
                                          ? null
                                          : 'Erreur de saisie',
                                      decoration: InputDecoration(
                                          hintText: "",
                                          suffixIcon: GestureDetector(
                                            onTap: () {
                                              setState(() {
                                                _obsureTextConfirm =
                                                    !_obsureTextConfirm;
                                              });
                                            },
                                            child: Icon(_obsureTextConfirm
                                                ? Icons.visibility
                                                : Icons.visibility_off),
                                          ),
                                          contentPadding: const EdgeInsets.only(
                                              left: 10.0, right: 20.0),
                                          border: OutlineInputBorder(),
                                          focusedBorder: OutlineInputBorder(
                                              borderSide: BorderSide(
                                                  color: Theme.of(context)
                                                      .primaryColor,
                                                  width: 2))),
                                    ),
                                  ),
                                  SizedBox(
                                    height: 10,
                                  ),

                                  /// Droit d'accès
                                  RichText(
                                    text: TextSpan(
                                      text: "Droit d'accès",
                                      style: DefaultTextStyle.of(context).style,
                                      children: const <TextSpan>[
                                        TextSpan(
                                            text: '*',
                                            style: TextStyle(
                                                fontWeight: FontWeight.bold,
                                                color: Colors.red)),
                                      ],
                                    ),
                                  ),
                                  SizedBox(
                                    height: 5,
                                  ),
                                  SizedBox(
                                    width: 300,
                                    height: 40,
                                    child: MenuDeroulantCheckBox(
                                      items: [
                                        "Collecteur",
                                        "Validateur",
                                        "Spectateur"
                                      ],
                                      indication: '',
                                      onChanged2: (value) {
                                        acces = value;
                                        data["acces"] = value;
                                      },
                                    ),
                                  ),
                                  SizedBox(
                                    height: 10,
                                  ),
                                  // Adresse
                                  RichText(
                                    text: TextSpan(
                                      text: "Adresse",
                                      style: DefaultTextStyle.of(context).style,
                                      children: const <TextSpan>[],
                                    ),
                                  ),
                                  SizedBox(
                                    height: 5,
                                  ),
                                  SizedBox(
                                    width: 300,
                                    height: 40,
                                    child: TextFormField(
                                      onChanged: (value) {
                                        setState(() {
                                          data["address"] = value;
                                        });
                                      },
                                      decoration: InputDecoration(
                                          hintText: "",
                                          contentPadding: const EdgeInsets.only(
                                              left: 10.0, right: 20.0),
                                          border: OutlineInputBorder(),
                                          focusedBorder: OutlineInputBorder(
                                              borderSide: BorderSide(
                                                  color: Theme.of(context)
                                                      .primaryColor,
                                                  width: 2))),
                                    ),
                                  ),
                                  SizedBox(
                                    height: 5,
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                        SizedBox(
                          height: 5,
                        ),
                        RichText(
                          text: TextSpan(
                            text: "NB: les champs marqués en ",
                            style: DefaultTextStyle.of(context)
                                .style
                                .copyWith(fontStyle: FontStyle.italic),
                            children: const <TextSpan>[
                              TextSpan(
                                  text: '*',
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      color: Colors.red,
                                      fontStyle: FontStyle.italic)),
                              TextSpan(
                                text: ' doivent être renseignés',
                              ),
                            ],
                          ),
                        ),
                        SizedBox(
                          height: 5,
                        ),
                        if(formResult!=null && formResult ==false ) Text("Echec lors de l'envoi de la requête : $resultMessage",
                        style: TextStyle(color: Colors.red,fontSize: 15),)
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(
            height: 20,
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                OutlinedButton(
                    style: OutlinedButton.styleFrom(
                      side: BorderSide(width: 1.0, color: Colors.red),
                    ),
                    onPressed: () async{
                      Navigator.pop(context);
                    },
                    child: const Text(
                      "Annuler",
                      style: TextStyle(color: Colors.red),
                    )),
                if(!enableButton) const CircularProgressIndicator(),
                ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.green,
                      side: BorderSide(width: 1.0, color: Colors.green),
                    ),
                    onPressed: !enableButton? null : () async{
                      setState(() {
                        formResult = true;
                      });
                      final isValidForm = _formAddUser.currentState!.validate();
                      if (isValidForm && acces != null && entity != null) {
                          add();
                      }
                    },
                    child: Text(
                      "Soumettre",
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 18,
                          fontWeight: FontWeight.bold),
                    ))
              ],
            ),
          )
        ],
      ),
    );
  }
}

