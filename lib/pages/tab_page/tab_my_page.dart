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
            getWeekSum(DateTime.now().toString().substring(0, 10)).then((value) => {
              print(value)
            });
          })
    ]);
  }
}

Future<Map<String, double>> getWeekSum(String date) async {
  Database db = await DbHelper.getDb();
  final List<Map<String, dynamic>> maps = await db.rawQuery('''
      SELECT ifnull(SUM(a.payMoney), 0) payMoney,ifnull(SUM(a.incomeMoney), 0) incomeMoney
      FROM account a
      WHERE strftime('%Y-%m-%d', a.date) = '$date';
    ''');

  return {
    'payMoney': (maps[0]['payMoney'] as num).toDouble(),
    'incomeMoney': (maps[0]['incomeMoney'] as num).toDouble(),
  };
}
