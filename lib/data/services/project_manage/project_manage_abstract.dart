import 'package:get/get.dart';
import 'package:billkeeping/data/models/project_model.dart';

abstract class AbstractProjectManage extends GetxController {
  Map<String, List<ProjectModel>> projectMap = {
    'pay': [],
    'income': [],
  };
  Future<void> loadPayProjects();
  Future<void> loadIncomeProjects();
  void sortProject(String type, int oldIndex, int newIndex);
  void addProject(String name, String iconStr, String type);
  Future<void> stopOrStartProject(ProjectModel pm, String type);
}
