import 'package:flutter/material.dart';
import 'package:pharmacy_project/screens/ilac.dart';
import 'package:pharmacy_project/screens/musteri.dart';


void main() {
  runApp(new MaterialApp(
  home:pharmacy()));
}



class pharmacy extends StatefulWidget {
  const pharmacy({super.key});

  @override
  State<pharmacy> createState() => _pharmacyState();
}

class _pharmacyState extends State<pharmacy> {

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        body: Column(
          children: [
            Container(
              color: Colors.orangeAccent,
              height: 150,
              width: MediaQuery.of(context).size.width,
              child: Center(
                child: Text(
                  "Eczaneye Hoşgeldiniz...",
                  style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                      fontSize: 17),
                ),
              ),
            ),
            Container(
              child: Expanded(
                child: Column(
                  children: [
                    ElevatedButton(
                      onPressed: () {
                        Navigator.of(context).push(new MaterialPageRoute(
                            builder: (context) => ilac()));
                      },
                      style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.white70,
                          padding: EdgeInsets.symmetric(horizontal: 60),
                          shadowColor: Colors.black),
                      child: Text(
                        "İlaçlar...",
                        style: TextStyle(
                            fontSize: 15, fontWeight: FontWeight.bold),
                      ),
                    ),
                    ElevatedButton(
                        onPressed: () {
                          Navigator.of(context).push(new MaterialPageRoute(builder: (context) =>
                          Musteri()));
                        },
                        child: Text("Müşteri Hesapları..."),
                        style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.white70,
                            shadowColor: Colors.black)),
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
