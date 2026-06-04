import 'package:flutter/material.dart';
import 'package:flutter_quill/flutter_quill.dart';
import 'package:get/get.dart';
import 'package:pos/core/constants/app_sizes.dart';
import 'package:pos/core/service/init_services.dart';
import 'package:pos/core/theme/theme_controller.dart';
import 'package:pos/presentations/bindings/app_bindings.dart';

import 'core/theme/app_theme.dart';
import 'presentations/routes/app_pages.dart';
import 'presentations/routes/app_routes.dart';

Future main() async {
  await InitServices().onInit();
  runApp(const MyApp());
}
//

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  ThemeController get theme => Get.find();

  @override
  Widget build(BuildContext context) {
    AppSizes().init(context);
    return GetMaterialApp(
      title: "জনশক্তি",
      localizationsDelegates: [FlutterQuillLocalizations.delegate],
      debugShowCheckedModeBanner: false,
      theme: AppTheme.light,
      darkTheme: AppTheme.dark,
      initialRoute: AppRoutes.splash,
      initialBinding: AppBindings(),
      getPages: AppPages.pages,
    );
  }
}
