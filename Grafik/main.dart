// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables, sort_child_properties_last, avoid_print

import 'package:flutter/material.dart';
import 'package:odev6/grafik.dart';
import 'package:odev6/grafik_bilgileri.dart';

void main() {
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: Text("Odev 5"),
        ),
        body: myPopUpMenuItem(),
      ),
    );
  }
}

class myPopUpMenuItem extends StatelessWidget {
  myPopUpMenuItem({super.key});
  Veri veri = Veri(x: '0', y: '0', altbaslik: 'x', solbaslik: 'y');

  @override
  Widget build(BuildContext context) {
    return Container(
      child: PopupMenuButton(
        itemBuilder: (context) {
          return <PopupMenuEntry>[
            PopupMenuItem(
              child: Text("Grafik Bilgileri"),
              value: 1,
            ),
            PopupMenuItem(
              child: Text("Grafik"),
              value: 2,
            ),
          ];
        },
        onSelected: (value) async {
          switch (value) {
            case 1:
              veri = await Navigator.push(context, MaterialPageRoute(
                builder: (context) {
                  return grafik_bilgileri();
                },
              ));

              break;
            case 2:
              // ignore: use_build_context_synchronously
              Navigator.push(context, MaterialPageRoute(
                builder: (context) {
                  return grafik(
                    xDegerleri: veri.x,
                    yDegerleri: veri.y,
                    solbaslik: veri.solbaslik,
                    altbaslik: veri.altbaslik,
                  );
                },
              ));
              break;
          }
        },
      ),
      color: Colors.blue,
    );
  }
}
