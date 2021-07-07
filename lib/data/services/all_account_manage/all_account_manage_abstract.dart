import 'package:get/get.dart';
import 'package:billkeeping/data/models/account_info_model.dart';

abstract class AbstractAllAccountManage extends GetxController {
  List<AccountInfoModel> allAccounts = List.empty();
  List<AccountInfoModel> accountByDate = List.empty();

  Future<void> getAllAccounts();
  Future<void> getAccountsByDate(DateTime date);
}
