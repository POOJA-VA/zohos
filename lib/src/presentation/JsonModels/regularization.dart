import 'package:flutter/material.dart';

class RegularizationData {
  final int? id;
  final String employeeName;
  final String date;
  final TimeOfDay checkInTime;
  final TimeOfDay checkOutTime;
  final int hours;
  final String dropdownValue;

  RegularizationData({
    this.id,
    required this.employeeName,
    required this.date,
    required this.checkInTime,
    required this.checkOutTime,
    required this.hours,
    required this.dropdownValue,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'employeeName': employeeName,
      'date': date.toString(),
      'checkInTime': '${checkInTime.hour}:${checkInTime.minute}',
      'checkOutTime': '${checkOutTime.hour}:${checkOutTime.minute}',
      'hours': hours,
      'dropdownValue': dropdownValue,
    };
  }

  factory RegularizationData.fromMap(Map<String, dynamic> map) {
    late TimeOfDay checkInTime;
    late TimeOfDay checkOutTime;
    try {
       checkInTime = TimeOfDay(
        hour: int.parse(map['checkInTime'].split(':')[0]),
        minute: int.parse(map['checkInTime'].split(':')[1]),
      );
      // Use the parsed checkInTime
    } catch (e) {
      print("Error parsing check-in time: $e");
      // Handle the error gracefully
    }

    try {
      checkOutTime = TimeOfDay(
        hour: int.parse(map['checkOutTime'].split(':')[0]),
        minute: int.parse(map['checkOutTime'].split(':')[1]),
      );
      // Use the parsed checkOutTime
    } catch (e) {
      print("Error parsing check-out time: $e");
      // Handle the error gracefully
    }

    return RegularizationData(
      id: map['id'],
      employeeName: map['employeeName'],
      date: map['date'].toString(),
      checkInTime: checkInTime,
      checkOutTime: checkOutTime,
      hours: map['hours'],
      dropdownValue: map['dropdownValue'],
    );
  }
}
