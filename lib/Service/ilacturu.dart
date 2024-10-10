import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:pharmacy_project/model/ilacturuModel.dart';

class IlacTuru {
  static const String url = "http://10.0.2.2:3006/api/ilacturleri/";

  Future<List<Tur>> getIlacTuru() async {
    final response = await http.get(Uri.parse(url));
    if (response.statusCode == 200) {
      List jsonResponse = json.decode(response.body);
      return jsonResponse.map((tur) => Tur.fromJson(tur)).toList();
    } else {
      throw Exception('Failed to load album');
    }
  }
}
