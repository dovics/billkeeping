import 'package:billkeeping/data/services/account_manage/account_manage_abstract.dart';
import 'package:billkeeping/data/services/account_manage/account_manage_service.dart';
import 'package:get/get.dart';

class AllAccountsBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut<AbstractAccountManage>(() => AccountManageService());
  }
}
