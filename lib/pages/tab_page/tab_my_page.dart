import 'package:flutter/material.dart';
import 'package:billkeeping/common/db_helper.dart';
import 'package:sqflite/sqlite_api.dart';

class TabMyPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Center(child: Column(children: [
      ElevatedButton(
        child: Text(DateTime.now().toString().substring(0, 10)),
        onPressed: () {
          getAccountsInfoByDate(DateTime.now());
        },
      ),
    ]));
  }
}

Future<void> getAccountsInfoByDate(DateTime date) async {
     Database db = await DbHelper.getDb();
     var dateString = date.toString().substring(0, 10);
    final List<Map<String, dynamic>> maps = await db.rawQuery('''
      SELECT a.id,a.projectID,p.name,a.type,p.icon,a.date,a.remark,CASE WHEN a.type = 1 THEN a.payMoney ELSE a.incomeMoney END money
      FROM account a LEFT JOIN project p on a.projectID=p.id
      WHERE strftime('%Y-%m-%d', a.date) = '$dateString'
    ''');
    print(maps);
  }
