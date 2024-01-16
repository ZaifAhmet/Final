import 'package:flutter/material.dart';

// ignore: depend_on_referenced_packages

import 'dart:io';
import 'package:intl/intl.dart';

import 'Etkinlik.dart';

class EventCard extends StatelessWidget {
  final Event event;
  final ValueChanged<bool?> onCheckboxChanged;

  final ValueChanged<double> onSliderChanged;

  EventCard({
    Key? key,
    required this.event,
    required this.onCheckboxChanged,
    required this.onSliderChanged,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final now = DateTime.now();
    final daysLeft = event.endDate.difference(now).inDays;
    double sliderValue;

    if (daysLeft >= 100) {
      sliderValue = 0.0;
    } else {
      sliderValue = 100.0 - daysLeft;
    }

    return Card(
      child: Column(
        children: <Widget>[
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget>[
              CircleAvatar(
                backgroundImage: event.imagePath.isNotEmpty
                    ? FileImage(File(event.imagePath))
                    : null,
                child: event.imagePath.isEmpty ? Text(event.title[0]) : null,
              ),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(
                        event.title,
                        style: TextStyle(fontSize: 20),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(
                        DateFormat('yyyy-MM-dd').format(event.startDate),
                        style: TextStyle(fontSize: 20),
                      ),
                    ),
                  ],
                ),
              ),
              Text('KS : ${event.attendees}', style: TextStyle(fontSize: 24)),
              Checkbox(
                value: event.isSelected,
                onChanged: onCheckboxChanged,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.all(Radius.circular(6))),
              ),
            ],
          ),
          Slider(
            value: sliderValue,
            min: 0.0,
            max: 100.0,
            divisions: 100,
            onChanged: null,
          ),
        ],
      ),
    );
  }
}
