  import 'package:flutter/foundation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';
import 'package:zoho/src/data/datasource/local/sqflite.dart';

final hrsProvider = ChangeNotifierProvider((ref) => HoursProvider());

class HoursProvider extends ChangeNotifier {
  List<double> hrs = [];
    void setHours() async {
      final dataSource = ProjectDataSource();
      print("check");
      DateTime now = DateTime.now();
      DateFormat dateFormat = DateFormat('EEEE');
      if(dateFormat.format(now) == "Sunday") {
        hrs = [0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0];
      }else {
      hrs = await dataSource.getHours();
      }
      notifyListeners();
  }
  }