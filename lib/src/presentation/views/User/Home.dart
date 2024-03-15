import 'package:flutter/material.dart';
import 'package:zoho/src/presentation/views/User/Approvals.dart';
import 'package:zoho/src/presentation/views/User/Body.dart';
import 'package:zoho/src/presentation/views/User/Report.dart';
//import 'package:zoho/src/presentation/views/User/UserLocation.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  int _selectedIndex = 0;

  final List<Widget> _pages = [
    Body(),
    Report(),
    Approvals(),
    //LocationPage(),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  void main() {
    runApp(MaterialApp(
      home: Home(),
    ));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _pages[_selectedIndex],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _selectedIndex,
        onTap: _onItemTapped,
        items: [
          BottomNavigationBarItem(
            icon: Icon(Icons.home_filled),
            label: "Home",
            backgroundColor: Colors.blue,
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.dashboard_outlined),
            label: "Report",
            backgroundColor: Colors.blue,
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.check_box_outlined),
            label: "Approvals",
            backgroundColor: Colors.blue,
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.location_on_sharp),
            label: "Location",
            backgroundColor: Colors.blue,
          ),
        ],
      ),
    );
  }
}