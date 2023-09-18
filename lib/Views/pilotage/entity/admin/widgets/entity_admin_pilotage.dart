import 'package:flutter/material.dart';

class EntityAdmin extends StatefulWidget {
  const EntityAdmin({Key? key}) : super(key: key);

  @override
  State<EntityAdmin> createState() => _EntityAdminState();
}

class _EntityAdminState extends State<EntityAdmin> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: DataTable(
        columns: const [
          DataColumn(label: Text("Logo")),
          DataColumn(label: Text("Nom entité")),
          DataColumn(label: Text("Filiale")),
          DataColumn(label: Text("Filière")),
          DataColumn(label: Text("Pays")),
          DataColumn(label: Text("Ville")),
          DataColumn(label: Text("Addresse")),
          DataColumn(label: Text("Sous entités")),
        ],
        rows: [],
      ),
      backgroundColor: Colors.transparent,
    );
  }
}
