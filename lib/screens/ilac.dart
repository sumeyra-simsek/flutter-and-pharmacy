import 'package:flutter/material.dart';
import 'package:pharmacy_project/Service/ilacturu.dart';
import 'package:pharmacy_project/model/ilacapi.dart';
import 'package:pharmacy_project/Service/ilac.dart';

import '../model/ilacturuModel.dart';

class ilac extends StatefulWidget {
  const ilac({super.key});

  @override
  State<ilac> createState() => _ilacState();
}

class _ilacState extends State<ilac> {
  late Future<List<Ilac>> futureIlaclar;
  late Future<List<Tur>> futureIlacTuru;

  @override
  void initState() {
    super.initState();
    futureIlaclar = IlacService().getIlaclar();
    futureIlacTuru= IlacTuru().getIlacTuru();
  }


  TextEditingController _dateController = TextEditingController();
  TextEditingController _ilacAdiController = TextEditingController();
  TextEditingController _birimFiyatController = TextEditingController();
  TextEditingController _miktarController = TextEditingController();
  TextEditingController _firmaAdiController = TextEditingController();
  TextEditingController _seriNoController = TextEditingController();

  String? _selectedValue;

  void _addIlac() async {
    Ilac newIlac = Ilac(
      ilacid: null,
      ilacAdi: _ilacAdiController.text,
      ilacTuru: _selectedValue,
      BirimFiyat: int.tryParse(_birimFiyatController.text),
      Miktar: int.tryParse(_miktarController.text),
      TETT: _dateController.text,
      FirmaAdi: _firmaAdiController.text,
      SeriNo: _seriNoController.text,
    );

    await IlacService().addIlac(newIlac);

    setState(() {
      futureIlaclar = IlacService().getIlaclar(); // Yeni veriyi güncelle
      futureIlacTuru = IlacTuru().getIlacTuru();
    });
  }

