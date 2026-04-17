import 'package:get/get.dart';
import 'package:pos/presentations/bindings/category_bindings.dart';
import 'package:pos/presentations/bindings/coupon_bindings.dart';
import 'package:pos/presentations/bindings/job_type_bindings.dart';
import 'package:pos/presentations/bindings/login_bindings.dart';
import 'package:pos/presentations/bindings/main_shell_bindings.dart';
import 'package:pos/presentations/bindings/package_bindings.dart';
import 'package:pos/presentations/bindings/provider_bindings.dart';
import 'package:pos/presentations/bindings/workplace_type_bindings.dart';
import 'package:pos/presentations/views/main_shell/main_shell.dart';

import '../views/login/login_page.dart';
import '../views/splash/splash_page.dart';
import 'app_routes.dart';

class AppPages {
  static final pages = [
    GetPage(name: AppRoutes.splash, page: () => SplashPage()),
    GetPage(
      name: AppRoutes.login,
      binding: LoginBindings(),
      page: () => LoginPage(),
    ),
    GetPage(
      name: AppRoutes.mainShell,
      bindings: [
        MainShellBindings(),
        JobTypeBindings(),
        CategoryBindings(),
        WorkplaceTypeBindings(),
        PackageBindings(),
        CouponBindings(),
        ProviderBindings(),
      ],
      page: () => MainShell(),
    ),
  ];
}
