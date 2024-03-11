// ignore_for_file: public_member_api_docs, sort_constructors_first
// ignore_for_file: prefer_const_literals_to_create_immutables, prefer_const_constructors

import 'package:flutter/material.dart';

class grafik_bilgileri extends StatefulWidget {
  const grafik_bilgileri({super.key});

  @override
  State<grafik_bilgileri> createState() => _grafik_bilgileriState();
}

class _grafik_bilgileriState extends State<grafik_bilgileri> {
  @override
  Widget build(BuildContext context) {
    TextEditingController xDegerleri = TextEditingController();
    TextEditingController yDegerleri = TextEditingController();
    TextEditingController solBaslik = TextEditingController();
    TextEditingController altBaslik = TextEditingController();

    return Scaffold(
      appBar: AppBar(
        title: Text("Grafik Bilgileri"),
        centerTitle: true,
      ),
      body: Container(
        color: Colors.blue,
        child: Column(
          children: [
            Padding(
              padding: EdgeInsets.all(10),
              child: Container(
                color: Colors.white,
                child: TextField(
                  controller: xDegerleri,
                  decoration: InputDecoration(
                    hintText: "X ekseni girdisi",
                    border: OutlineInputBorder(),
                  ),
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.all(10),
              child: Container(
                color: Colors.white,
                child: TextField(
                  controller: yDegerleri,
                  decoration: InputDecoration(
                    hintText: "Y ekseni girdisi",
                    border: OutlineInputBorder(),
                  ),
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.all(10),
              child: Container(
                color: Colors.white,
                child: TextField(
                  controller: solBaslik,
                  decoration: InputDecoration(
                    hintText: "Grafik sol başlık",
                    border: OutlineInputBorder(),
                  ),
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.all(10),
              child: Container(
                color: Colors.white,
                child: TextField(
                  controller: altBaslik,
                  decoration: InputDecoration(
                    hintText: "Grafik alt başlık",
                    border: OutlineInputBorder(),
                  ),
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.all(20),
              child: ElevatedButton(
                onPressed: () {
                  if (_checkInput(xDegerleri.text, yDegerleri.text)) {
                    Veri veri = Veri(
                        x: xDegerleri.text,
                        y: yDegerleri.text,
                        altbaslik: altBaslik.text,
                        solbaslik: solBaslik.text);
                    Navigator.pop(context, veri);
                  }
                },
                child: Text("Çiz Butonu"),
              ),
            ),
          ],
        ),
      ),
    );
  }

  bool _checkInput(String inputx, String inputy) {
    RegExp regex = RegExp(r'^[0-9\s]*$');
    if (inputx.split(" ").length != inputy.split(" ").length) {
      _showAlertDialog(context, 'X ve Y değerlerinin sayısı eşit değil');
      return false;
    } else if (!regex.hasMatch(inputx) || !regex.hasMatch(inputy)) {
      _showAlertDialog(context, "Yalnızca sayı girin!");
      return false;
    }
    return true;
  }

  void _showAlertDialog(BuildContext context, String message) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Hata'),
          content: Text(message),
          actions: <Widget>[
            TextButton(
              child: Text('Tamam'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }
}

class Veri {
  final String x;
  final String y;
  final String altbaslik;
  final String solbaslik;

  Veri(
      {required this.x,
      required this.y,
      required this.altbaslik,
      required this.solbaslik});
}
