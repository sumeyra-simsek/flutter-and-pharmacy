import 'package:flutter/material.dart';

class Musteriler {
  Musteriler({
    required this.mid,
    required this.madi,
    required this.adres,
    required this.telno
});
  int ? mid;
  String? madi;
  String? adres;
  int? telno;

  Musteriler.fromJson(Map<String,dynamic>json){
    mid = json["mid"];
    madi = json["madi"]?? "Null";
    adres= json["adres"] ?? "Null";
    telno= json["telno"] != null ? int.tryParse(json["telno"].toString()) : null;
  }
  Map<String,dynamic> toJson() {
    final Map<String,dynamic> data ={};
    data["mid"] = mid;
    data["madi"]=madi;
    data["adres"] =adres;
    data["telno"]=telno;
    return data;
}

}