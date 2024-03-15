import 'package:flutter/material.dart';
import 'package:zoho/src/presentation/SQLite/sqlite.dart';
import 'package:zoho/src/presentation/views/User/Body.dart';
import 'package:zoho/src/presentation/views/User/login.dart';
import 'package:provider/provider.dart';

void main() {
  DatabaseHelper db = DatabaseHelper();
  WidgetsFlutterBinding.ensureInitialized();
  db.initDB();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => CheckInProvider(),
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        home: LoginScreen(),
      ),
    );
  }
}
