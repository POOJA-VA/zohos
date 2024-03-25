import 'dart:async';
import 'package:flutter/material.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import 'package:zoho/src/domain/Modal/login.dart';
import 'package:zoho/src/domain/Modal/regularization.dart';

class DatabaseHelper {
  static DatabaseHelper? _databaseHelper;
  final String databaseName = "zohos.db";
  final String users =
      "CREATE TABLE users (usrId INTEGER PRIMARY KEY AUTOINCREMENT, usrName TEXT UNIQUE, usrPassword TEXT)";
  final String regularizationTable =
      "CREATE TABLE regularization (id INTEGER PRIMARY KEY, employeeName TEXT, date TEXT, checkInTime TEXT, checkOutTime TEXT, hours INTEGER, dropdownValue TEXT)";
  final String checkInOutTable =
      "CREATE TABLE checkinout (id INTEGER PRIMARY KEY, title TEXT, checkin TEXT, checkout TEXT, hours TEXT)";

  static final DatabaseHelper instance = DatabaseHelper._privateConstructor();

  DatabaseHelper._privateConstructor();

  factory DatabaseHelper() {
    _databaseHelper ??= DatabaseHelper._privateConstructor();
    return _databaseHelper!;
  }

  Future<Database> initDB() async {
    final String databasePath = await getDatabasesPath();
    final String path = join(databasePath, databaseName);
    //  await deleteDatabase(path);
    return openDatabase(path, version: 1, onCreate: (db, version) async {
      await db.execute(users);
      // await db.execute(noteTable);
      await db.execute(regularizationTable);
      await db.execute(checkInOutTable);
    });
  }

  Future<bool> login(Login login) async {
    final Database db = await initDB();

    var result = await db.rawQuery(
        "SELECT * FROM users WHERE usrName = '${login.usrName}' AND usrPassword = '${login.usrPassword}'");
    return result.isNotEmpty;
  }

  Future<int> signup(Login login) async {
    final Database db = await initDB();
    return db.insert('users', login.toMap());
  }

//Report
  Future<int> insertReport(Map<String, dynamic> data) async {
    final Database db = await initDB();
    return db.insert('checkinout', data);
  }

  Future<List<Map<String, dynamic>>> getReports() async {
    final Database db = await initDB();
    return db.query('checkinout');
  }

  //Regularization
  Future<int> insertRegularization(RegularizationData data) async {
    // print(data.dropdownValue +
    //     "''''''''''''''''''''''''''''''''''''''''''''''''''''''");
    final Database db = await initDB();
    return db.insert("regularization", data.toMap());
  }

  Future<List<RegularizationData>> getRegularizationData() async {
    final Database db = await initDB();
    final List<Map<String, dynamic>> maps = await db.query('regularization');
    print("${maps.length}");
    List<RegularizationData> regularizationDataList = [];
    for (int i = 0; i <= maps.length - 1; i++) {
      // print(maps[i]['checkInTime']);
      // print(DateFormat("HH:mm").parse(maps[i]['checkInTime']));
      // print(maps[i]['dropdownValue']);
      // print(maps[i]['hours']);
      // print(DateFormat.Hm()
      //     .format(DateFormat("HH:mm").parse(maps[i]['checkInTime'])));
      String checkInTimeValue = maps[i]['checkInTime'];
      String checkOutTimeValue = maps[i]['checkOutTime'];
      RegularizationData reg = RegularizationData(
        employeeName: maps[i]['employeeName'] ?? "empty",
        date: maps[i]['date'] ?? "empty",
        checkInTime: TimeOfDay(
            hour: int.parse(checkInTimeValue.split(":")[0]),
            minute: int.parse(checkInTimeValue.split(":")[1])),
        checkOutTime: TimeOfDay(
            hour: int.parse(checkOutTimeValue.split(":")[0]),
            minute: int.parse(checkOutTimeValue.split(":")[1])),
        hours: maps[i]['hours'],
        dropdownValue: maps[i]['dropdownValue'],
      );
      regularizationDataList.add(reg);
    }
    return regularizationDataList;
  }
}
