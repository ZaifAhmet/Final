// ignore_for_file: prefer_const_constructors

import 'package:deneme111/DB_Yard%C4%B1mc%C4%B1.dart';
import 'package:deneme111/YeniEtkinlikEkleme.dart';
import 'package:deneme111/Etkinlik_kart%C4%B1.dart';
import 'package:flutter/material.dart';
import 'Etkinlik.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(primarySwatch: Colors.orange),
      home: const MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  List<Event> events = [];

  void deleteSelectedEvents() async {
    print('Silme işlemi başladı.');
    List<Event> selectedEvents = events
        .where((event) =>
            event.isSelected && event.endDate.isBefore(DateTime.now()))
        .toList();

    for (var event in selectedEvents) {
      if (event.id != null) {
        print('Silinecek etkinlik ID: ${event.id}');
        await DBHelper.deleteEvent(event.id!);
      }
    }

    var updatedEvents = await DBHelper.getEvents();
    setState(() {
      events = updatedEvents;
    });
    print('Silme işlemi tamamlandı ve etkinlikler yeniden yükleniyor.');
  }

  @override
  void initState() {
    super.initState();
    _loadEvents();
  }

  Future<void> _loadEvents() async {
    List<Event> loadedEvents = await DBHelper.getEvents();
    setState(() {
      events = loadedEvents;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.red,
        title: const Text("Etkinlik Planlayıcı"),
      ),
      body: ListView.builder(
        itemCount: events.length,
        itemBuilder: (ctx, i) {
          if (events[i].title.isEmpty) {
            return Container();
          }
          return EventCard(
            event: events[i],
            onCheckboxChanged: (bool? newValue) {
              setState(() {
                events[i].isSelected = newValue ?? false;
              });
            },
            onSliderChanged: (double value) {
              setState(() {
                events[i].sliderValue = value;
              });
            },
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => NewEventPage()),
          ).then((_) {});
        },
        child: const Icon(Icons.add),
      ),
      bottomNavigationBar: BottomAppBar(
        shape: CircularNotchedRectangle(),
        notchMargin: 6.0,
        child: Row(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            ElevatedButton(
              onPressed: deleteSelectedEvents,
              child: Text("Sil"),
            ),
            ElevatedButton(
              onPressed: () async {
                await DBHelper.deleteAllEvents();
                print('Veritabanı temizlendi.');

                List<Event> updatedEvents = await DBHelper.getEvents();

                setState(() {
                  events = updatedEvents;
                });
              },
              child: Text('Tabloyu Temizle'),
            ),
          ],
        ),
      ),
    );
  }
}
