import 'dart:developer';
import 'dart:io';
import 'package:dil_app/model/client_info_model.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';

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
  Future initDB() async {
    Directory documentsDirectory = await getApplicationDocumentsDirectory();
    final path = join(documentsDirectory.path, 'menu.db');

    return await openDatabase(path, version: 1, onOpen: (db) {},
        onCreate: (Database db, int version) async {
      await db.execute('CREATE TABLE Employee('
          'TKT_PRI_ID TEXT,'
          'T_PRIORITY TEXT,'
          'TICKET_GDT TEXT,'
          'UPDATED_AT TEXT,'
          'TICKETDESC TEXT,'
          'TKTSTUS_ID TEXT,'
          'TICKSTATUS TEXT,'
          'CTICKET_ID TEXT,'
          'CST_TITLES TEXT,'
          'PROJT_NAME TEXT,'
          'CREATED_AT TEXT,'
          'CLINT_NAME TEXT,'
          'TICKETUDID TEXT,'
          'T_REQ_MODE TEXT,'
          'TICKET_ATTACHMENT TEXT'
          ')');
    });
  }

  // Batch batch = db.batch;

  // Insert employee on database
  createEmployee(ClientInfo newEmployee) async {
    await deleteAllEmployees();
    final db = await database;
    final res = await db.insert('Employee', newEmployee.toJson());

    return res;
  }
  // createEmployee(newEmployee) async {
  //   newEmployee.forEach((val) {
  //     //assuming you have 'Cities' class defined

  //     batch.insert('Employee', newEmployee.toJson());
  //   });

  //   batch.commit();
  // }

  // Delete all employees
  Future<int> deleteAllEmployees() async {
    final db = await database;
    final res = await db.rawDelete('DELETE FROM Employee');

    return res;
  }

  Future<List<ClientInfo>> getAllEmployees() async {
    final db = await database;
    final res = await db.rawQuery("SELECT * FROM EMPLOYEE");

    List<ClientInfo> list =
        res.isNotEmpty ? res.map((c) => ClientInfo.fromJson(c)).toList() : [];

    return list;
  }

  Future<List<ClientInfo>> getAllTickets(String statusId) async {
    final db = await database;
    final res = await db.rawQuery(
        "SELECT * FROM EMPLOYEE where TKTSTUS_ID = ? ORDER BY CREATED_AT DESC",
        [statusId]);

    List<ClientInfo> list =
        res.isNotEmpty ? res.map((c) => ClientInfo.fromJson(c)).toList() : [];

    return list;
  }

  ///get tickets by status.
  ///Pass TKTSTUS_ID as parameter in "getTicketsByStatus()" function to get all the status of that id
  Future<List<ClientInfo>> getTicketsByStatus(String statusId, String passDate) async {
    final db = await database;
    String date = passDate == 'null' ? '-3 months' : passDate;
    final res = await db.rawQuery(
        "SELECT * FROM EMPLOYEE where TKTSTUS_ID = ? AND CREATED_AT > datetime('now', ?) ORDER BY CREATED_AT DESC",
        [statusId, date]);

    List<ClientInfo> list =
        res.isNotEmpty ? res.map((c) => ClientInfo.fromJson(c)).toList() : [];

    return list;
  }

  ///get tickets by priority.
  ///Pass TKT_PRI_ID as parameter in "getTicketsByPriority()" function to get all the status of that id
  Future<List<ClientInfo>> getTicketsByPriority(String priorityId, String passDate) async {
    final db = await database;
    String date = passDate == 'null' ? '-3 months' : passDate;
    final res = await db.rawQuery(
        "SELECT * FROM EMPLOYEE where TKT_PRI_ID = ? AND CREATED_AT > datetime('now', ?) ORDER BY CREATED_AT DESC",
        [priorityId, date]);

    List<ClientInfo> list =
        res.isNotEmpty ? res.map((c) => ClientInfo.fromJson(c)).toList() : [];

    return list;
  }

  Future<List<ClientInfo>> getClosedTicketsByDate(
      String statusId, String passDate) async {
    final db = await database;
    String date = passDate == 'null' ? '-3 months' : passDate;
    final res = await db.rawQuery(
        "SELECT * FROM EMPLOYEE where TKTSTUS_ID = ? AND CREATED_AT > datetime('now', ?) ORDER BY CREATED_AT DESC",
        [statusId, date]);

    List<ClientInfo> list =
        res.isNotEmpty ? res.map((c) => ClientInfo.fromJson(c)).toList() : [];

    return list;
  }

  //get status of other tickets without 4 and 9
  Future<List<ClientInfo>> getotherTickets() async {
    final db = await database;
    final res = await db.rawQuery(
        "SELECT * FROM EMPLOYEE where TKTSTUS_ID NOT IN (4, 9) ORDER BY CREATED_AT DESC");

    List<ClientInfo> list =
        res.isNotEmpty ? res.map((c) => ClientInfo.fromJson(c)).toList() : [];

    return list;
  }

  //count ticket priority

  Future<List<CountPriority>> tPriorityCount(String passDate) async {
    final db = await database;
    String date = passDate == 'null' ? '-3 months' : passDate;
    final res = await db.rawQuery(
        "SELECT TKT_PRI_ID, T_PRIORITY, count(*) count FROM Employee where CREATED_AT > datetime('now', ?) GROUP BY T_PRIORITY ORDER BY TKT_PRI_ID ASC",
        [date]);

    List<CountPriority> list =
        res.isNotEmpty ? res.map((c) => CountPriority.fromMap(c)).toList() : [];
    print('Priority: $res');
    // log(list[0].count.toString());

    return list;
  }

  //count ticket status
  Future<List<CountStatus>> tStatusCount(String passDate) async {
    final db = await database;
    String date = passDate == 'null' ? '-3 months' : passDate;
    final res = await db.rawQuery(
        "SELECT TKTSTUS_ID, TICKSTATUS, count(*) count FROM Employee where CREATED_AT > datetime('now', ?) GROUP BY TICKSTATUS ORDER BY TKTSTUS_ID ASC",
        [date]);
    print('Status: $res');
    List<CountStatus> list =
        res.isNotEmpty ? res.map((c) => CountStatus.fromMap(c)).toList() : [];
    print(res);
    // log(list[0].count.toString());

    return list;
  }

  // Future<List<ClientInfo>> getTicketsByDate() async {
  //   final db = await database;
  //   DateTime today = DateTime.now();
  //   String todayG = DateFormat("dd/MM/yyyy").format(new DateTime.now());
  //   DateTime twoDaysAgo = today.subtract(Duration(days: 60));
  //   String twoDaysAgoG = DateFormat("dd/MM/yyyy").format(twoDaysAgo);
  //   String qStr =
  //       "SELECT * FROM EMPLOYEE WHERE TICKET_GDT BETWEEN '$todayG' AND '$twoDaysAgoG'";
  //   final res = await db.rawQuery(qStr);
  //   // final res = await db.rawQuery(
  //   //     "SELECT * FROM EMPLOYEE WHERE CREATED_AT BETWEEN date('2019-01-28 09:39:31') AND date('2019-03-04 02:32:12')");
  //   //log(res.toString());
  //   log(qStr);
  //   List<ClientInfo> list =
  //       res.isNotEmpty ? res.map((c) => ClientInfo.fromJson(c)).toList() : [];

  //   return list;
  // }

  // Future<List<ClientInfo>> getTicketsByDate() async {
  //   final db = await database;
  //   final res = await db.rawQuery(
  //       "SELECT * FROM EMPLOYEE where CREATED_AT > datetime('now','-2 months')");
  //   log(res.toString());
  //   List<ClientInfo> list =
  //       res.isNotEmpty ? res.map((c) => ClientInfo.fromJson(c)).toList() : [];

  //   return list;
  // }
  Future<List<CountStatusByDate>> getTicketStatusByDate(String passDate) async {
    final db = await database;
    String date = passDate == 'null' ? '-3 months' : passDate;
    // final res = await db.rawQuery(
    //     "SELECT * FROM EMPLOYEE where CREATED_AT > datetime('now', ?)",
    //     [passDate]);
    final res = await db.rawQuery(
        "SELECT TKTSTUS_ID, TICKSTATUS, count(*) count FROM Employee where CREATED_AT > datetime('now', ?) GROUP BY TICKSTATUS ORDER BY CASE TKTSTUS_ID WHEN 1 THEN 0 WHEN 3 THEN 1 WHEN 2 THEN 2 WHEN 4 THEN 3 WHEN 5 THEN 4 WHEN 9 THEN 5 END",
        [date]);
    log(res.toString());
    List<CountStatusByDate> list = res.isNotEmpty
        ? res.map((c) => CountStatusByDate.fromMap(c)).toList()
        : [];

    return list;
  }

  /// *************************** Not needed *****************************/
  Future<List<CountPriorityByDate>> getTicketPriorityByDate(String passDate) async {
    final db = await database;
    String date = passDate == 'null' ? '-3 months' : passDate;
    // final res = await db.rawQuery(
    //     "SELECT * FROM EMPLOYEE where CREATED_AT > datetime('now', ?)",
    //     [passDate]);
    final res = await db.rawQuery(
        "SELECT TKT_PRI_ID, T_PRIORITY, count(*) count FROM Employee where CREATED_AT > datetime('now', ?) GROUP BY T_PRIORITY",
        [date]);
    log(res.toString());
    List<CountPriorityByDate> list = res.isNotEmpty
        ? res.map((c) => CountPriorityByDate.fromMap(c)).toList()
        : [];

    return list;
  }
}
