class Event {
  final int? id;
  final String title;
  final DateTime startDate;
  final DateTime endDate;
  final int attendees;
  final String imagePath;
  bool isSelected;
  double sliderValue;

  Event({
    this.id,
    required this.title,
    required this.startDate,
    required this.endDate,
    required this.attendees,
    required this.imagePath,
    this.isSelected = false,
    this.sliderValue = 0.0,
  });
  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'title': title,
      'start_date': startDate.toIso8601String(),
      'end_date': endDate.toIso8601String(),
      'attendees': attendees,
      'imagePath': imagePath
    };
  }
}
