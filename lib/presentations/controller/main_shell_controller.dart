import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:pos/data/model/shell_model.dart';
import 'package:pos/presentations/views/ai_reports/ai_reports.dart';
import 'package:pos/presentations/views/bookings/bookings_page.dart';
import 'package:pos/presentations/views/categories/category_page.dart';
import 'package:pos/presentations/views/coupon/coupon_page.dart';
import 'package:pos/presentations/views/dashboard/dashboard.dart';
import 'package:pos/presentations/views/job_type/job_type.dart';
import 'package:pos/presentations/views/jobs/jobs.dart';
import 'package:pos/presentations/views/locations/location_page.dart';
import 'package:pos/presentations/views/package/package_page.dart';
import 'package:pos/presentations/views/payment_methods/payment_methods.dart';
import 'package:pos/presentations/views/profile/profile_page.dart';
import 'package:pos/presentations/views/providers/provider_page.dart';
import 'package:pos/presentations/views/reports/report_page.dart';
import 'package:pos/presentations/views/roles/role_page.dart';
import 'package:pos/presentations/views/settings/settings_page.dart';
import 'package:pos/presentations/views/workplace_type/workplace_type_page.dart';

import '../views/customers/customer_page.dart';

class MainShellController extends GetxController {
  var selectedIndex = 0.obs;

  var shellItemList = <ShellModel>[
    ShellModel(
      icon: Icons.dashboard_outlined,
      name: "Dashboard",
      page: DashboardPage(),
    ),
    //ShellModel(icon: Icons.monitor, name: "POS Terminals", page: PosTerminal()),
    ShellModel(icon: Icons.badge, name: "Jobs", page: JobsPage()),
    ShellModel(
      icon: Icons.select_all_rounded,
      name: "Bookings",
      page: BookingsPage(),
      isDivider: true,
    ),
    ShellModel(
      icon: FontAwesomeIcons.briefcase,
      size: 18,
      name: "Job Type",
      page: JobTypePage(),
    ),
    ShellModel(
      icon: Icons.work_outline,
      name: "Workplace Type",
      page: WorkplaceTypePage(),
    ),
    ShellModel(
      icon: Icons.folder_open_rounded,
      name: "Categories",
      page: CategoryPage(),
    ),
    ShellModel(
      icon: Icons.price_change_outlined,
      name: "Package",
      page: PackagePage(),
    ),
    ShellModel(
      icon: Icons.local_offer_outlined,
      name: "Coupen",
      page: CouponPage(),
      isDivider: true,
    ),

    ShellModel(
      icon: FontAwesomeIcons.userCheck,
      size: 18,
      name: "Providers",
      page: ProviderPage(),
    ),
    ShellModel(
      icon: FontAwesomeIcons.userCheck,
      size: 18,
      name: "Customers",
      page: CustomerPage(),
    ),
    ShellModel(
      icon: Icons.perm_identity,
      name: "Identity",
      page: LocationPage(),
      isDivider: true,
    ),

    ShellModel(
      icon: Icons.payment_rounded,
      name: "Payment Methods",
      page: PaymentMethods(),
      isDivider: true,
    ),
    ShellModel(
      icon: FontAwesomeIcons.fileLines,
      size: 18,
      name: "Reports",
      page: ReportPage(),
    ),
    ShellModel(
      icon: FontAwesomeIcons.bots,
      size: 18,
      name: "AI Reports",
      page: AiReports(),
      isDivider: true,
    ),
    ShellModel(
      icon: Icons.shield_outlined,
      name: "Roles",
      page: RolePage(),
      isDivider: true,
    ),

    ShellModel(icon: Icons.settings, name: "Settings", page: SettingsPage()),
    ShellModel(
      icon: Icons.person_2_outlined,
      name: "Profile",
      page: ProfilePage(),
    ),
    ShellModel(
      icon: Icons.logout,
      color: Colors.red,
      name: "Logout",
      page: SizedBox(),
    ),
  ];

  /// Track which pages have been built
  final List<bool> _built = [];

  /// Cache built pages
  final List<Widget?> _cache = [];

  @override
  void onInit() {
    super.onInit();
    _built.addAll(List.generate(shellItemList.length, (_) => false));
    _cache.addAll(List.generate(shellItemList.length, (_) => null));
  }

  bool isBuilt(int index) => _built[index];

  void markBuilt(int index) {
    _built[index] = true;
  }

  Widget getPage(int index) {
    if (_cache[index] == null) {
      _cache[index] = shellItemList[index].page;
    }
    return _cache[index]!;
  }

  void changeIndex(int index) {
    selectedIndex.value = index;
  }
}
