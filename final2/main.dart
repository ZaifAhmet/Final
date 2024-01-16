// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:final2/CalisanMaasBordro.dart';
import 'package:final2/MaasOdemeleri.dart';
import 'package:final2/YeniCalisanEkle.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: DefaultTabController(
          length: 3,
          child: Scaffold(
            bottomNavigationBar: BottomAppBar(
              color: Colors.green,
              child: TabBar(tabs: [
                Tab(
                  text: 'Çalışan Ekle',
                ),
                Tab(
                  text: 'Çalışan Bordro',
                ),
                Tab(
                  text: 'Maaş Yatır',
                ),
              ]),
            ),
            body: TabBarView(children: [
              YeniCalisanEkle(),
              CalisanMaasBordro(),
              MaasOdemeleri(),
            ]),
          )),
    );
  }
}
