import 'package:get/get.dart';
import 'package:billkeeping/pages/add_account/add_account_binding.dart';
import 'package:billkeeping/pages/project_mange/add_project_page.dart';
import 'package:billkeeping/pages/project_mange/set_project_page.dart';
import 'package:billkeeping/pages/project_mange/project_mange_binding.dart';
import 'package:billkeeping/pages/add_account/add_account_page.dart';
import 'package:billkeeping/pages/tab_page/index.dart';
import 'package:billkeeping/pages/timeline/timeline.dart';
import 'package:billkeeping/pages/timeline/timeline_binding.dart';
import 'package:billkeeping/pages/account/account.dart';
import 'package:billkeeping/pages/account/account_binding.dart';

abstract class AppRoutes {
  static const Initial = '/';
  static const NextScreen = '/NextScreen';
  static const AddAccount = '/AddAccount';
  static const SetProject = '/SetProject';
  static const AddProject = '/AddProject';
  static const Timeline = '/Timeline';
  static const Account = '/Account';
  static final pages = [
    GetPage(
      name: AppRoutes.Initial,
      page: () => HomaPage(),
    ),
    GetPage(
      name: AppRoutes.AddAccount,
      binding: AddAccountBinding(),
      page: () => AddAccountPage(),
    ),
    GetPage(
      name: AppRoutes.SetProject,
      binding: ProjectManageBinding(),
      page: () => SetProjectPage(),
    ),
    GetPage(
      name: AppRoutes.AddProject,
      binding: ProjectManageBinding(),
      page: () => AddProjectPage(),
    ),
    GetPage(
      name: AppRoutes.Account,
      binding: AccountBinding(),
      page: () => AccountPage(),
    ),
    GetPage(
      name: AppRoutes.Timeline,
      binding: TimelineBinding(),
      page: () => TimelinePage(),
    )
  ];
}
