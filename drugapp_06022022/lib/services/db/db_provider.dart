import 'dart:io';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';
import 'package:mediinfo/models/country.dart';

class DBProvider {
  static Database _database;
  static final DBProvider db = DBProvider._();

  DBProvider._();

  factory DBProvider() => _instance;

  static final DBProvider _instance = DBProvider._();

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
    final path = join(documentsDirectory.path, 'menu.db');

    return await openDatabase(path, version: 1, onOpen: (db) {},
        onCreate: (Database db, int version) async {
      await db.execute('CREATE TABLE Employee('
          'productName TEXT,'
          'productNo TEXT,'
          'genericName TEXT,'
          'thumbLink TEXT,'
          'productId INTEGER,'
          'productDescription TEXT,'
          'parentProductNo TEXT,'
          'productUnitOfMeasurmentNo TEXT,'
          'productUnitOfMeasurmentName TEXT,'
          'genericNo TEXT,'
          'productStrength TEXT,'
          'strengthUnitId INTEGER,'
          'productTotalStrength INTEGER,'
          'productTypeNo TEXT,'
          'productTypeName TEXT,'
          'productCatagoryNo TEXT,'
          'productCatagoryName TEXT,'
          'showProductNewFlag INTEGER,'
          'productFlag TEXT,'
          'userDefineProductNo TEXT,'
          'recordShowFlag INTEGER,'
          'activeStatusFlag INTEGER,'
          'rowLanguageCode TEXT,'
          'categoryType TEXT,'
          'unitPrice REAL,'
          /*-----------------added below columns in the table-----------------*/
          'addedProduct Text DEFAULT "0",'
          'productAmount TEXT DEFAULT "0"'
          ')');
      await db.execute('CREATE TABLE Cart('
          'productNo TEXT,'
          'productName TEXT,'
          'genericName TEXT,'
          'thumbLink TEXT,'
          'productAmount TEXT DEFAULT "0",'
          'unitPrice TEXT DEFAULT "0",'
          'totalPrice REAL DEFAULT "0",'
          'isPending Text DEFAULT "0"'
          ')');
      await db.execute('CREATE TABLE Favourite('
          'productNo TEXT,'
          'productName TEXT,'
          'genericName TEXT,'
          'thumbLink TEXT'
          ')');
      await db.execute('CREATE TABLE ShortList('
          'productNo TEXT,'
          'productName TEXT,'
          'genericName TEXT,'
          'thumbLink TEXT'
          ')');
      await db.execute('CREATE TABLE SearchHistory('
          'id INTEGER PRIMARY KEY AUTOINCREMENT ,'
          'productName TEXT,'
          'productCategory TEXT'
          ')');
      await db.execute('CREATE TABLE ClickEvent('
          'id INTEGER PRIMARY KEY AUTOINCREMENT ,'
          'userActivity TEXT,'
          'page TEXT,'
          'date TEXT'
          ')');
    });
  }

  // Insert employee on database
  createEmployee(Country newEmployee) async {
    await deleteAllEmployees();
    final db = await database;
    final res = await db.insert('Employee', newEmployee.toJson());

    return res;
  }

  // Delete all employees
  Future<int> deleteAllEmployees() async {
    final db = await database;
    final res = await db.rawDelete('DELETE FROM Employee');

    return res;
  }

  //get all products
  Future<List<Country>> getAllProducts() async {
    final db = await database;
    final res = await db.rawQuery("SELECT * FROM EMPLOYEE");

    List<Country> list =
        res.isNotEmpty ? res.map((c) => Country.fromJson(c)).toList() : [];

    return list;
  }

  //get products by category[pharma/herbal/unani]
  //EN21010000000006 = Oncology
  //EN21010000000007 = Harbal
  //EN21010000000008 = Unani
  //EN21010000000012 = Pharma
  Future<List<Country>> getProductsByCategory(String categoryType) async {
    final db = await database;
    // final res = await db.rawQuery(
    //     "SELECT * FROM EMPLOYEE WHERE categoryType = ?", [categoryNo]);
    final res = await db.rawQuery(
        "SELECT * FROM EMPLOYEE WHERE categoryType = '$categoryType'");

    List<Country> list =
        res.isNotEmpty ? res.map((c) => Country.fromJson(c)).toList() : [];

    return list;
  }

  //get multiple category[Harbal and Unani]
  Future<List<Country>> getHarbalUnani() async {
    final db = await database;
    final res = await db
        .rawQuery("SELECT * FROM EMPLOYEE WHERE categoryType in ('H', 'U')");
    //H stands for Harbal and U stands for Unani

    List<Country> list =
        res.isNotEmpty ? res.map((c) => Country.fromJson(c)).toList() : [];

    return list;
  }

  //Get latest products
  Future<List<Country>> getLatestProducts() async {
    final db = await database;
    final res = await db.rawQuery(
        "SELECT * FROM EMPLOYEE WHERE showProductNewFlag = 1 LIMIT 5");
    //log(res.toString());
    //use this if you need to ignore duplicate item
    // final res = await db.rawQuery(
    //     "SELECT DISTINCT productName, thumbLink FROM EMPLOYEE WHERE showProductNewFlag = 1 LIMIT 5");
    List<Country> list =
        res.isNotEmpty ? res.map((c) => Country.fromJson(c)).toList() : [];

    return list;
  }

  //update value of "addToCart" from "EMPLOYEE" table
  Future<List<Country>> addProductToCart(
      String prodNo, String prodAmount) async {
    final db = await database;
    final res = await db.rawQuery(
        "UPDATE EMPLOYEE SET addedProduct='1', productAmount= ? WHERE productNo= ?",
        [prodAmount, prodNo]);

    List<Country> list =
        res.isNotEmpty ? res.map((c) => Country.fromJson(c)).toList() : [];

    return list;
  }

  // Fetch products from cart, "EMPLOYEE" table
  Future<List<AddToCart>> getProductsFromCart() async {
    final db = await database;
    final res = await db.rawQuery(
        "SELECT productName, thumbLink, productAmount FROM EMPLOYEE WHERE addedProduct='1' ");

    List<AddToCart> list =
        res.isNotEmpty ? res.map((c) => AddToCart.fromMap(c)).toList() : [];

    return list;
  }

  /*---------------------------------------Start Add Product To Cart-------------------------------------------*/
  // Insert value into "name" column on "Cart" table
  Future<List<AddToCartTable>> addToCartTable(
      String productNo,
      String productName,
      String genericName,
      String productAmount,
      String unitPrice,
      String thumbLink) async {
    double totalPrice = int.parse(productAmount) * double.parse(unitPrice);
    final db = await database;
    final data = await db.rawQuery("SELECT * FROM Cart WHERE productNo = ?", [productNo]);
    var res;
    if (data.isEmpty) {
      res = await db.rawQuery(
          "INSERT INTO Cart(productNo, productName, genericName, productAmount, unitPrice, totalPrice, thumbLink) VALUES(?, ?, ?, ?, ?, ?, ?)",
          [
            productNo,
            productName,
            genericName,
            productAmount,
            unitPrice,
            totalPrice.toStringAsFixed(2),
            thumbLink,
          ]);
    } else {
      res = await db.rawQuery(
          "UPDATE Cart SET productAmount = ?,  unitPrice = ?, totalPrice = ? where productNo = ?",
          [
            productAmount,
            unitPrice,
            totalPrice.toStringAsFixed(2),
            productNo,
          ]);
    }

    List<AddToCartTable> list = res.isNotEmpty
        ? res.map((c) => AddToCartTable.fromMap(c)).toList()
        : [];

    return list;
  }

  // get all products from "Cart" table
  Future<List<AddToCartTable>> getProductCartTable(String isPending) async {
    final db = await database;
    final res = await db
        .rawQuery("SELECT * FROM Cart WHERE isPending = ?", [isPending]);

    List<AddToCartTable> list = res.isNotEmpty
        ? res.map((c) => AddToCartTable.fromMap(c)).toList()
        : [];

    return list;
  }

  // delete product from "Cart" table
  Future<List<AddToCartTable>> deleteProductCartTable(String productNo) async {
    final db = await database;
    final res =
        await db.rawQuery("DELETE FROM Cart WHERE productNo= ?", [productNo]);

    List<AddToCartTable> list = res.isNotEmpty
        ? res.map((c) => AddToCartTable.fromMap(c)).toList()
        : [];

    return list;
  }

  // update product amount from "Cart" table
  Future<List<AddToCartTable>> updateProductAmount(
      String productAmount, String unitPrice, String productNo) async {
    double totalPrice = int.parse(productAmount) * double.parse(unitPrice);
    final db = await database;
    final res = await db.rawQuery(
        "UPDATE Cart SET productAmount = ?,  unitPrice = ?, totalPrice = ? where productNo = ?",
        [
          productAmount,
          unitPrice,
          totalPrice.toStringAsFixed(2),
          productNo,
        ]);

    List<AddToCartTable> list = res.isNotEmpty
        ? res.map((c) => AddToCartTable.fromMap(c)).toList()
        : [];

    return list;
  }

  // update "isPending" value from "Cart" table
  Future<List<AddToCartTable>> moveToPending() async {
    final db = await database;
    final res = await db.rawQuery("Update Cart SET isPending = '1'");

    List<AddToCartTable> list = res.isNotEmpty
        ? res.map((c) => AddToCartTable.fromMap(c)).toList()
        : [];
    return list;
  }

  /*---------------------------------------End Add Product To Cart-------------------------------------------*/

  /*---------------------------------------Start Add Product To Favorite-------------------------------------------*/
  //Insert value into "Favourite" table
  Future<List<AddToFavourite>> addToFavourite(String productNo,
      String productName, String genericName, String thumbLink) async {
    final db = await database;
    final data = await db
        .rawQuery("SELECT * FROM Favourite WHERE productNo = ?", [productNo]);
    var res;
    if (data.isEmpty) {
      res = await db.rawQuery(
          "INSERT INTO Favourite(productNo, productName, genericName, thumbLink) VALUES(?, ?, ?, ?)",
          [productNo, productName, genericName, thumbLink]);
    } else {
      return res;
    }

    List<AddToFavourite> list = res.isNotEmpty
        ? res.map((c) => AddToFavourite.fromMap(c)).toList()
        : [];
    return list;
  }

  // get all products from "Favourite" table
  Future<List<AddToFavourite>> getProductsFromFavourite() async {
    final db = await database;
    final res = await db.rawQuery("SELECT * FROM Favourite");

    List<AddToFavourite> list = res.isNotEmpty
        ? res.map((c) => AddToFavourite.fromMap(c)).toList()
        : [];
    return list;
  }

  // delete product from "Favourite" table
  Future<List<AddToFavourite>> deleteProductFromFavourite(
      String productNo) async {
    final db = await database;
    final res = await db
        .rawQuery("DELETE FROM Favourite WHERE productNo = ?", [productNo]);

    List<AddToFavourite> list = res.isNotEmpty
        ? res.map((c) => AddToFavourite.fromMap(c)).toList()
        : [];
    return list;
  }
  /*---------------------------------------End Add Product To Favorite-------------------------------------------*/

  /*---------------------------------------Start Add Product To ShortList-------------------------------------------*/
  //Insert value into "ShortList" table
  Future<List<AddToShortList>> addToShortList(String productNo,
      String productName, String genericName, String thumbLink) async {
    final db = await database;
    final data = await db
        .rawQuery("SELECT * FROM ShortList WHERE productNo = ?", [productNo]);
    var res;
    if (data.isEmpty) {
      res = await db.rawQuery(
          "INSERT INTO ShortList(productNo, productName, genericName, thumbLink) VALUES(?, ?, ?, ?)",
          [productNo, productName, genericName, thumbLink]);
    } else {
      return res;
    }

    List<AddToShortList> list = res.isNotEmpty
        ? res.map((c) => AddToShortList.fromMap(c)).toList()
        : [];
    return list;
  }

  // get all products from "ShortList" table
  Future<List<AddToShortList>> getProductsFromShortList() async {
    final db = await database;
    final res = await db.rawQuery("SELECT * FROM ShortList");

    List<AddToShortList> list = res.isNotEmpty
        ? res.map((c) => AddToShortList.fromMap(c)).toList()
        : [];
    return list;
  }

  // delete product from "ShortList" table
  Future<List<AddToShortList>> deleteProductFromShortList(
      String productNo) async {
    final db = await database;
    final res = await db
        .rawQuery("DELETE FROM ShortList WHERE productNo = ?", [productNo]);

    List<AddToShortList> list = res.isNotEmpty
        ? res.map((c) => AddToShortList.fromMap(c)).toList()
        : [];
    return list;
  }
  /*---------------------------------------End Add Product To Favorite-------------------------------------------*/

  /*---------------------------------------Start Add Search History To SearchHistory-------------------------------------------*/
  //Insert value into "SearchHistory" table
  Future<List<SearchHistory>> addToSearchHistory(
      String productName, String productCategory) async {
    final db = await database;
    final data = await db.rawQuery(
        "SELECT * FROM SearchHistory WHERE productName = ? AND productCategory = ?",
        [productName, productCategory]);
    var res;
    if (data.isEmpty) {
      res = await db.rawQuery(
          "INSERT INTO SearchHistory(productName, productCategory) VALUES(?, ?)",
          [productName, productCategory]);
    } else {
      return res;
    }

    List<SearchHistory> list =
        res.isNotEmpty ? res.map((c) => SearchHistory.fromMap(c)).toList() : [];
    return list;
  }

  // get column wise searched text from "SearchHistory" table
  Future<List<SearchHistory>> getSearchHistory(String productCategory) async {
    final db = await database;
    final res = await db.rawQuery(
        "SELECT * FROM SearchHistory WHERE productCategory = ? ORDER BY id DESC",
        [productCategory]);

    List<SearchHistory> list =
        res.isNotEmpty ? res.map((c) => SearchHistory.fromMap(c)).toList() : [];
    return list;
  }

  Future<List<SearchHistory>> deleteFromSearch(int id) async {
    final db = await database;
    final res =
        await db.rawQuery("DELETE FROM SearchHistory where id = ?", [id]);

    List<SearchHistory> list =
        res.isNotEmpty ? res.map((c) => SearchHistory.fromMap(c)).toList() : [];
    return list;
  }
  /*---------------------------------------End Add Search History To SearchHistory-------------------------------------------*/

  /*---------------------------------------Start Add events To ClickEvent-------------------------------------------*/
  //Insert value into "ClickEvent" table
  Future<List<ClickEvent>> addToClickEvent(
      String userActivity, String page, String date) async {
    final db = await database;
    final res = await db.rawQuery(
        "INSERT INTO ClickEvent(userActivity, page , date) VALUES(?, ?, ?)",
        [userActivity, page, date]);

    List<ClickEvent> list =
        res.isNotEmpty ? res.map((c) => ClickEvent.fromMap(c)).toList() : [];
    return list;
  }
}
