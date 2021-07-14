import 'package:billkeeping/data/services/account_manage/account_manage_abstract.dart';
import 'package:billkeeping/data/services/account_manage/account_manage_service.dart';
import 'package:billkeeping/data/services/project_manage/project_manage_abstract.dart';
import 'package:billkeeping/data/services/project_manage/project_manage_service.dart';
import 'package:get/get.dart';

class AddAccountBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut<AbstractProjectManage>(() => ProjectManageService());
    Get.lazyPut<AbstractAccountManage>(() => AccountManageService());
  }
}
