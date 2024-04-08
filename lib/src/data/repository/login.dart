import 'package:zoho/src/data/datasource/local/sqflite.dart'; // Import your database implementation
import 'package:zoho/src/domain/Modal/regularization.dart';
import 'package:zoho/src/domain/repository/repository.dart';

class DatabaseProjectRepository implements ProjectRepository {
  final ProjectDataSource _dataSource;

  DatabaseProjectRepository(this._dataSource);

  @override
  Future<bool> login(String userName, String userPassword) async {
    return await _dataSource.login(userName, userPassword);
  }

  @override
  Future<void> signup(String userName, String userPassword) async {
    return await _dataSource.signup(userName, userPassword);
  }

  @override
  Future<int?> getUserId(String email) async {
    return await _dataSource.getUserId(email);
  }

  @override
  Future<void> insertRegularization(RegularizationData data) async {
    return await _dataSource.insertRegularization(data);
  }
  
  @override
  Future<List<RegularizationData>> getRegularization() async {
    return await _dataSource.getRegularization();
  }
  
   @override
  Future<List<Map<String, dynamic>>> getReports() async {
    return await _dataSource.getReports();
  }
  
  @override
  Future<void> insertReport(Map<String, dynamic> data) async {
    return await _dataSource.insertReport(data);
  }
}