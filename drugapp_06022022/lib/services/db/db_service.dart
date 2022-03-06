import 'package:mediinfo/models/country.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path_provider/path_provider.dart';
import 'dart:io';
import 'package:path/path.dart';
import 'dart:async';

class DBService {
  Database db;
  DBService._();

  factory DBService() => _instance;

  static final DBService _instance = DBService._();

  Future<void> init() async {
    try {
      Directory documentsDirectory = await getApplicationDocumentsDirectory();
      final path = join(documentsDirectory.path, 'country.db');
      db = await openDatabase(
        path,
        version: 1,
        onCreate: (newDb, version) {
          newDb.execute('''
        CREATE TABLE countries
        (
          id INTEGER PRIMARY KEY AUTOINCREMENT,
          productName TEXT,
          genericName TEXT,
          productNo TEXT,
          count INTEGER,
          thumbLink TEXT
        )
        ''');
        },
      );
    } catch (e) {
      print(e);
    }

    print(db.path);
  }

  Future<List<Country>> fetchTopCountries() async {
    final maps = await db.query(
      'countries',
      columns: null,
      orderBy: "count DESC",
      limit: 5,
    );
    if (maps.length > 0) {
      return maps.map((e) => Country.fromDb(e)).toList();
    }
    //print(maps.length);
    return null;
  }

  Future<Country> fetchCountry(String productName, String thumbLink,
      String productNo, String genericName) async {
    final maps = await db.query(
      'countries',
      columns: null,
      where:
          'productName = ? and thumbLink = ? and productNo = ? and genericName = ?',
      whereArgs: [productName, thumbLink, productNo, genericName],
    );
    print(maps);
    //print(await fetchTopCountries());

    if (maps.length > 0) {
      return Country.fromDb(maps.first);
    }

    return null;
  }

  Future<int> addCountry(String productName, String thumbLink, String productNo,
      String genericName) async {
    //print(thumbLink);
    var country =
        await fetchCountry(productName, thumbLink, productNo, genericName);
    if (country == null) {
      return db.insert(
        'countries',
        {
          "productName": productName,
          "productNo": productNo,
          "count": 1,
          "thumbLink": thumbLink,
          "genericName": genericName,
        },
        conflictAlgorithm: ConflictAlgorithm.ignore,
      );
    }

    return db.update(
      "countries",
      {
        "id": country.id,
        "productName": country.productName,
        "productNo": productNo,
        "count": country.count + 1,
        "thumbLink": country.thumbLink,
        "genericName": country.genericName,
      },
      where: "id = ?",
      whereArgs: [country.id],
    );
  }

  Future<int> clear() async {
    return db.delete('countries');
  }
}