  @override
  Widget build(BuildContext context) {
    double deviceHeight =
        MediaQuery.of(context).size.height; //telefon yuksekligi
    double deviceWidth = MediaQuery.of(context).size.width; // genisligi
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: SafeArea(
        child: Scaffold(
          backgroundColor: Colors.white60,
          body: SingleChildScrollView(
            child: Column(
              children: [
                Container(
                  color: Colors.deepOrangeAccent,
                  height: 150,
                  width: MediaQuery.of(context).size.width,
                  child: Padding(
                    padding: EdgeInsets.only(top: 50, left: 150),
                    child: Text("İlaç Bilgileri",
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 20,
                          color: Colors.white,
                        )),
                  ),
                ),
                Container(
                  height: deviceHeight / 2.1,
                  child: Card(
                      color: Colors.white70,
                      margin: EdgeInsets.only(top: 20, left: 10, right: 10),
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20)),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              Text(
                                "İlaç Adı:",
                                style: TextStyle(
                                    fontSize: 15, fontWeight: FontWeight.bold),
                              ),
                              IntrinsicWidth(
                                child: TextField(
                                  controller: _ilacAdiController,
                                  decoration: InputDecoration(
                                      hintText: "İlaç Giriniz."),
                                ),
                              ),
                            ],
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              Text(
                                "İlaç Türü:",
                                style: TextStyle(
                                    fontSize: 15,
                                    fontWeight: FontWeight.bold),
                              ),
                              Container(
                                height: 60,
                                width: deviceWidth/2,
                                child: FutureBuilder<List<Tur>>(
                                  future: futureIlacTuru,
                                  builder: (context, snapshot) {
                                    if (snapshot.connectionState ==
                                        ConnectionState.waiting) {
                                      return CircularProgressIndicator(); // Veri beklenirken gösterilecek şey
                                    } else if (snapshot.hasError) {
                                      return Text('Hata: ${snapshot.error}');
                                    } else if (!snapshot.hasData ||
                                        snapshot.data!.isEmpty) {
                                      return Text('Veri bulunamadı');
                                    } else {
                                      //
                                      List<
                                          DropdownMenuItem<
                                              String>> dropdownItems = snapshot
                                          .data!
                                          .where((Tur) =>
                                              Tur.turadi !=
                                              "Null")
                                          .map((Tur) =>
                                              DropdownMenuItem<String>(
                                                value: Tur.turadi.toString(),
                                                child: Text(
                                                    Tur.turadi ?? ''),
                                              ))
                                          .toList();

                                      return DropdownButton<String>(
                                        hint: Text('İlaç Türünü Seçin'),
                                        value: _selectedValue,
                                        onChanged: (String? newValue) {
                                          setState(() {
                                            _selectedValue = newValue;
                                          });
                                        },
                                        items: dropdownItems,
                                      );
                                    }
                                  },
                                ),
                              ),
                            ],
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              Text(
                                "Birim Fiyat:",
                                style: TextStyle(
                                    fontSize: 15, fontWeight: FontWeight.bold),
                              ),
                              IntrinsicWidth(
                                child: TextField(
                                  controller: _birimFiyatController,
                                  decoration: InputDecoration(
                                      hintText: "Fiyat Giriniz."),
                                ),
                              ),
                            ],
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              Text(
                                "Miktar:",
                                style: TextStyle(
                                    fontSize: 15, fontWeight: FontWeight.bold),
                              ),
                              IntrinsicWidth(
                                child: TextField(
                                  controller: _miktarController,
                                  decoration: InputDecoration(
                                      hintText: "Miktar Giriniz."),
                                ),
                              ),
                            ],
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              Text(
                                "TETT:",
                                style: TextStyle(
                                    fontSize: 15, fontWeight: FontWeight.bold),
                              ),
                              Container(
                                width: deviceWidth / 2,
                                child: TextField(
                                  controller: _dateController,
                                  decoration: InputDecoration(
                                      labelText: 'DATE',
                                      filled: true,
                                      prefixIcon: Icon(
                                        Icons.calendar_today,
                                        color: Colors.blue,
                                      ),
                                      enabledBorder: OutlineInputBorder(
                                          borderSide: BorderSide(
                                              color: Colors.white70)),
                                      focusedBorder: OutlineInputBorder(
                                          borderSide:
                                              BorderSide(color: Colors.blue))),
                                  readOnly: true,
                                  onTap: () {
                                    _selectDate();
                                  },
                                ),
                              )
                            ],
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              Text(
                                "Firma Adı:",
                                style: TextStyle(
                                    fontSize: 15, fontWeight: FontWeight.bold),
                              ),
                              IntrinsicWidth(
                                child: TextField(
                                  controller: _firmaAdiController,
                                  decoration: InputDecoration(
                                      hintText: "Firma Adı Giriniz."),
                                ),
                              ),
                            ],
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              Text(
                                "Seri No Giriniz:",
                                style: TextStyle(
                                    fontSize: 15, fontWeight: FontWeight.bold),
                              ),
                              IntrinsicWidth(
                                child: TextField(
                                  controller: _seriNoController,
                                  decoration: InputDecoration(
                                      hintText: "Seri No Giriniz."),
                                ),
                              ),
                            ],
                          ),
                        ],
                      )),
                ),
                ElevatedButton(
                    onPressed: _addIlac,
                    child: Text("İlaç Kaydet..."),
                    style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.white70,
                        shadowColor: Colors.black)),
                /**** ****/
                Container(
                  width: deviceWidth / 1.02,
                  child: Card(
                      color: Colors.white70,
                      child: FutureBuilder(
                          future: futureIlaclar, // futureIlaclar değişkeni, API'den veya veritabanından ilaç verilerini asenkron olarak almak için kullanılır.
                          builder: (context, snapshot) { // snapshot, futureIlaclar'ın durumunu ve sonucunu içerir.
                            if (snapshot.hasData) { // Eğer snapshot'ta veri varsa, yani future başarıyla tamamlandıysa bu blok çalışır.
                              List<Ilac> ilaclar = snapshot.data!; // snapshot'tan dönen veriler, List<Ilac> türünde bir listeye atanır.
                              return SingleChildScrollView( // Yatayda kaydırılabilir bir widget oluşturur. DataTable, yatayda genişse kaydırmayı sağlar.
                                scrollDirection: Axis.horizontal, // Yatay kaydırma yönünü belirler.
                                child: DataTable( // Verileri tablo formatında gösterir.
                                  columns: [
                                    DataColumn(label: Text('Ilac Id')), // İlaç ID sütunu başlığı
                                    DataColumn(label: Text('Ilac Adı')), // İlaç Adı sütunu başlığı
                                    DataColumn(label: Text('Ilac Türü')), // İlaç Türü sütunu başlığı
                                    DataColumn(label: Text('Birim Fiyat')), // Birim Fiyat sütunu başlığı
                                    DataColumn(label: Text('Miktar')), // Miktar sütunu başlığı
                                    DataColumn(label: Text('TETT')), // Son Kullanma Tarihi (TETT) sütunu başlığı
                                    DataColumn(label: Text('Firma Adı')), // Firma Adı sütunu başlığı
                                    DataColumn(label: Text('Seri No')), // Seri No sütunu başlığı
                                  ],
                                  rows: ilaclar.map((ilac) { // ilaclar listesindeki her bir İlaç için bir DataRow oluşturur.
                                    return DataRow(
                                      cells: [
                                        DataCell(Text(ilac.ilacid.toString())), // İlaç ID'sini hücrede gösterir.
                                        DataCell(Text(ilac.ilacAdi.toString())), // İlaç Adı'nı hücrede gösterir.
                                        DataCell(Text(ilac.ilacTuru as String)), // İlaç Türü'nü hücrede gösterir.
                                        DataCell(Text(ilac.BirimFiyat.toString())), // Birim Fiyat'ı hücrede gösterir.
                                        DataCell(Text(ilac.Miktar.toString())), // Miktar'ı hücrede gösterir.
                                        DataCell(Text(ilac.TETT.toString())), // Son Kullanma Tarihi'ni (TETT) hücrede gösterir.
                                        DataCell(Text(ilac.FirmaAdi as String)), // Firma Adı'nı hücrede gösterir.
                                        DataCell(Text(ilac.SeriNo as String)), // Seri No'yu hücrede gösterir.
                                      ],
                                    );
                                  }).toList(), // Map fonksiyonundan dönen DataRow listesini toList ile bir List<DataRow> yapısına çevirir.
                                ),
                              );
                            } else if (snapshot.hasError) { // Eğer future işlemi sırasında bir hata oluştuysa bu blok çalışır.
                              return Center(child: Text("${snapshot.error}")); // Hata mesajını ekranda gösterir.
                            }
                            return Center(child: CircularProgressIndicator()); // Eğer future henüz tamamlanmadıysa, bir yüklenme göstergesi (spinner) gösterir.
                          }
                      )),
                )
                /*** ******/
              ],
            ),
          ),
        ),
      ),
    );
  }

  Future<void> _selectDate() async {
    DateTime? _picked = await showDatePicker(
        context: context,
        firstDate: DateTime(2000),
        lastDate: DateTime(2025),
        initialDate: DateTime.now());

    if (_picked != null) {
      setState(() {
        _dateController.text = _picked.toString().split(" ")[0];
      });
    }
  }
}
