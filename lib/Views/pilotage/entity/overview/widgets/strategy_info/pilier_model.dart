import 'package:flutter/material.dart';

class PilierInfoModel {
  final String? svgSrc, title, totalStorage;
  final int? numOfFiles, percentage;
  final Color? color;


  PilierInfoModel({
    this.svgSrc,
    this.title,
    this.totalStorage,
    this.numOfFiles,
    this.percentage,
    this.color,
  });
}

List demoPiliers = [
  PilierInfoModel(
    title: "ALIGNEMENT STRATEGIQUE",
    numOfFiles: 50,
    svgSrc: "assets/icons/gouvernance.png",
    totalStorage: "125",
    color: Colors.purple,
    percentage: 45,
  ),
  PilierInfoModel(
    title: "MAITRISE OPERATIONNELLE",
    numOfFiles: 80,
    svgSrc: "assets/icons/economie.png",
    totalStorage: "120",
    color: Color(0xFF007EE5),
    percentage: 70,
  ),
  PilierInfoModel(
    title: "PERFORMANCE ET INTEGRITE DU SYSTEME",
    numOfFiles: 20,
    svgSrc: "assets/icons/analysis.png",
    totalStorage: "140",
    color: Colors.amber,
    percentage: 15,
  ),
  PilierInfoModel(
    title: "RESILIENCE DU SYSTEME",
    numOfFiles: 63,
    svgSrc: "assets/icons/environnement.png",
    totalStorage: "70",
    color: Colors.green,
    percentage: 88,
  ),
];
