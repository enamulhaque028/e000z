import 'dart:io';
import 'package:dil_app/model/notification_model.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';

class NotificationDBProvider {
  static Database _database;
  static final NotificationDBProvider db = NotificationDBProvider._();

  NotificationDBProvider._();

  factory NotificationDBProvider() => _instance;

  static final NotificationDBProvider _instance = NotificationDBProvider._();

  Future<Database> get database async {
    // If database exists, return database
    if (_database != null) return _database;

    // If database don't exists, create one
    _database = await initDB();

    return _database;
  }

  // Create the database and the Employee table
  initDB() async {
    Directory documentsDirectory = await getApplicationDocumentsDirectory();
    final path = join(documentsDirectory.path, 'data.db');

    return await openDatabase(path, version: 1, onOpen: (db) {},
        onCreate: (Database db, int version) async {
      await db.execute('CREATE TABLE Notification('
          'id INTEGER PRIMARY KEY AUTOINCREMENT ,'
          'title TEXT,'
          'body TEXT,'
          'date TEXT'
          ')');
    });
  }

  // Insert value into "Notification" table
  Future<List<NotificationData>> addToNotificationData(
      String title, String body, String date) async {
    final db = await database;
    final res = await db.rawQuery(
        "INSERT INTO Notification(title, body, date) VALUES(?, ?, ?)",
        [title, body, date]);

    List<NotificationData> list = res.isNotEmpty
        ? res.map((c) => NotificationData.fromMap(c)).toList()
        : [];
    return list;
  }

  //Get data from "Notification" table
  Future<List<NotificationData>> getNotificationData() async {
    final db = await database;
    final res =
        await db.rawQuery("SELECT * FROM Notification ORDER BY id DESC");

    List<NotificationData> list = res.isNotEmpty
        ? res.map((c) => NotificationData.fromMap(c)).toList()
        : [];
    return list;
  }
}
