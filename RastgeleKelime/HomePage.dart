// ignore_for_file: prefer_const_constructors

import 'dart:math';

import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  TextEditingController harf = TextEditingController();
  String text = "";
  Random random = Random();
  List<String>? content1;
  List<String>? content2;
  List<String>? content3;
  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.blue,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          Container(
            padding: EdgeInsets.all(30),
            margin: EdgeInsets.only(top: 30),
            width: 200,
            height: 150,
            decoration: BoxDecoration(
              color: Colors.yellow,
              shape: BoxShape.rectangle,
              border: Border.all(
                width: 4,
                color: Colors.red,
              ),
              borderRadius: BorderRadius.circular(100),
            ),
            child: Center(
              child: TextField(
                controller: harf,
                style: TextStyle(color: Colors.black),
                onSubmitted: (value) {
                  _checkInput(value);
                },
                decoration: InputDecoration(
                  filled: true,
                  fillColor: Colors.white,
                  border: OutlineInputBorder(),
                ),
              ),
            ),
          ),
          Padding(padding: EdgeInsets.all(20)),
          Expanded(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                //buildColumn("Sütun1", content),
                Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    safeArea("Sütun1", "4 Harfli", 4, content1),
                    ElevatedButton(
                      onPressed: () {
                        setState(() {
                          content1 = generateWords(4, harf.text);
                        });
                      },
                      child: Text("4 Harfli"),
                    ),
                  ],
                ),
                Column(
                  children: [
                    safeArea("Sütun2", "5 Harfli", 5, content2),
                    ElevatedButton(
                      onPressed: () {
                        setState(() {
                          content2 = generateWords(5, harf.text);
                        });
                      },
                      child: Text("5 Harfli"),
                    ),
                  ],
                ),
                Column(
                  children: [
                    safeArea("Sütun3", "6 Harfli", 6, content3),
                    ElevatedButton(
                      onPressed: () {
                        setState(() {
                          content3 = generateWords(6, harf.text);
                        });
                      },
                      child: Text("6 Harfli"),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  SafeArea safeArea(
      String sutun, String buton, int length, List<String>? content) {
    return SafeArea(
      child: SizedBox(
        width: 100,
        child: Column(
          children: [
            Container(
              child: Center(child: Text(sutun)),
              color: Colors.grey,
              width: 100,
            ),
            Container(
              color: Colors.grey[300],
              padding: const EdgeInsets.all(8.0), // Padding eklendi.
              child: content != null
                  ? Column(
                      children: content
                          .map((item) => Text(
                                item,
                                textAlign: TextAlign.center,
                              ))
                          .toList(),
                    )
                  : const Center(
                      child: Text(
                        'Liste boş',
                        textAlign: TextAlign.center,
                      ),
                    ),
            ),
          ],
        ),
      ),
    );
  }

  List<String> generateWords(int length, String harf) {
    List<String> result = [];
    List<String> c = harf.split('');
    int mode = harf.length;
    String s;
    for (int i = 0; i < 20; i++) {
      s = "";
      for (int j = 0; j < length; j++) {
        s += c[random.nextInt(mode)];
      }
      result.add(s);
    }
    return result;
  }

  void _showAlertDialog(String message) {
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

  void _checkInput(String input) {
    RegExp regex = RegExp(r'^[a-zA-Z]+$');
    if (input.length < 6 || !regex.hasMatch(input)) {
      _showAlertDialog('Yalnızca harf giriniz. Minimum 6 harf olmalıdır!');
    }
  }
}
