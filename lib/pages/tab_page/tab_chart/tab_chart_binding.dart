import 'package:get/get.dart';
import 'package:billkeeping/data/services/account_mange/account_mange_abstract.dart';
import 'package:billkeeping/data/services/account_mange/account_mange_service.dart';

class TabChartBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut<AbstractAccountMange>(() => AccountMangeService());
  }
}
