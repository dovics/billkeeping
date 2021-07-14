/* import 'package:cloudbase_auth/cloudbase_auth.dart';
import 'package:cloudbase_core/cloudbase_core.dart';
import 'package:cloudbase_function/cloudbase_function.dart'; */
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:billkeeping/pages/tab_page/index.dart';
import 'package:billkeeping/routes/routes.dart';
import 'package:billkeeping/themes/light.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  // print(ThemeDataInfo() == ThemeDataInfo());

  runApp(
    GetMaterialApp(
      title: 'billkeeping',
      theme: themeLight,
      initialRoute: '/',
      defaultTransition: Transition.fade,
      getPages: AppRoutes.pages,
      home: HomaPage(),
    ),
  );
}
