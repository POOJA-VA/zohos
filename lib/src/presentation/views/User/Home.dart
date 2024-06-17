import 'package:flutter/material.dart';
import 'package:zoho/src/presentation/views/User/Approvals.dart';
import 'package:zoho/src/presentation/views/User/Body.dart';
import 'package:zoho/src/presentation/views/User/Regularisation.dart';
import 'package:zoho/src/presentation/views/User/Report.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

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
    Approvals(role: "User",),
    Regular(),
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
            label: AppLocalizations.of(context)!.home,
            backgroundColor: Color.fromARGB(218, 71, 167, 163),
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.dashboard_outlined),
            label: AppLocalizations.of(context)!.report,
            backgroundColor: Color.fromARGB(218, 71, 167, 163),
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.check_box_outlined),
            label: AppLocalizations.of(context)!.approvals,
            backgroundColor: Color.fromARGB(218, 71, 167, 163),
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.add_sharp),
            label: AppLocalizations.of(context)!.regular,
            backgroundColor: Color.fromARGB(218, 71, 167, 163),
          ),
        ],
      ),
    );
  }
}