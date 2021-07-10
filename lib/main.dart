/* import 'package:cloudbase_auth/cloudbase_auth.dart';
import 'package:cloudbase_core/cloudbase_core.dart';
import 'package:cloudbase_function/cloudbase_function.dart'; */
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:billkeeping/pages/tab_page/index.dart';
import 'package:billkeeping/routes/routes.dart';
import 'package:billkeeping/themes/light.dart';
import 'package:billkeeping/themes/theme.dart';
import 'dart:async';
import 'package:minio/io.dart';
import 'package:minio/minio.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  print(ThemeDataInfo() == ThemeDataInfo());
  final minio = Minio(
    endPoint: 'server',
    port: 9000,
    accessKey: 'minioadmin',
    secretKey: 'minioadmin',
    useSSL: false,
  );

  const period = const Duration(minutes: 1);

  Timer.periodic(period, (_) async {
    final bucket = 'billkeeping';

    if (!await minio.bucketExists(bucket)) {
      await minio.makeBucket(bucket);
      print('bucket $bucket created');
    } else {
      print('bucket $bucket already exists');
    }

    var filepath = join(await getDatabasesPath(), 'app_database.db');
    final etag = await minio.fPutObject(bucket, 'sqlite', filepath);
    print('--- etag: $etag');
  });

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
