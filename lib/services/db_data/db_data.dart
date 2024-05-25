import 'package:logger/logger.dart';
import 'package:sqflite/sqflite.dart';
import 'package:sqlite3_app/modal/app_modal.dart';

enum UserTableColumn {
  id,
  name,
  email,
}

class DBData {
  DBData._();
  static final DBData db = DBData._();

  String dbName = 'My_DataBase.db';
  String tableName = 'users';

  late Database database;
  Logger logger = Logger();

  Future<void> initdb() async {
    String path = await getDatabasesPath();
    Database database = await openDatabase(
      '$path/$dbName',
      version: 1,
      onCreate: (db, version) {
        String createtablequerey = """CREATE TABLE IF NOT EXISTS$tableName (
            ${UserTableColumn.id.name} INTEGER PRIMARY KEY AUTOINCREMENT,
            ${UserTableColumn.name.name} TEXT NOT NULL,
            ${UserTableColumn.email.name} TEXTs NOT NULL,
            );""";
        db
            .execute(createtablequerey)
            .then((value) => logger.i("Table created"))
            .onError(
              (error, stackTrace) => logger.e("Error $error"),
            );
      },
    );
    logger.i("database created");
  }

  Future<void> inserStudent({required Student student}) async {
    Map<String, dynamic> data = student.toMap;
    data.remove('id');
    database
        .insert(tableName, data)
        .then((value) => logger.i("inserted"))
        .onError((error, stackTrace) => logger.e("Error $error"));
  }

  Future<List> getStudentData() async {
    List studentList = [];
    List<Map> map = await database.rawQuery("SELECT * FROM $tableName");
    studentList = map.map((e) => e).toList();
    return studentList;
  }
}
