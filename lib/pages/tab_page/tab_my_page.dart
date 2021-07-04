import 'package:flutter/material.dart';
import 'package:billkeeping/common/db_helper.dart';
import 'package:sqflite/sqlite_api.dart';

class TabMyPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(children: [
      ElevatedButton(
        child: Text(DateTime.now().toString().substring(0, 10)),
        onPressed: () {
          getYearSumByProject(DateTime.now().toString());
        },
      ),
      ElevatedButton(
        child: Text(DateTime.now().toString().substring(0, 10)),
        onPressed: () {
          getWeekSumByProject(DateTime.now().toString().substring(0, 10));
        },
      ),
    ]);
  }
}

Future<List<Map<String, dynamic>>> getYearSumByProject(String date) async {
  Database db = await DbHelper.getDb();
  final List<Map<String, dynamic>> maps = await db.rawQuery('''
      SELECT strftime('%w', a.date) weekday, ifnull(SUM(a.payMoney), 0) payMoney FROM account a 
      WHERE a.date >= date('$date', 'localtime', 'weekday 1', '-7 day', 'start of day')
      GROUP BY weekday;
    ''');

  print(maps);
  return maps;
}

Future<List<Map<String, dynamic>>> getWeekSumByProject(String date) async {
  Database db = await DbHelper.getDb();
  final List<Map<String, dynamic>> maps = await db.rawQuery('''
      SELECT p.name, ifnull(SUM(a.payMoney), 0) payMoney
      FROM account a LEFT JOIN project p ON p.id = a.projectID 
       WHERE a.date >= date('$date', 'localtime', 'weekday 1', '-7 day', 'start of day');
      AND a.type = 1
      GROUP BY a.projectID;
    ''');
  print(maps);
  return maps;
}
