import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:http/http.dart' as http;
import '../models/pilotage/data_indicateur_row_model.dart';
import '../models/pilotage/indicateur_model.dart';
import '../models/pilotage/acces_pilotage_model.dart';
import '../models/common/user_model.dart';

class DataBaseController {
  final supabase = Supabase.instance.client;

  Future<bool> calculEntitePriamire(String entite,int annee) async {
    try {
      final response = await http.get(Uri.parse('https://api-schedule-perfrse.onrender.com/schedule/calcul-entite-priamire/${entite}/${annee}'));
      if (response.statusCode == 200) {
        return true;
      } else {
        return false;
      }
    }catch (e) {
      return false;
    }
    return false;
  }

  Future<List<IndicateurModel>> getAllIndicateur() async{
    final List<Map<String,dynamic>> docs = await supabase.from('Indicateurs').select();
    final indicateurs = docs.map((json) => IndicateurModel.fromJson(json)).toList();
    return indicateurs;
  }

  Future<List<DataIndicateurRowModel>> getAllDataRowIndicateur(String entite,int annee) async{
    final List<dynamic> dataRows = await supabase.from('DataIndicateur').select().eq("entite", entite).lte("annee", annee);
    List<DataIndicateurRowModel> dataEntiteRowList = dataRows.map((json) => DataIndicateurRowModel.fromJson(json)).toList();
    return dataEntiteRowList;
  }

  Future<bool> updateDataIndicateur({required String id,required String field,required Map<String,dynamic> data}) async {
    try {
      await Supabase.instance.client.from('DataIndicateur')
          .update({'${field}': data}).eq('_id', id);
      return true;

    }catch(e) {
      return false;
    }
  }

  Future<bool> validerDataIndicateur({required String id,required String field,required Map<String,dynamic> data}) async {
    try {
      await Supabase.instance.client.from('DataIndicateur').update({'${field}': data}).eq('_id', id);
      return true;

    }catch(e) {
      return false;
    }
  }

// Users 
  Future<List<UserModel>> getAllUser() async{
    final List<Map<String,dynamic>> docUsers = await supabase.from('Users').select();
    final users = docUsers.map((json) => UserModel.fromJson(json)).toList();
    return users;
  }
  Future<void>AddUser({required email,required password,required data })async{
    try{
        await supabase.auth.signUp(
        email: email,
        password: password,
      );
      supabase.from('Users').insert(data);
    }on Exception catch(e){
        throw Exception(e);
    }
  }

  Future<bool> updateUser({required String email,required String nom,required String prenom,required String titre,required String ville,required String adresse,required String fonction,required String numero,required String pays}) async {
    try {
      await Supabase.instance.client.from('Users')
          .update({'nom': nom,'prenom': prenom,'titre': titre,'ville': ville,'addresse': adresse,'fonction': fonction,'numero': numero,'pays': pays}).eq('email',email);
      return true;

    }catch(e) {
      return false;
    }
  }

  Future<bool> updatePasswordUser({required String email,required String checkPassWord}) async {
    try {
    await supabase.auth.updateUser(UserAttributes(
      email: email,
      password: checkPassWord,
    ));

      return true;
    
    //return true;
  } catch (e) {
    return false;
  }
  }

  Future<bool> updateUserLanguage({required String email,required String langue}) async {
    try {
      if(langue.isNotEmpty)await Supabase.instance.client.from('Users').update({'langue':langue[0].toLowerCase()+langue[1]}).eq('email',email);
      
      return true;

    }catch(e) {
      return false;
    }
  }

  Future<List<AccesPilotageModel>> getAllUsersAccesPilotage() async{
   
          final List<Map<dynamic,dynamic>> docAcces = await supabase.from('AccesPilotage').select();
          final accesPilotage = docAcces.map((json) => AccesPilotageModel.fromJson(json)).toList();
          return accesPilotage;
    
  }

  Future<void>addUsersAccesPilotage({required email,required password,required data })async{
    try{
        await supabase.auth.signUp(
        email: email,
        password: password,
      );
      supabase.from('Users').insert(data);
    }on Exception catch(e){
        throw Exception(e);
    }
  }
}