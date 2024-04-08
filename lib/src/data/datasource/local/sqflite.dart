import 'package:intl/intl.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import 'package:zoho/src/domain/Modal/regularization.dart';
import 'package:zoho/src/domain/repository/repository.dart';

class ProjectDataSource implements ProjectRepository {
  final String databaseName = "zohos.db";

  final String users =
      "create table users (userId INTEGER PRIMARY KEY AUTOINCREMENT, userName TEXT UNIQUE, userPassword TEXT)";

  final String regularization =
      "CREATE TABLE regularization (id INTEGER PRIMARY KEY AUTOINCREMENT, employeeName TEXT, date TEXT, checkInTime TEXT, checkOutTime TEXT, hours INTEGER, dropdownValue TEXT)";

  final String checkInOutTable =
      "CREATE TABLE checkinout (id INTEGER PRIMARY KEY, title TEXT, checkin TEXT, checkout TEXT, hours TEXT)";

  Future<Database> initDB() async {
    final String databasePath = await getDatabasesPath();
    final String path = join(databasePath, databaseName);

    return openDatabase(path, version: 1, onCreate: (db, version) async {
      await db.execute(users);
      await db.execute(regularization);
      await db.execute(checkInOutTable);
    });
  }

  @override
  Future<int?> getUserId(String email) async {
    final Database db = await initDB();
    final List<Map<String, dynamic>> result = await db.query(
      'users',
      columns: ['userId'],
      where: 'userName = ?',
      whereArgs: [email],
    );
    if (result.isNotEmpty) {
      return result.first['userId'] as int?;
    } else {
      return null;
    }
  }

  @override
  Future<bool> login(String userName, String userPassword) async {
    final Database db = await initDB();

    final List<Map<String, dynamic>> result = await db.query(
      'users',
      where: 'userName = ? AND userPassword = ?',
      whereArgs: [userName, userPassword],
    );
    return result.isNotEmpty;
  }

  @override
  Future<void> signup(String userName, String userPassword) async {
    final Database db = await initDB();

    try {
      await db.insert(
        'users',
        {'userName': userName, 'userPassword': userPassword},
        conflictAlgorithm: ConflictAlgorithm.replace,
      );
    } catch (e) {
    } finally {
      await db.close();
    }
  }

  @override
  Future<List<RegularizationData>> getRegularization() async {
    final Database db = await initDB();
    final List<Map<String, dynamic>> result = await db.query('regularization');
    await db.close();
    return result.map((map) => RegularizationData.fromMap(map)).toList();
  }

  @override
  Future<void> insertRegularization(RegularizationData data) async {
    print("${data.id}");
    final Database db = await initDB();
    int a = await db.insert(
      'regularization',
      data.toMap(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
    print(a);
    await db.close();
  }

  Future<void> insertReport(Map<String, dynamic> data) async {
    DateTime now = DateTime.now();
    String formattedDate = DateFormat('EEEE, dd MMMM').format(now);
    // print(
    //     "${data['title']}");
    final Database db = await initDB();
    List<Map<String, dynamic>> title = await db
        .rawQuery("SELECT title FROM checkinout WHERE title='$formattedDate'");
    print(title.length > 0);
    if (title.length == 0) {
      await db.insert(
        'checkinout',
        data,
        conflictAlgorithm: ConflictAlgorithm.replace,
      );
    } else {
      List<Map<String, dynamic>> hrs = await db.rawQuery(
          "SELECT hours FROM checkinout WHERE title='$formattedDate'");
      double final_hrs =
          double.parse(hrs.first.values.elementAt(0).replaceAll(":", "."));
      double current_hrs = double.parse(data['hours'].replaceAll(":", "."));

      await db.rawUpdate(
          "UPDATE checkinout SET hours = ?,checkout = ? WHERE title = '$formattedDate'",
          [final_hrs + current_hrs, data['checkout']]);
    }
    await db.close();
  }

  Future<List<Map<String, dynamic>>> getReports() async {
    final Database db = await initDB();
    final List<Map<String, dynamic>> result = await db.query('checkinout');
    // print('$result');
    return result;
  }

  Future<List<double>> getHours() async {
    final Database db = await initDB();
    List<DateTime> currentWeekList = getDateList();
    List<double> hours = [0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0];
    DateFormat dateFormat = DateFormat('EEEE, dd MMMM');
    for (DateTime date in currentWeekList) {
      List<Map<String, dynamic>> hour = await db.rawQuery(
          "SELECT title, hours FROM checkinout WHERE title='${dateFormat.format(date)}'");
      if (hour.isNotEmpty && hour.length > 0) {
        if (hour.first['title'].split(",")[0] == 'Sunday') {
          hours[1] = double.parse(hour.first['hours'].replaceAll(":","."));
        }
        else if (hour.first['title'].split(",")[0] == 'Monday') {
          hours[1] = double.parse(hour.first['hours'].replaceAll(":","."));
        }
        else if (hour.first['title'].split(",")[0] == 'Tuesday') {
          hours[1] = double.parse(hour.first['hours'].replaceAll(":","."));
        }
        else if (hour.first['title'].split(",")[0] == 'Wednesday') {
          hours[1] = double.parse(hour.first['hours'].replaceAll(":","."));
        }
        else if (hour.first['title'].split(",")[0] == 'Thursday') {
          hours[1] = double.parse(hour.first['hours'].replaceAll(":","."));
        }
        else if (hour.first['title'].split(",")[0] == 'Friday') {
          hours[1] = double.parse(hour.first['hours'].replaceAll(":","."));
        }
        else if (hour.first['title'].split(",")[0] == 'Saturday') {
          hours[1] = double.parse(hour.first['hours'].replaceAll(":","."));
        }
      }
    }
    return hours;
  }

  List<DateTime> getDateList() {
    DateTime now = DateTime.now();
    DateTime sunday = now.subtract(Duration(days: now.weekday - 1));
    List<DateTime> weekDates = [];
    weekDates.add(sunday);
    for (int i = 1; i < 7; i++) {
      DateTime nextDay = sunday.add(Duration(days: i));
      weekDates.add(nextDay);
    }
    return weekDates;
  }
}


  //   Future<void> insertReport(Map<String, dynamic> data) async {
  //   final Database db = await initDB();
  //   DateTime checkinDate = DateTime.parse(data['checkin']);
  //   print('$checkinDate');
  //   String dayOfWeek = DateFormat('EEEE').format(checkinDate);
  //   data['title'] = dayOfWeek;
  //   if (dayOfWeek == 'Monday') {
  //     DateTime checkinTime = DateTime.parse(data['checkin']);
  //     DateTime checkoutTime = checkinTime.add(Duration(hours: 9));
  //     data['checkout'] = DateFormat('yyyy-MM-dd HH:mm:ss').format(checkoutTime);
  //   } else {
  //     DateTime checkinTime = DateTime.parse(data['checkin']);
  //     DateTime checkoutTime = checkinTime.add(Duration(hours: 9));
  //     data['checkout'] = DateFormat('yyyy-MM-dd HH:mm:ss').format(checkoutTime);
  //   }
  //   await db.insert(
  //     'checkinout',
  //     data,
  //     conflictAlgorithm: ConflictAlgorithm.replace,
  //   );
  //   await db.close();
  // }