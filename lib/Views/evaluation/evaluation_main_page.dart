import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:go_router/go_router.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import '../../helpers/helper_methods.dart';
import 'widgets/drawer_audit.dart';
import 'widgets/evaluation_utils.dart';
import 'widgets/app_bar_audit.dart';

class EvaluationPage extends StatefulWidget {
  final Widget child;
  const EvaluationPage({super.key, required this.child});

  @override
  State<EvaluationPage> createState() => _EvaluationPageState();
}

class _EvaluationPageState extends State<EvaluationPage> {
  final storage = FlutterSecureStorage();
  final supabase = Supabase.instance.client;
  late Future<Map> EvaluationData;


  Future<Map> loadDataEvaluation() async{
    var data = {};
    String? email = await storage.read(key: 'email');
    final user = await supabase.from('Users').select().eq('email', email);
    final accesEvaluation = await supabase.from('AccesAudit').select().eq('email', email);
    data["user"] = user[0] ;
    data["AccesAudit"] = accesEvaluation[0] ;
    if(checkAccesPilotage(accesEvaluation[0]) ==false) {
      await Future.delayed(Duration(milliseconds: 500));
      context.go("/");
    }
    return data;
  }

  @override
  void initState() {
    super.initState();
    EvaluationData = loadDataEvaluation();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<Map?>(
      future: EvaluationData,
      builder: (context, snapshot) {
        if (!snapshot.hasData) {
          return Scaffold(
            backgroundColor: Colors.white,
            body: Center(
              child: loadingPageWidget(),
            ),
          );
        }
        final data = snapshot.data!;
    return Scaffold(
          appBar: PreferredSize(
            preferredSize: Size.fromHeight(60.0),
            child: AppBarAudit(mainPageData: data,),
          ),
          body: Scaffold(
            drawer: const DrawerEvaluation(),
            endDrawer: const DrawerEvaluation(),
            body: Row(
              children: [
              const DrawerEvaluation(), 
              Expanded(child: widget.child)],
            ),
          ),
        );
  }
  );
  }
}
