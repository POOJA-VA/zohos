class CheckInOut {
  final int id;
  final String title;
  final String hours;

  CheckInOut({
    required this.id,
    required this.title,
    required this.hours,
  });

  factory CheckInOut.fromMap(Map<String, dynamic> map) {
    return CheckInOut(
      id: map['id'],
      title: map['title'],
      hours: map['hours'],
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'title': title,
      'hours': hours,
    };
  }
}