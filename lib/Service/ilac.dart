import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:pharmacy_project/model/ilacapi.dart';

class IlacService{
  static const String url ="http://10.0.2.2:3006/api/ilaclar/";


   Future<List<Ilac>> getIlaclar() async{
    final response = await http.get(Uri.parse(url));
    if (response.statusCode == 200) {
      List jsonResponse = json.decode(response.body);
      return jsonResponse.map((ilac) => Ilac.fromJson(ilac)).toList();
    } else {
      throw Exception('Failed to load album');
    }
  }
  Future<void> addIlac(Ilac ilac) async {
    final response = await http.post(
      Uri.parse(url),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(ilac.toJson()),
    );

    if (response.statusCode != 201) {
      throw Exception('Failed to add ilac.');
    }
  }

}
