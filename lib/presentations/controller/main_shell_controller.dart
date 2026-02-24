import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:pos/data/model/shell_model.dart';
import 'package:pos/presentations/views/ai_reports/ai_reports.dart';
import 'package:pos/presentations/views/brands/brand_page.dart';
import 'package:pos/presentations/views/categories/category_page.dart';
import 'package:pos/presentations/views/clients/client_page.dart';
import 'package:pos/presentations/views/dashboard/dashboard.dart';
import 'package:pos/presentations/views/locations/location_page.dart';
import 'package:pos/presentations/views/orders/pos_orders.dart';
import 'package:pos/presentations/views/payment_methods/payment_methods.dart';
import 'package:pos/presentations/views/products/product_page.dart';
import 'package:pos/presentations/views/profile/profile_page.dart';
import 'package:pos/presentations/views/purchase_order/purchase_order.dart';
import 'package:pos/presentations/views/purchase_requisition/purchase_requisition.dart';
import 'package:pos/presentations/views/reports/report_page.dart';
import 'package:pos/presentations/views/roles/role_page.dart';
import 'package:pos/presentations/views/settings/settings_page.dart';
import 'package:pos/presentations/views/stock_movement/stock_movement.dart';
import 'package:pos/presentations/views/suppliers/suppliers_page.dart';
import 'package:pos/presentations/views/terminal/pos_terminal.dart';
import 'package:pos/presentations/views/units/units_page.dart';
import 'package:pos/presentations/views/users/user_page.dart';

class MainShellController extends GetxController {
  var selectedIndex = 0.obs;

  var shellItemList = <ShellModel>[
    ShellModel(
      icon: Icons.dashboard_outlined,
      name: "Dashboard",
      page: DashboardPage(),
    ),
    ShellModel(icon: Icons.monitor, name: "POS Terminals", page: PosTerminal()),
    ShellModel(
      icon: Icons.shopping_cart_outlined,
      name: "POS Orders",
      page: PosOrders(),
      isDivider: true,
    ),
    ShellModel(
      icon: FontAwesomeIcons.boxOpen,
      size: 18,
      name: "Products",
      page: ProductPage(),
    ),
    ShellModel(
      icon: Icons.folder_open_rounded,
      name: "Categories",
      page: CategoryPage(),
    ),
    ShellModel(
      icon: Icons.folder_open_rounded,
      name: "Units",
      page: UnitsPage(),
    ),
    ShellModel(
      icon: Icons.folder_open_rounded,
      name: "Brands",
      page: BrandPage(),
      isDivider: true,
    ),

    ShellModel(
      icon: FontAwesomeIcons.userCheck,
      size: 18,
      name: "Clients",
      page: ClientPage(),
    ),
    ShellModel(
      icon: Icons.folder_open_rounded,
      name: "Suppliers",
      page: SuppliersPage(),
    ),
    ShellModel(
      icon: Icons.location_pin,
      name: "Locations",
      page: LocationPage(),
      isDivider: true,
    ),
    ShellModel(
      icon: Icons.bookmark_border_rounded,
      name: "Purchase Requisition",
      page: PurchaseRequisition(),
    ),
    ShellModel(
      icon: Icons.bookmark_border_rounded,
      name: "Purchase Order",
      page: PurchaseOrder(),
    ),
    ShellModel(
      icon: FontAwesomeIcons.leftRight,
      size: 18,
      name: "Stock Movement",
      page: StockMovement(),
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
      icon: FontAwesomeIcons.users,
      size: 18,
      name: "Users",
      page: UserPage(),
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
