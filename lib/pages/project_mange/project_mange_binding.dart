import 'package:get/get.dart';
import 'package:billkeeping/data/services/project_manage/project_manage_abstract.dart';
import 'package:billkeeping/data/services/project_manage/project_manage_service.dart';

class ProjectManageBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut<AbstractProjectManage>(() => ProjectManageService());
  }
}
