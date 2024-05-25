import 'package:flutter/material.dart';
import 'package:sqlite3_app/services/db_data/db_data.dart';

class ctr extends ChangeNotifier {
  ctr() {
    getData();
  }

  List studentList = [];
  Future<void> getData() async {
    studentList = await DBData.db.getStudentData();
    notifyListeners();
  }
}
