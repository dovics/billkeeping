import 'package:billkeeping/common/db_helper.dart';
import 'package:billkeeping/data/models/account_info_model.dart';
import 'package:sqflite/sqlite_api.dart';

class AllAccountsDbProvider {
   final String tableName = 'account';

  AllAccountsDbProvider._();
  factory AllAccountsDbProvider() => _sharedInstance();
  static AllAccountsDbProvider _instance;
  static AllAccountsDbProvider _sharedInstance() {
    if (_instance == null) _instance = AllAccountsDbProvider._();
    return _instance;
  }

  Future<List<AccountInfoModel>> getAccountInfo(String date) async {
    Database db = await DbHelper.getDb();
    final List<Map<String, dynamic>> maps = await db.rawQuery('''
      SELECT a.id,a.projectID,p.name,a.type,p.icon,a.date,a.remark,CASE WHEN a.type = 1 THEN a.payMoney ELSE a.incomeMoney END money
      FROM account a LEFT JOIN project p on a.projectID=p.id
    ''');
    return List.generate(maps.length, (i) {
      return AccountInfoModel(
        id: maps[i]['id'],
        projectID: maps[i]['projectID'],
        money: (maps[i]['money'] as num).toDouble(),
        name: maps[i]['name'],
        type: maps[i]['type'],
        icon: maps[i]['icon'],
        date: maps[i]['date'],
        remark: maps[i]['remark'],
      );
    });
  }

}