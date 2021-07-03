import 'package:billkeeping/common/db_helper.dart';
import 'package:sqflite/sqlite_api.dart';

class ChartDbProvider {
  final String tableName = 'account';

  ChartDbProvider._();
  factory ChartDbProvider() => _sharedInstance();
  static ChartDbProvider _instance;
  static ChartDbProvider _sharedInstance() {
    if (_instance == null) _instance = ChartDbProvider._();
    return _instance;
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

  /// 获取当月合计
  Future<Map<String, double>> getMonthSum(String date) async {
    Database db = await DbHelper.getDb();
    final List<Map<String, dynamic>> maps = await db.rawQuery('''
      SELECT ifnull(SUM(a.payMoney), 0) payMoney,ifnull(SUM(a.incomeMoney), 0) incomeMoney
      FROM account a
      WHERE strftime('%Y-%m', a.date) = '$date';
    ''');
    return {
      'payMoney': (maps[0]['payMoney'] as num).toDouble(),
      'incomeMoney': (maps[0]['incomeMoney'] as num).toDouble(),
    };
  }

  Future<Map<String, double>> getYearSum(String date) async {
    Database db = await DbHelper.getDb();
    final List<Map<String, dynamic>> maps = await db.rawQuery('''
      SELECT ifnull(SUM(a.payMoney), 0) payMoney,ifnull(SUM(a.incomeMoney), 0) incomeMoney
      FROM account a
      WHERE strftime('%Y', a.date) = '$date';
    ''');
    return {
      'payMoney': (maps[0]['payMoney'] as num).toDouble(),
      'incomeMoney': (maps[0]['incomeMoney'] as num).toDouble(),
    };
  }
}
