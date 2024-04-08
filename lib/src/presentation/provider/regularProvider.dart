import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:zoho/src/data/datasource/local/sqflite.dart';
import 'package:zoho/src/domain/Modal/regularization.dart';

final regularizationProvider =
    StateNotifierProvider<RegularizationProvider, List<RegularizationData>>(
        (ref) {
  return RegularizationProvider();
});

class RegularizationProvider extends StateNotifier<List<RegularizationData>> {
  RegularizationProvider() : super([]);

  void fetchRegularization() async {
    final dataSource = ProjectDataSource();
    final List<RegularizationData> regularizationDataList =
        await dataSource.getRegularization();
    state = regularizationDataList;
  }

  void insertRegularization(RegularizationData data) async {
    final dataSource = ProjectDataSource();
    await dataSource.insertRegularization(data);
    fetchRegularization();
  }
}