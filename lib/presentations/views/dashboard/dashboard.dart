import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:pos/core/theme/app_colors.dart';
import 'package:pos/presentations/controller/dashboard_controller.dart';
import 'package:pos/presentations/widgets/custom_container_shape.dart';
import 'package:pos/presentations/widgets/custom_divider.dart';
import 'package:pos/presentations/widgets/custom_shimmer.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

import '../../../domain/entities/dashboard_entity.dart';

class DashboardPage extends GetView<DashboardController> {
  const DashboardPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Obx(
          () => controller.isLoading.value
              ? dashboardShimmer()
              : CustomScrollView(
                  slivers: [
                    ///Dashboard history
                    SliverToBoxAdapter(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Dashboard",
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 30,
                            ),
                          ),
                          SizedBox(height: 20),
                          IntrinsicHeight(
                            child: Row(
                              children: [
                                _dashboardItemWidget(
                                  context,
                                  title: "TODAY'S ACTIVE USER",
                                  data:
                                      "${controller.dashboardData.value?.totalTodayActiveUser ?? 0}",
                                  content: "Daily visited users",
                                  icon: FontAwesomeIcons.users,
                                  color: Colors.green,
                                  fontSize: 13,
                                  size: 18,
                                ),
                                SizedBox(width: 20),
                                _dashboardItemWidget(
                                  context,
                                  title: "TOTAL CATEGORIES",
                                  data:
                                      "${controller.dashboardData.value?.totalCategories ?? 0}",
                                  content: "Active categories",
                                  icon: Icons.folder_open_rounded,
                                  color: Colors.blue,
                                ),
                                SizedBox(width: 20),
                                _dashboardItemWidget(
                                  context,
                                  title: "TOTAL JOBS",
                                  data:
                                      "${controller.dashboardData.value?.totalJobs ?? 0}",
                                  content: "Created jobs by customer",
                                  icon: FontAwesomeIcons.boxOpen,
                                  size: 18,
                                  color: Colors.green,
                                ),
                                SizedBox(width: 20),
                                _dashboardItemWidget(
                                  context,
                                  title: "TOTAL USERS",
                                  data:
                                      "${controller.dashboardData.value?.totalUsers ?? 0}",
                                  content: "Registered Users",
                                  icon: FontAwesomeIcons.users,
                                  color: Colors.deepPurple,
                                  size: 18,
                                ),
                              ],
                            ),
                          ),
                          SizedBox(height: 20),
                          IntrinsicHeight(
                            child: Row(
                              children: [
                                _dashboardItemWidget(
                                  context,
                                  title: "TOTAL PROVIDERS",
                                  data:
                                      "${controller.dashboardData.value?.totalProviders ?? 0}",
                                  content: "Active Providers",
                                  icon: FontAwesomeIcons.users,
                                  color: Colors.orange,
                                  size: 18,
                                ),
                                SizedBox(width: 20),
                                _dashboardItemWidget(
                                  context,
                                  title: "TOTAL CUSTOMERS",
                                  data:
                                      "${controller.dashboardData.value?.totalCustomers ?? 0}",
                                  content: "Active Customers",
                                  icon: FontAwesomeIcons.users,
                                  color: Colors.cyan,
                                  size: 18,
                                ),
                                SizedBox(width: 20),
                                _dashboardItemWidget(
                                  context,
                                  title: "TOTAL BOOKINGS",
                                  data:
                                      "${controller.dashboardData.value?.totalBookings ?? 0}",
                                  content: "Total Service Bookings",
                                  icon: Icons.shopping_cart_outlined,
                                  size: 18,
                                  color: Colors.redAccent,
                                ),
                                SizedBox(width: 20),
                                _dashboardItemWidget(
                                  context,
                                  title: "TOTAL POS TERMINALS",
                                  data: "1",
                                  content: "Active Terminals",
                                  icon: Icons.monitor,
                                  color: Colors.blue,
                                  size: 18,
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),

                    ///Product-Supplier Chart
                    SliverToBoxAdapter(
                      child: Padding(
                        padding: const EdgeInsets.only(top: 20, bottom: 20),
                        child: Row(
                          children: [
                            Expanded(
                              child: _dashboardChartWidget(
                                title: "Customer Category Distribution",
                                icon: Icons.pie_chart,
                                data:
                                    controller
                                        .dashboardData
                                        .value
                                        ?.customerDistributionByCategory ??
                                    [],
                                itemType: "Customer",
                              ),
                            ),
                            SizedBox(width: 20),
                            Expanded(
                              child: _dashboardChartWidget(
                                title: "Provider Category Distribution",
                                icon: FontAwesomeIcons.users,
                                data:
                                    controller
                                        .dashboardData
                                        .value
                                        ?.providerDistributionByCategory ??
                                    [],
                                itemType: "Providers",
                                size: 18,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),

                    SliverToBoxAdapter(
                      child: CustomContainerShape(
                        padding: 0,
                        child: Column(
                          children: [
                            Padding(
                              padding: const EdgeInsets.all(20.0),
                              child: Row(
                                children: [
                                  Icon(
                                    Icons.history_toggle_off_rounded,
                                    color: AppColors.primary,
                                  ),
                                  SizedBox(width: 8),
                                  Expanded(
                                    child: Text(
                                      "Recent Bookings",
                                      style: TextStyle(
                                        fontWeight: FontWeight.w600,
                                        fontSize: 16,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            CustomDivider(),
                            Padding(
                              padding: const EdgeInsets.all(14.0),
                              child: ListView.builder(
                                shrinkWrap: true,
                                physics: const NeverScrollableScrollPhysics(),
                                itemCount: 4,
                                itemBuilder: (context, index) {
                                  return InkWell(
                                    onTap: () {},
                                    borderRadius: BorderRadius.circular(8),
                                    child: Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Row(
                                        children: [
                                          CircleAvatar(
                                            radius: 24,
                                            backgroundColor: Colors.redAccent
                                                .withValues(alpha: 0.3),
                                            child: Icon(
                                              Icons.arrow_outward_rounded,
                                              color: Colors.redAccent,
                                              size: 18,
                                            ),
                                          ),
                                          SizedBox(width: 10),
                                          Expanded(
                                            child: Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                Text(
                                                  "Premium Cotton Bedsheet Set(DM-0023)",
                                                  style: TextStyle(
                                                    fontWeight: FontWeight.w600,
                                                  ),
                                                ),
                                                Text(
                                                  "Stock Out: 1.00 units by Store Cashier",
                                                  style: TextStyle(
                                                    color:
                                                        AppColors.greyTextColor,
                                                    fontSize: 12,
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                          SizedBox(width: 10),
                                          Text(
                                            "${DateFormat("dd-MM-yyyy").format(DateTime.now())} at ${DateFormat("hh:mm aa").format(DateTime.now())}",
                                            style: TextStyle(
                                              color: AppColors.greyTextColor,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  );
                                },
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
        ),
      ),
    );
  }

  Widget dashboardShimmer() {
    return Column(
      children: [
        Row(
          children: [
            Expanded(child: CustomShimmer(height: 140)),
            SizedBox(width: 20),
            Expanded(child: CustomShimmer(height: 140)),
            SizedBox(width: 20),
            Expanded(child: CustomShimmer(height: 140)),
            SizedBox(width: 20),
            Expanded(child: CustomShimmer(height: 140)),
          ],
        ),
        SizedBox(height: 20),
        Row(
          children: [
            Expanded(child: CustomShimmer(height: 140)),
            SizedBox(width: 20),
            Expanded(child: CustomShimmer(height: 140)),
            SizedBox(width: 20),
            Expanded(child: CustomShimmer(height: 140)),
            SizedBox(width: 20),
            Expanded(child: CustomShimmer(height: 140)),
          ],
        ),
        SizedBox(height: 20),
        Row(
          children: [
            Expanded(child: CustomShimmer(height: 220)),
            SizedBox(width: 20),
            Expanded(child: CustomShimmer(height: 220)),
          ],
        ),
      ],
    );
  }

  Widget _dashboardChartWidget({
    required String title,
    required IconData icon,
    required List<ErDistributionByCategoryEntity> data,
    required String itemType,
    double size = 24,
  }) {
    return CustomContainerShape(
      padding: 0,
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(20.0),
            child: Row(
              children: [
                Icon(icon, color: AppColors.primary, size: size),
                SizedBox(width: 8),
                Expanded(
                  child: Text(
                    title,
                    style: TextStyle(fontWeight: FontWeight.w600, fontSize: 16),
                  ),
                ),
              ],
            ),
          ),
          CustomDivider(),
          SizedBox(
            height: 240,
            width: 240,
            child: Stack(
              children: [
                SfCircularChart(
                  tooltipBehavior: TooltipBehavior(enable: true),
                  series:
                      <CircularSeries<ErDistributionByCategoryEntity, String>>[
                        DoughnutSeries<ErDistributionByCategoryEntity, String>(
                          dataSource: data,
                          xValueMapper:
                              (ErDistributionByCategoryEntity data, _) =>
                                  data.category,
                          yValueMapper:
                              (ErDistributionByCategoryEntity data, _) =>
                                  data.count,
                          name: 'Gold',
                          onPointTap: (pointInteractionDetails) {},
                        ),
                      ],
                ),
                Center(
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(
                        data.length.toString(),
                        style: TextStyle(
                          fontWeight: FontWeight.w600,
                          fontSize: 20,
                        ),
                      ),
                      Text(itemType, style: TextStyle(fontSize: 12)),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _dashboardItemWidget(
    BuildContext context, {
    required String title,
    required String data,
    required String content,
    required IconData icon,
    required Color color,
    double size = 20,
    double fontSize = 14,
  }) {
    return Expanded(
      child: CustomContainerShape(
        child: Row(
          children: [
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: TextStyle(
                      fontWeight: FontWeight.w600,
                      color: AppColors.greyLightTextColor,
                      fontSize: fontSize,
                      letterSpacing: 1.3,
                    ),
                  ),
                  SizedBox(height: 10),
                  Text(
                    data,
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 30),
                  ),
                  SizedBox(height: 2),
                  Text(
                    content,
                    style: TextStyle(
                      color: AppColors.greyLightTextColor,
                      fontSize: 12,
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(width: 6),
            CircleAvatar(
              radius: 26,
              backgroundColor: color.withValues(alpha: 0.2),
              child: Icon(icon, color: color, size: size),
            ),
          ],
        ),
      ),
    );
  }
}
