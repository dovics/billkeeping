import 'package:flutter/material.dart';
import 'package:billkeeping/data/models/account_info_model.dart';
import 'package:billkeeping/data/models/sum_account_model.dart';
import 'package:billkeeping/data/provider/account_db_provider.dart';
import 'package:billkeeping/data/services/account_mange/account_mange_abstract.dart';
import 'package:billkeeping/data/provider/chart_db_provider.dart';

class AccountMangeService extends AbstractAccountMange {
  @override
  void deleteAccount(int id) {}

  @override
  Future<int> addAccount(AccountInfoModel model) {
    AccountDbProvider adp = AccountDbProvider();
    return adp.insertAccount(
        projectID: model.projectID,
        money: model.money,
        date: model.date,
        remark: model.remark,
        type: model.type);
  }

  @override
  Future<List<SumAccountModel>> getSumAccount(String date) async {
    AccountDbProvider adp = AccountDbProvider();
    sumAccountModelList = await adp.getSumAccount(date);
    await getMonthSum(date);
    if (DateTime.parse('$date-01')
        .isBefore(DateTime.parse('${this.curDate}-01'))) {
      this.direction = AxisDirection.down;
    } else {
      this.direction = AxisDirection.up;
    }
    this.curDate = date;
    // update();
    return sumAccountModelList;
  }

  @override
  Future<void> getMonthSum(String date) async {
    AccountDbProvider adp = AccountDbProvider();
    monthSum = await adp.getMonthSum(date);
  }

  @override
  Future<void> getWeekSum(String date) async {
    ChartDbProvider adp = ChartDbProvider();
    weekSum = await adp.getWeekSum(date);
  }

  @override
  Future<void> getYearSum(String date) async {
    ChartDbProvider adp = ChartDbProvider();
    yearSum = await adp.getYearSum(date);
  }

  @override
  void onReady() {
    super.onReady();
    this.curDate = DateTime.now().toString();
    getSumAccount(this.curDate.substring(0, 7));
    getWeekSum(this.curDate.substring(0, 10));
    getYearSum(this.curDate.substring(0, 4));
    print('ready');
  }
  
  @override
  void refresh() {
    super.refresh();
    this.curDate = DateTime.now().toString();
    getSumAccount(this.curDate.substring(0, 7));
    getWeekSum(this.curDate.substring(0, 10));
    getYearSum(this.curDate.substring(0, 4));
  }
}
