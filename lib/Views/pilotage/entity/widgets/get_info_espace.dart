import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class InfoEspace{
  final storage = FlutterSecureStorage();

  getNameEspace()async{
    return await storage.read(key: "espace");
  }
}