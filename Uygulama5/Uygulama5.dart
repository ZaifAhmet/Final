// ignore_for_file: prefer_const_constructors, sort_child_properties_last, non_constant_identifier_names, camel_case_types

import 'dart:math';

import 'package:flutter/material.dart';

class Uygulama5 extends StatefulWidget {
  const Uygulama5({super.key});

  @override
  State<Uygulama5> createState() => _Uygulama5State();
}

class _Uygulama5State extends State<Uygulama5> {
  TextEditingController textField_text = TextEditingController();
  String container_text = "";
  List<Color> gestureColor = List<Color>.generate(16, (index) => Colors.amber);
  double containerFontSize = 10;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        title: const Text("Ödev 5"),
      ),
      body: Column(
        children: [
          Padding(
            padding: EdgeInsets.only(top: 30),
            child: Center(
              child: TextField(
                controller: textField_text,
                style: TextStyle(color: Colors.white),
                decoration: InputDecoration(
                  filled: true,
                  fillColor: Color.fromARGB(238, 66, 146, 184),
                  border: OutlineInputBorder(),
                  constraints: BoxConstraints(maxHeight: 50, maxWidth: 300),
                ),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(10.0),
            child: ElevatedButton(
              onPressed: () {
                container_text = textField_text.text;
                setState(() {});
              },
              child: SizedBox(
                width: 130,
                height: 50,
                child: Center(child: Text("Buton")),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 10.0),
            child: GestureDetector(
              onDoubleTap: () {
                setState(() {
                  containerFontSize += 2;
                });
              },
              onLongPress: () {
                setState(() {
                  containerFontSize = 10;
                });
              },
              child: Container(
                child: Center(
                  child: Text(
                    container_text,
                    style: TextStyle(fontSize: containerFontSize),
                    selectionColor: Colors.black,
                  ),
                ),
                height: 150,
                width: 300,
                color: Colors.green,
              ),
            ),
          ),
          Divider(
            height: 248,
            thickness: 4,
            color: Colors.white,
          ),
          Expanded(
            child: SizedBox(
              child: GridView.builder(
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 4,
                  childAspectRatio: 2 / 1,
                ),
                itemCount: gestureColor.length,
                itemBuilder: (context, index) {
                  return GestureDetector(
                    onTap: () {
                      setState(() {
                        gestureColor[index] = getRandomColor();
                      });
                    },
                    child: Padding(
                      padding: const EdgeInsets.all(2.0),
                      child: Container(
                        color: gestureColor.elementAt(index),
                      ),
                    ),
                  );
                },
              ),
            ),
          )
        ],
      ),
    );
  }

  Color getRandomColor() {
    Random random = Random();
    return Color.fromARGB(
        255, random.nextInt(255), random.nextInt(255), random.nextInt(255));
  }
}
