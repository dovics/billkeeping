import 'package:billkeeping/data/services/all_account_manage/all_account_manage_abstract.dart';
import 'package:billkeeping/data/services/all_account_manage/all_account_manage_service.dart';
import 'package:get/get.dart';

class TimelineBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut<AbstractAllAccountManage>(() => AllAbstractAccountManage());
  }
}
