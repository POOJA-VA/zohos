import 'dart:async';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:provider/provider.dart';
import 'package:intl/intl.dart';
import 'package:zoho/src/data/datasource/sqlite.dart';
import 'package:zoho/src/presentation/views/User/login.dart';

class CheckInProvider extends ChangeNotifier {
  late Timer _timer;
  int _hours = 0;
  int _minutes = 0;
  int _seconds = 0;
  bool _isCheckedIn = false;
  DateTime? _checkInTime;
  DateTime? _checkOutTime;
  List<Map<String, dynamic>> _checkInOutList = [];
  late DatabaseHelper _databaseHelper;

  CheckInProvider() {
    _databaseHelper = DatabaseHelper();
  }

  int get hours => _hours;
  int get minutes => _minutes;
  int get seconds => _seconds;
  bool get isCheckedIn => _isCheckedIn;
  DateTime? get checkInTime => _checkInTime;
  DateTime? get checkOutTime => _checkOutTime;
  void startTimer() {
    _timer = Timer.periodic(Duration(seconds: 1), (timer) {
      _seconds++;
      if (_seconds == 60) {
        _seconds = 0;
        _minutes++;
        if (_minutes == 60) {
          _minutes = 0;
          _hours++;
        }
      }
      notifyListeners();
    });
  }

  void stopTimer() {
    _timer.cancel();
  }

  Future<void> toggleCheckIn() async {
    _isCheckedIn = !_isCheckedIn;
    if (_isCheckedIn) {
      _checkInTime = DateTime.now();
      startTimer();
    } else {
      _checkOutTime = DateTime.now();
      stopTimer();
      await _saveCheckInOut();
    }
    notifyListeners();
  }

  Future<void> _saveCheckInOut() async {
    final DateFormat formatter = DateFormat('HH:mm:ss');
    final String formattedCheckInTime = formatter.format(_checkInTime!);
    final String formattedCheckOutTime = formatter.format(_checkOutTime!);
    final String formattedDate =
        DateFormat('EEEE, dd MMMM').format(_checkInTime!);

    final Map<String, dynamic> data = {
      'title': formattedDate,
      'checkin': formattedCheckInTime,
      'checkout': formattedCheckOutTime,
      'hours': _calculateHours(_checkInTime!, _checkOutTime!),
    };

    await _databaseHelper.insertReport(data);
    _checkInOutList = await _databaseHelper.getReports();
    notifyListeners();
  }

  String _calculateHours(DateTime checkInTime, DateTime checkOutTime) {
    final Duration difference = checkOutTime.difference(checkInTime);
    final int hours = difference.inHours;
    final int minutes = difference.inMinutes.remainder(60);
    return '$hours:${minutes.toString().padLeft(2, '0')}';
  }

  List<Map<String, dynamic>> get checkInOutList => _checkInOutList;
}

