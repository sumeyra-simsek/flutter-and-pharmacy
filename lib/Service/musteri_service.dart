import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:pharmacy_project/model/musteri_model.dart';

class MusterilerServis{
  static const String url ="http://10.0.2.2:3006/api/musteriler/";

  Future<List<Musteriler>> getMusteriler() async{
    final response = await http.get(Uri.parse(url));
    if(response.statusCode == 200) {
      List jsonResponse = json.decode(response.body); //Bu, API'den gelen JSON cevabını Dart nesnesine dönüştürür ve jsonResponse değişkeni bir List<dynamic> haline gelir.
      return jsonResponse.map((musteriler) => Musteriler.fromJson(musteriler))
          .toList();
    }
    else {
      throw Exception('Failed to load album');
    }
  }

  Future<void> addMusteri(Musteriler musteri) async {
      final response = await http.post(
        Uri.parse(url),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: jsonEncode(musteri.toJson()),
      );

      print('Response status: ${response.statusCode}');
      print('Response body: ${response.body}'); // Yanıt gövdesini yazdır
      if (response.statusCode != 201) {
        throw Exception('Failed to add musteri.');
      }
  }
}