// ignore_for_file: prefer_const_constructors

import 'dart:io';

import 'package:final2/Calisan.dart';
import 'package:final2/DB_Yardimci.dart';
import 'package:final2/maas.dart';
import 'package:flutter/material.dart';
import 'dart:async';

class CalisanMaasBordro extends StatefulWidget {
  const CalisanMaasBordro({super.key});

  @override
  State<CalisanMaasBordro> createState() => _CalisanMaasBordroState();
}

class _CalisanMaasBordroState extends State<CalisanMaasBordro> {
  String kisiTC = '';
  List<Maas> maaslar = [];
  List<Calisan> calisanlar = [];
  String imagePath =
      '/data/user/0/com.example.final2/cache/27246e79-4854-4a9b-8cc9-cc7c84d8f48d/download.jpg';
  String selectedMaaslar = '';
  TextEditingController TCController = TextEditingController();
  Future<void> _loadEvents() async {
    List<Calisan> loadedEvents = await DBYardimci.CalisanGetir();
    List<Maas> loadedBordros = await DBYardimci.MaasGetir();
    setState(() {
      calisanlar = loadedEvents;
      maaslar = loadedBordros;
    });
  }

  @override
  void initState() {
    super.initState();
    _loadEvents();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Calisan Maas ve Bordro Sorgulama",
          style: TextStyle(fontSize: 14),
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextField(
                  controller: TCController,
                  decoration: InputDecoration(
                    labelText: "Kişi T.C. Kimlik No",
                    filled: true,
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(50),
                    ),
                  ),
                  onChanged: (value) {
                    setState(() {
                      kisiTC = value.toString();
                    });
                  },
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: ElevatedButton(
                  onPressed: () async {
                    kisiTC = TCController.text;
                    print("TC: $kisiTC");
                    imagePath = await DBYardimci.ResimYolu(kisiTC);
                    selectedMaaslar = await DBYardimci.Maaslar(kisiTC);
                  },
                  child: Text("Maaş Bordrosu"),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Container(
                  width: double.infinity,
                  height: 600,
                  color: Colors.amberAccent,
                  child: Column(
                    children: [
                      Container(
                        height: 200,
                        width: 200,
                        child: InteractiveViewer(
                          child: Image.file(File(imagePath)),
                          panEnabled: true, // Pan hareketini etkinleştirir
                          boundaryMargin: EdgeInsets.all(80), // Sınır boşluğu
                          minScale: 0.5, // Minimum zoom oranı
                          maxScale: 4, // Maksimum zoom oranı
                        ),
                      ),
                      Container(
                        height: 400,
                        width: 400,
                        color: Colors.green,
                        child: Text(
                          selectedMaaslar,
                          style: TextStyle(fontSize: 20),
                        ),
                      ),
                    ],
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