class Body extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    DateTime now = DateTime.now();
    String formattedDate = DateFormat('EEE, dd MMM').format(now);
    return Consumer<CheckInProvider>(
      builder: (context, checkInProvider, _) {
        return Scaffold(
          appBar: AppBar(
            title: Text(
              'Home',
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            leading: IconButton(
              icon: CircleAvatar(
                backgroundImage: NetworkImage(
                  'https://img.freepik.com/free-photo/young-beautiful-woman-pink-warm-sweater-natural-look-smiling-portrait-isolated-long-hair_285396-896.jpg',
                ),
              ),
              onPressed: () {
                showModalBottomSheet(
                  context: context,
                  builder: (BuildContext context) {
                    return SizedBox(
                      height: 400,
                      child: Center(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            CircleAvatar(
                              radius: 70,
                              backgroundImage: NetworkImage(
                                'https://img.freepik.com/free-photo/young-beautiful-woman-pink-warm-sweater-natural-look-smiling-portrait-isolated-long-hair_285396-896.jpg',
                              ),
                            ),
                            Text('Santra Richard',
                                style: TextStyle(
                                    fontWeight: FontWeight.bold, fontSize: 20)),
                            Text('Product Designer',
                                style: TextStyle(
                                    fontSize: 15, color: Colors.grey)),
                            SizedBox(
                              height: 20,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: <Widget>[
                                    Text(
                                      'Date',
                                      style: TextStyle(
                                        fontSize: 14,
                                        color: Colors.grey,
                                      ),
                                    ),
                                    Text(
                                      formattedDate, // Display formatted date
                                      style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 20,
                                      ),
                                    ),
                                  ],
                                ),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: <Widget>[
                                    Text(
                                      'Employee Id',
                                      style: TextStyle(
                                        fontSize: 14,
                                        color: Colors.grey,
                                      ),
                                    ),
                                    Text(
                                      '3445',
                                      style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 20,
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                            ElevatedButton(
                              child: Text('Close'),
                              onPressed: () {
                                Navigator.pop(
                                    context); // Close the bottom sheet
                              },
                            ),
                            ElevatedButton(
                              child: Text('Log Out'),
                              onPressed: () {
                                Navigator.pushReplacement(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => LoginScreen()),
                                );
                              },
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                );
              },
            ),
            actions: <Widget>[
              IconButton(
                icon: Icon(Icons.search), // Search icon
                onPressed: () {},
              ),
              IconButton(
                icon: Icon(Icons.notifications_none_sharp), // More options icon
                onPressed: () {},
              ),
            ],
          ),
          body: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Card(
                  child: SizedBox(
                    width: 300,
                    height: 500,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Lottie.network(
                          'https://lottie.host/06b0b546-803e-4e9a-8ad9-e34ce9846843/FYM3m3vEGr.json',
                          width: 300,
                          height: 230,
                        ),
                        SizedBox(height: 20),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Container(
                              decoration: BoxDecoration(
                                border: Border.all(
                                  color: Colors.blue,
                                  width: 2,
                                ),
                              ),
                              child: Container(
                                width: 60,
                                height: 60,
                                color: Colors.white,
                                alignment: Alignment.center,
                                child: Text(
                                  '${checkInProvider.hours}'.padLeft(2, '0'),
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 25,
                                      color: Colors.black),
                                ),
                              ),
                            ),
                            Text(':', style: TextStyle(fontSize: 30)),
                            SizedBox(width: 05),
                            Container(
                              decoration: BoxDecoration(
                                border: Border.all(
                                  color: Colors.blue,
                                  width: 2,
                                ),
                              ),
                              child: Container(
                                width: 60,
                                height: 60,
                                color: Colors.white,
                                alignment: Alignment.center,
                                child: Text(
                                  '${checkInProvider.minutes}'.padLeft(2, '0'),
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 25,
                                      color: Colors.black),
                                ),
                              ),
                            ),
                            Text(':', style: TextStyle(fontSize: 30)),
                            SizedBox(width: 05),
                            Container(
                              decoration: BoxDecoration(
                                border: Border.all(
                                  color: Colors.blue,
                                  width: 2,
                                ),
                              ),
                              child: Container(
                                width: 60,
                                height: 60,
                                color: Colors.white,
                                alignment: Alignment.center,
                                child: Text(
                                  '${checkInProvider.seconds}'.padLeft(2, '0'),
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 25,
                                      color: Colors.black),
                                ),
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: 20),
                        Text(
                          'Generally 09:30 AM to 07:00 PM',
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                        SizedBox(height: 20),
                        ElevatedButton(
                          onPressed: () {
                            checkInProvider.toggleCheckIn();
                          },
                          style: ElevatedButton.styleFrom(
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(20),
                            ),
                            padding: EdgeInsets.symmetric(
                                horizontal: 80, vertical: 10),
                            backgroundColor: Colors.blue,
                          ),
                          child: Text(
                            checkInProvider.isCheckedIn
                                ? 'Check Out'
                                : 'Check In',
                            style: TextStyle(fontSize: 16, color: Colors.white),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
