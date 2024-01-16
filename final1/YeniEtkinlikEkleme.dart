// ignore_for_file: prefer_const_constructors

import 'package:deneme111/DB_Yard%C4%B1mc%C4%B1.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';

import 'Etkinlik.dart';

class NewEventPage extends StatefulWidget {
  @override
  _NewEventPageState createState() => _NewEventPageState();
}

class _NewEventPageState extends State<NewEventPage> {
  double attendees = 500;
  String eventName = '';
  DateTime selectedDate = DateTime.now();

  File? _pickedImage;
  Event event = Event(
    title: '',
    startDate: DateTime.now(),
    endDate: DateTime.now(),
    attendees: 0,
    imagePath: '',
    sliderValue: 0.0,
  );

  Future<void> _pickImage() async {
    final picker = ImagePicker();
    final pickedImage = await picker.pickImage(source: ImageSource.gallery);

    if (pickedImage != null) {
      setState(() {
        _pickedImage = File(pickedImage.path);
      });
    }
  }

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: selectedDate,
      firstDate: DateTime.now(),
      lastDate: DateTime(2025),
    );
    if (picked != null && picked != selectedDate)
      setState(() {
        selectedDate = picked;
      });
  }

  void _saveEvent(BuildContext context) async {
    final newEvent = Event(
      title: eventName,
      startDate: selectedDate,
      endDate: selectedDate,
      attendees: attendees.toInt(),
      imagePath: _pickedImage?.path ?? '',
    );

    await DBHelper.insertEvent(newEvent);

    Navigator.of(context).pop();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.green,
        title: Text('Etkinlik Planlayıcı'),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(8.0),
          child: Column(
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  'Kişi Sayısı: ',
                  style: TextStyle(fontSize: 20),
                ),
              ),
              Slider(
                value: attendees,
                min: 0,
                max: 1000,
                divisions: 1000,
                activeColor: Colors.green,
                thumbColor: Colors.amber,
                inactiveColor: Colors.red,
                label: attendees.toInt().toString(),
                onChanged: (value) {
                  setState(() {
                    attendees = value;
                  });
                },
              ),
              SizedBox(height: 20),
              TextField(
                decoration: InputDecoration(
                  labelText: "Etkinlik Adı",
                  filled: true,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(50),
                  ),
                ),
                onChanged: (value) {
                  setState(() {
                    eventName = value;
                  });
                },
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: SizedBox(
                  height: 50,
                  width: 250,
                  child: ElevatedButton(
                    onPressed: () => _selectDate(context),
                    child: Text('Bir tarih seç'),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: SizedBox(
                  height: 30,
                  width: 250,
                  child: ElevatedButton(
                    onPressed: _pickImage,
                    child: Text('Resim Ekle'),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: ElevatedButton(
                  onPressed: () => _saveEvent(context),
                  child: Text('Button'),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
