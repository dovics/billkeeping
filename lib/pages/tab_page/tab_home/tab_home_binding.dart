import 'package:get/get.dart';
import 'package:billkeeping/data/services/account_manage/account_manage_abstract.dart';
import 'package:billkeeping/data/services/account_manage/account_manage_service.dart';

class TabHomeBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut<AbstractAccountManage>(() => AccountManageService());
  }
}
