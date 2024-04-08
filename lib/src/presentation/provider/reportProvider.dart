import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:zoho/src/data/datasource/local/sqflite.dart';

final checkInOutProvider =
    StateNotifierProvider<CheckInOutProvider, List<Map<String, dynamic>>>(
        (ref) {
  return CheckInOutProvider();
});

class CheckInOutProvider extends StateNotifier<List<Map<String, dynamic>>> {
  CheckInOutProvider() : super([]);

  List<double> hrs = [];

  void fetchCheckInOutList() async {
    final dataSource = ProjectDataSource();
    final List<Map<String, dynamic>> checkInOutList =
        await dataSource.getReports();
    state = checkInOutList;
  }

  void insertCheckInOut(Map<String, dynamic> data) async {
    final dataSource = ProjectDataSource();
    await dataSource.insertReport(data);
    fetchCheckInOutList();
  }
}