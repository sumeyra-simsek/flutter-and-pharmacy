import 'package:flutter/material.dart';
import 'package:pharmacy_project/Service/musteri_service.dart';
import 'package:pharmacy_project/model/musteri_model.dart';

import '../model/musteri_model.dart';

class Musteri extends StatefulWidget {
  const Musteri({super.key});

  @override
  State<Musteri> createState() => _MusteriState();
}

class _MusteriState extends State<Musteri> {

  late Future<List<Musteriler>> futureMusteriler;
  void initState() {
    futureMusteriler = MusterilerServis().getMusteriler();
  }

  TextEditingController _MusteriController = TextEditingController();
  TextEditingController _adresController = TextEditingController();
  TextEditingController _telNoController = TextEditingController();

  void _addMusteri() async{
    Musteriler newMusteri = Musteriler(
      mid: null,
      madi: _MusteriController.text,
      adres: _adresController.text,
      telno: int.tryParse(_telNoController.text)
    );

    await MusterilerServis().addMusteri(newMusteri);
    setState(() {
      futureMusteriler = MusterilerServis().getMusteriler();
    });
  }


  @override
  Widget build(BuildContext context) {
    double deviceHeight = MediaQuery.of(context).size.height;
    double deviceWidht = MediaQuery.of(context).size.width;


    Widget customRow(Widget childWidget, String text) {
      return Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Text(text),
          IntrinsicWidth(child: childWidget),
        ],
      );
    }

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: SafeArea(
          child: Scaffold(
        body: SingleChildScrollView(
          child: Column(
            children: [
              Container(
                height: deviceHeight / 5.2,
                width: deviceWidht,
                color: Colors.orangeAccent,
                child: Padding(
                    padding: EdgeInsets.only(
                        left: deviceWidht / 3, top: deviceHeight / 13),
                    child: Text(
                      "Müşteri Bilgileri...",
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                          fontSize: 20),
                    )),
              ),
              Card(
                margin: EdgeInsets.only(top: 20, left: 10, right: 10),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    customRow(
                        TextField(
                          controller: _MusteriController,
                          decoration:
                              InputDecoration(hintText: "Müşteri Giriniz."),
                        ),
                        'Müşteri Adı:'),
                    customRow(
                        TextField(
                          controller: _adresController,
                          decoration: InputDecoration(hintText: "Adres"),
                        ),
                        'Adres Giriniz:'),
                    customRow(
                        TextField(
                          controller: _telNoController,
                          decoration: InputDecoration(
                              hintText: "Telefon numarası Giriniz."),
                        ),
                        'Telefon Numarası:'),
                  ],
                ),
              ),
              Padding(
                padding: EdgeInsets.only(top:20),
                child: ElevatedButton(
                    onPressed: _addMusteri,
                    child: Text("Kaydet"),
                    style:
                        ElevatedButton.styleFrom(backgroundColor: Colors.white70)),
              ),
              FutureBuilder(
                  future: futureMusteriler, // futureIlaclar değişkeni, API'den veya veritabanından ilaç verilerini asenkron olarak almak için kullanılır.
                  builder: (context, snapshot) { // snapshot, futureMusteriler'ın durumunu ve sonucunu içerir.
                    if (snapshot.hasData) { // Eğer snapshot'ta veri varsa, yani future başarıyla tamamlandıysa bu blok çalışır.
                      List<Musteriler> musteri = snapshot.data!; // snapshot'tan dönen veriler, List<Musteriler> türünde bir listeye atanır.
                      return SingleChildScrollView( // Yatayda kaydırılabilir bir widget oluşturur. DataTable, yatayda genişse kaydırmayı sağlar.
                        scrollDirection: Axis.horizontal, // Yatay kaydırma yönünü belirler.
                        child: DataTable( // Verileri tablo formatında gösterir.
                          columns: [
                            DataColumn(label: Text('Müşteri Id')), // musteri id  sütunu başlığı
                            DataColumn(label: Text('Müşteri Adı')),
                            DataColumn(label: Text('Adres')),
                            DataColumn(label: Text('Telefon No')),
                          ],
                          rows: musteri.map((mitem) { // Musteriler listesindeki her bir musteri için bir DataRow oluşturur.
                            return DataRow(
                              cells: [
                                DataCell(Text(mitem.mid.toString())),
                                DataCell(Text(mitem.madi.toString())),
                                DataCell(Text(mitem.adres as String)),
                                DataCell(Text(mitem.telno.toString())),
                              ],
                            );
                          }).toList(), // Map fonksiyonundan dönen DataRow listesini toList ile bir List<DataRow> yapısına çevirir.
                        ),
                      );
                    } else if (snapshot.hasError) { // Eğer future işlemi sırasında bir hata oluştuysa bu blok çalışır.
                      return Center(child: Text("${snapshot.error}")); // Hata mesajını ekranda gösterir.
                    }
                    return Center(child: LinearProgressIndicator()); // Eğer future henüz tamamlanmadıysa, bir yüklenme göstergesi (spinner) gösterir.
                  }
              )
            ],
          ),
        ),
      )),
    );
  }
}
