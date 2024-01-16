// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:final2/Calisan.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';
import 'DB_Yardimci.dart';
import 'package:flutter/material.dart';

import 'MyMapScreen.dart';

class YeniCalisanEkle extends StatefulWidget {
  const YeniCalisanEkle({super.key});

  @override
  State<YeniCalisanEkle> createState() => _YeniCalisanEkleState();
}

class _YeniCalisanEkleState extends State<YeniCalisanEkle> {
  String kisiAd = '';
  String kisiTC = '';
  String departman = '';
  int maas = 0;
  double calisanYili = 0;

  Calisan calisan = Calisan(
    resimYolu: '',
    adresYolu: '',
    kisiAd: '',
    kisiTC: '',
    departman: '',
    maas: 0,
    calisanYili: 0,
  );

  File? _pickedImage;
  Future<void> _pickImage() async {
    final picker = ImagePicker();
    final pickedImage = await picker.pickImage(source: ImageSource.gallery);

    if (pickedImage != null) {
      setState(() {
        _pickedImage = File(pickedImage.path);
      });
    }
  }

  Future<void> _calisanKaydet(BuildContext context) async {
    Calisan calisan = Calisan(
      resimYolu: _pickedImage?.path ?? '',
      adresYolu: '',
      kisiAd: kisiAd,
      kisiTC: kisiTC,
      departman: departman,
      maas: maas,
      calisanYili: calisanYili.toInt(),
    );
    await DBYardimci.CalisanEkle(calisan);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Calisan Ekle")),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: SizedBox(
                  height: 30,
                  width: 250,
                  child: ElevatedButton(
                    onPressed: _pickImage,
                    child: Text('Kişi Resmi Ekle'),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextField(
                  decoration: InputDecoration(
                    labelText: "Kişi Adı",
                    filled: true,
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(50),
                    ),
                  ),
                  onChanged: (value) {
                    setState(() {
                      kisiAd = value;
                    });
                  },
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextField(
                  decoration: InputDecoration(
                    labelText: "Kişi T.C. Kimlik No",
                    filled: true,
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(50),
                    ),
                  ),
                  onChanged: (value) {
                    setState(() {
                      kisiTC = value;
                    });
                  },
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextField(
                  decoration: InputDecoration(
                    labelText: "Kişi Departman",
                    filled: true,
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(50),
                    ),
                  ),
                  onChanged: (value) {
                    setState(() {
                      departman = value;
                    });
                  },
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextField(
                  decoration: InputDecoration(
                    labelText: "Kişi Maaş",
                    filled: true,
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(50),
                    ),
                  ),
                  onChanged: (value) {
                    setState(() {
                      maas = int.parse(value);
                    });
                  },
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  'Çalışma Yılı : ',
                  style: TextStyle(fontSize: 20),
                ),
              ),
              Slider(
                value: calisanYili,
                min: 0,
                max: 30,
                divisions: 30,
                activeColor: Colors.green,
                thumbColor: Colors.amber,
                inactiveColor: Colors.red,
                label: calisanYili.toInt().toString(),
                onChanged: (value) {
                  setState(() {
                    calisanYili = value;
                  });
                },
              ),
              ElevatedButton(
                child: Text('Google Haritaları Aç'),
                onPressed: () {
                  /*Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) {},//MyMapScreen()),
                  );*/
                },
              ),
              ElevatedButton(
                onPressed: () => _calisanKaydet(context),
                child: Text("Kayıt"),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
