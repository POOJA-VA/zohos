  import 'package:flutter/foundation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:zoho/src/data/datasource/local/sqflite.dart';

final hrsProvider = ChangeNotifierProvider((ref) => HoursProvider());

class HoursProvider extends ChangeNotifier {
  List<double> hrs = [];
    void setHours() async {
      final dataSource = ProjectDataSource();
      print("check");
      DateTime currentDay =  DateTime.now();
      hrs = await dataSource.getHours();
      notifyListeners();
  }
  }