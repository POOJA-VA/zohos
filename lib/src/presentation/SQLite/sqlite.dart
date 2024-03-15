import 'dart:async';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import 'package:zoho/src/presentation/JsonModels/note_model.dart';
import 'package:zoho/src/presentation/JsonModels/regularization.dart';
import 'package:zoho/src/presentation/JsonModels/users.dart';

class DatabaseHelper {
  static DatabaseHelper? _databaseHelper;
  final String databaseName = "zohos.db";
  final String noteTable =
      "CREATE TABLE notes (noteId INTEGER PRIMARY KEY AUTOINCREMENT, noteTitle TEXT NOT NULL, noteContent TEXT NOT NULL, createdAt TEXT DEFAULT CURRENT_TIMESTAMP)";
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
    // await deleteDatabase(path);
    return openDatabase(path, version: 1, onCreate: (db, version) async {
      await db.execute(users);
      await db.execute(noteTable);
      await db.execute(regularizationTable);
      await db.execute(checkInOutTable);
    });
  }

  Future<bool> login(Users user) async {
    final Database db = await initDB();

    var result = await db.rawQuery(
        "SELECT * FROM users WHERE usrName = '${user.usrName}' AND usrPassword = '${user.usrPassword}'");
    return result.isNotEmpty;
  }

  Future<int> signup(Users user) async {
    final Database db = await initDB();
    return db.insert('users', user.toMap());
  }

  Future<List<NoteModel>> searchNotes(String keyword) async {
    final Database db = await initDB();
    List<Map<String, Object?>> searchResult = await db
        .rawQuery("SELECT * FROM notes WHERE noteTitle LIKE ?", ["%$keyword%"]);
    return searchResult.map((e) => NoteModel.fromMap(e)).toList();
  }

  Future<int> createNote(NoteModel note) async {
    final Database db = await initDB();
    return db.insert('notes', note.toMap());
  }

  Future<List<NoteModel>> getNotes() async {
    final Database db = await initDB();
    List<Map<String, Object?>> result = await db.query('notes');
    return result.map((e) => NoteModel.fromMap(e)).toList();
  }

  Future<int> deleteNote(int id) async {
    final Database db = await initDB();
    return db.delete('notes', where: 'noteId = ?', whereArgs: [id]);
  }

  Future<int> updateNote(title, content, noteId) async {
    final Database db = await initDB();
    return db.rawUpdate(
        'UPDATE notes SET noteTitle = ?, noteContent = ? WHERE noteId = ?',
        [title, content, noteId]);
  }

//Report
  Future<int> insertReport(Map<String, dynamic> data) async {
    final Database db = await initDB();
    print(db.insert('checkinout', data));
    return db.insert('checkinout', data);
  }

  Future<List<Map<String, dynamic>>> getReports() async {
    final Database db = await initDB();
    return db.query('checkinout');
  }

  //Regularization
  Future<int> insertRegularization(RegularizationData data) async {
    print(data.dropdownValue +
        "''''''''''''''''''''''''''''''''''''''''''''''''''''''");
    final Database db = await initDB();
    return db.insert("regularization", data.toMap());
  }

  Future<List<RegularizationData>> getRegularizationData() async {
    final Database db = await initDB();
    final List<Map<String, dynamic>> maps = await db.query('regularization');
    print("${maps.length}");
    List<RegularizationData> regularizationDataList = [];
    for (int i = 0; i <= maps.length - 1; i++) {
      print(maps[i]['checkInTime']);
      print(DateFormat("HH:mm").parse(maps[i]['checkInTime']));
      print(maps[i]['hours']);
      print(DateFormat.Hm()
          .format(DateFormat("HH:mm").parse(maps[i]['checkInTime'])));
      String checkInTimeValue = maps[i]['checkInTime'];
      String checkOutTimeValue = maps[i]['checkOutTime'];
      RegularizationData r = RegularizationData(
        employeeName: maps[i]['employeeName'] ?? "empty",
        date: maps[i]['date'] ?? "empty",
        checkInTime: TimeOfDay(
            hour: int.parse(checkInTimeValue.split(":")[0]),
            minute: int.parse(checkInTimeValue.split(":")[1])),
        checkOutTime: TimeOfDay(
            hour: int.parse(checkOutTimeValue.split(":")[0]),
            minute: int.parse(checkOutTimeValue.split(":")[1])),
        hours: maps[i]['hours'],
        dropdownValue: maps[i]['dropdownValue'] ?? "no",
      );
      regularizationDataList.add(RegularizationData.fromMap(maps[i]));
    }
    print(regularizationDataList);
    return regularizationDataList;
  }
}