// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:odev5/Uygulama5.dart';

void main() {
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Uygulama5(),
    );
  }
}
