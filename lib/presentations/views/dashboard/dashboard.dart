import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:pos/core/theme/app_colors.dart';
import 'package:pos/presentations/controller/dashboard_controller.dart';
import 'package:pos/presentations/widgets/custom_container_shape.dart';
import 'package:pos/presentations/widgets/custom_divider.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

import '../../../data/model/chart_data.dart';

class DashboardPage extends GetView<DashboardController> {
  const DashboardPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: CustomScrollView(
          slivers: [
            ///Dashboard history
            SliverToBoxAdapter(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Dashboard",
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 30),
                  ),
                  Text("Welcome to your point of sale dashboard"),
                  SizedBox(height: 20),
                  IntrinsicHeight(
                    child: Row(
                      children: [
                        _dashboardItemWidget(
                          context,
                          title: "TODAY'S POS SALES",
                          data: "0.00",
                          content: "Completed POS revenue today",
                          icon: Icons.attach_money_rounded,
                          color: Colors.green,
                        ),
                        SizedBox(width: 20),
                        _dashboardItemWidget(
                          context,
                          title: "TOTAL CATEGORIES",
                          data: "25",
                          content: "Active categories",
                          icon: Icons.folder_open_rounded,
                          color: Colors.blue,
                        ),
                        SizedBox(width: 20),
                        _dashboardItemWidget(
                          context,
                          title: "TOTAL PRODUCTS",
                          data: "51",
                          content: "Prodcuts in inventory",
                          icon: FontAwesomeIcons.boxOpen,
                          size: 18,
                          color: Colors.green,
                        ),
                        SizedBox(width: 20),
                        _dashboardItemWidget(
                          context,
                          title: "TOTAL USERS",
                          data: "2",
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
                          title: "TOTAL SUPPLIERS",
                          data: "26",
                          content: "Active suppliers",
                          icon: Icons.fire_truck,
                          color: Colors.orange,
                        ),
                        SizedBox(width: 20),
                        _dashboardItemWidget(
                          context,
                          title: "TOTAL LOCATIONS",
                          data: "10",
                          content: "Storage locations",
                          icon: Icons.location_pin,
                          color: Colors.cyan,
                        ),
                        SizedBox(width: 20),
                        _dashboardItemWidget(
                          context,
                          title: "TOTAL POS SALES",
                          data: "304",
                          content: "Total POS Sales",
                          icon: Icons.shopping_cart_outlined,
                          size: 18,
                          color: Colors.redAccent,
                        ),
                        SizedBox(width: 20),
                        _dashboardItemWidget(
                          context,
                          title: "TOTAL POS TERMINALS",
                          data: "6",
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
                        title: "Product Category Distribution",
                        icon: Icons.pie_chart,
                        data: controller.productCategory,
                        item: 51,
                        itemType: "Products",
                      ),
                    ),
                    SizedBox(width: 20),
                    Expanded(
                      child: _dashboardChartWidget(
                        title: "Supplier Contribution",
                        icon: Icons.fire_truck,
                        data: controller.supplierContribute,
                        item: 522,
                        itemType: "Orders",
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
                              "Recent Stock Movements",
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
                                            color: AppColors.greyTextColor,
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
    );
  }

  Widget _dashboardChartWidget({
    required String title,
    required IconData icon,
    required List<ChartData> data,
    required int item,
    required String itemType,
  }) {
    return CustomContainerShape(
      padding: 0,
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(20.0),
            child: Row(
              children: [
                Icon(icon, color: AppColors.primary),
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
                  series: <CircularSeries<ChartData, String>>[
                    DoughnutSeries<ChartData, String>(
                      dataSource: data,
                      xValueMapper: (ChartData data, _) => data.x,
                      yValueMapper: (ChartData data, _) => data.y,
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
                        item.toString(),
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
                      fontSize: 14,
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
