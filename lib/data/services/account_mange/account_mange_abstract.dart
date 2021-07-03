import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:billkeeping/data/models/account_info_model.dart';
import 'package:billkeeping/data/models/sum_account_model.dart';

abstract class AbstractAccountMange extends GetxController {
  // 当前时间
  String curDate;
  // 过渡方向
  AxisDirection direction = AxisDirection.down;
  List<SumAccountModel> sumAccountModelList = [];
  Map<String, double> monthSum = {
    'payMoney': 0,
    'incomeMoney': 0,
  };

  Map<String, double> weekSum = {
    'payMoney': 0,
    'incomeMoney': 0,
  };

  Map<String, double> yearSum = {
    'payMoney': 0,
    'incomeMoney': 0,
  };

  void refresh();
  void deleteAccount(int id);
  Future<int> addAccount(AccountInfoModel model);
  Future<List<SumAccountModel>> getSumAccount(String date);

  Future<void> getMonthSum(String date);
  Future<void> getWeekSum(String data);
  Future<void> getYearSum(String date);

  Map<String, double> getPieData(String type) {
    switch (type) {
      case "week":
        return this.weekSum;
      case "month":
        return this.monthSum;
      case "year":
        return this.yearSum;
      default:
        return this.monthSum;
    }
  }
}
