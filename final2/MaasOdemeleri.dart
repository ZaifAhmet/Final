// ignore_for_file: prefer_const_constructors, sort_child_properties_last

import 'package:final2/Calisan.dart';
import 'package:final2/DB_Yardimci.dart';
import 'package:final2/maas.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class MaasOdemeleri extends StatefulWidget {
  const MaasOdemeleri({super.key});

  @override
  State<MaasOdemeleri> createState() => _MaasOdemeleriState();
}

class _MaasOdemeleriState extends State<MaasOdemeleri> {
  List<Calisan> calisanlar = [];
  List<Maas> maaslar = [];
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
    // TODO: implement initState
    super.initState();
    _loadEvents();
  }

  String valueChoose = '0';
  double maas = 10;
  String maasTarihi = DateFormat('yyyy-MM-dd').format(DateTime.now());
  int sayac = 0;
  int zamlisayac = 0;
  String kisiTC = '';

  Maas maasEk = Maas(maas: 0, maasTarihi: '', kisiTC: '');

  Future<void> _maasKaydet(BuildContext context) async {
    for (int i = 0; i < calisanlar.length; i++) {
      if (calisanlar[i].kisiTC.endsWith(valueChoose)) {
        print("Ekleniyor");
        kisiTC = calisanlar[i].kisiTC;
        sayac++;
        if (calisanlar[i].calisanYili > 10 && calisanlar[i].calisanYili < 20) {
          maas = (maas * (1.15));
          zamlisayac++;
        }
        if (calisanlar[i].calisanYili > 20) {
          zamlisayac++;
          maas = (maas * (1.25));
        }
        Maas maasEk = Maas(
          maasTarihi: maasTarihi,
          kisiTC: kisiTC,
          maas: maas,
        );
        await DBYardimci.MaasEkle(maasEk);
      }
    }
  }

  List listItem = ["0", "2", "4", "6", "8"];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Maas Odeme"),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Center(
                child: DropdownButton(
                  dropdownColor: Colors.grey,
                  hint: Text("TC'nin son hanesi"),
                  icon: Icon(Icons.arrow_downward),
                  isExpanded: true,
                  items: listItem.map((valueItem) {
                    return DropdownMenuItem(
                      child: Text(valueItem),
                      value: valueItem,
                    );
                  }).toList(),
                  onChanged: (value) {
                    valueChoose = value.toString();
                  },
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextField(
                decoration: InputDecoration(
                  labelText: "Yatırılacak maası girin",
                  filled: true,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(50),
                  ),
                ),
                onChanged: (value) {
                  setState(() {
                    maas = double.parse(value);
                    maasTarihi =
                        DateFormat('yyyy-MM-dd').format(DateTime.now());
                    print("maas $maas , tarih $maasTarihi");
                  });
                },
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: ElevatedButton(
                  onPressed: () {
                    _maasKaydet(context);
                    showDialog(
                        context: context,
                        builder: (context) => AlertDialog(
                              actions: [
                                TextButton(
                                  onPressed: () {
                                    Navigator.of(context).pop();
                                  },
                                  child: Text("Kapat"),
                                )
                              ],
                              title: Text("Pop-up Mesajı"),
                              contentPadding: EdgeInsets.all(20.0),
                              content: Text(
                                  "$sayac çalışana girilen miktar yatırılmıştır.$zamlisayac çalışana zamlı miktar yatırılmıştır"),
                            ));
                  },
                  child: Text("Maaş Yatır")),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: ElevatedButton(
                onPressed: () {
                  for (int i = 0; i < calisanlar.length; i++) {
                    print(
                        "${calisanlar[i].calisanYili} ,${calisanlar[i].kisiTC}, ${calisanlar[i].resimYolu}");
                  }
                },
                child: Text("Calisanlar"),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: ElevatedButton(
                onPressed: () {
                  for (int i = 0; i < maaslar.length; i++) {
                    print(
                        "${maaslar[i].kisiTC} ,${maaslar[i].maas}, ${maaslar[i].maasTarihi}");
                  }
                },
                child: Text("maaslar"),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
