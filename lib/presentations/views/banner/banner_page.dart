import 'package:data_table_2/data_table_2.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pos/core/network/api_url.dart';
import 'package:pos/presentations/views/banner/components/add_banner.dart';
import 'package:pos/presentations/widgets/custom_image.dart';

import '../../../core/theme/app_colors.dart';
import '../../../core/utils/utils.dart';
import '../../controller/banner_controller.dart';
import '../../widgets/custom_button.dart';
import '../../widgets/custom_container_shape.dart';
import '../../widgets/custom_divider.dart';

class BannerPage extends GetView<BannerController> {
  const BannerPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: CustomContainerShape(
          padding: 0,
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 20,
                  vertical: 14,
                ),
                child: Row(
                  children: [
                    Expanded(
                      child: Text(
                        "Coupon Management",
                        style: TextStyle(
                          fontWeight: FontWeight.w600,
                          fontSize: 20,
                        ),
                      ),
                    ),
                    SizedBox(width: 10),
                    IconButton(
                      onPressed: () {
                        controller.getBanners();
                      },
                      icon: Icon(Icons.replay_outlined),
                    ),
                    SizedBox(width: 10),
                    CustomButton(
                      onTap: () {
                        Utils.showCustomDialog(
                          context: context,
                          alignment: Alignment.center,
                          bearerColor: Theme.of(
                            context,
                          ).colorScheme.outline.withValues(alpha: 0.4),
                          child: AddBanner(),
                        );
                      },
                      title: "",
                      verticalPadding: 20,
                      horizontalPadding: 14,
                      borderRadius: 8,
                      child: Row(
                        children: [
                          Icon(Icons.add, color: Colors.white),
                          SizedBox(width: 6),
                          Text(
                            "Add Banner",
                            style: TextStyle(color: Colors.white),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              CustomDivider(),
              Expanded(
                child: Obx(
                  () => controller.isLoading.value
                      ? Center(child: CircularProgressIndicator())
                      : DataTable2(
                          dataRowHeight: 100,
                          columnSpacing: 12,
                          horizontalMargin: 12,
                          headingTextStyle: TextStyle(
                            color: AppColors.greyLightTextColor,
                            fontSize: 12,
                            fontWeight: FontWeight.w600,
                          ),
                          dividerThickness: 0.1,
                          columns: [
                            DataColumn2(
                              label: Center(child: Text("IMAGE")),
                              size: ColumnSize.S,
                            ),
                            DataColumn2(
                              label: Center(child: Text("NAME")),
                              size: ColumnSize.S,
                            ),
                            DataColumn2(
                              label: Center(child: Text("CATEGORY")),
                              size: ColumnSize.S,
                            ),
                            DataColumn2(
                              label: Center(child: Text("AMOUNT")),
                              size: ColumnSize.S,
                            ),
                            DataColumn2(
                              label: Center(child: Text("STATUS")),
                              size: ColumnSize.S,
                            ),
                            DataColumn2(
                              label: Center(child: Text("ACTION")),
                              fixedWidth: 200,
                            ),
                          ],
                          rows: List<DataRow>.generate(
                            controller.bannerList.length,
                            (index) {
                              var item = controller.bannerList[index];
                              return DataRow(
                                cells: [
                                  DataCell(
                                    Center(
                                      child: CustomImage(
                                        path:
                                            ApiUrl.getImageBaseUrl() +
                                            (item.image ?? ""),
                                        width: 50,
                                        height: 50,
                                      ),
                                    ),
                                  ),
                                  DataCell(
                                    Center(child: Text(item.name ?? "N/A")),
                                  ),
                                  DataCell(
                                    Center(child: Text(item.categoryId ?? "")),
                                  ),
                                  DataCell(
                                    Center(
                                      child: Text(
                                        item.offerAmmount?.toString() ?? "N/A",
                                      ),
                                    ),
                                  ),
                                  DataCell(Center(child: Text("STATUS"))),
                                  DataCell(
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        IconButton(
                                          onPressed: () {
                                            // Handle edit action
                                          },
                                          icon: Icon(Icons.edit),
                                        ),
                                        IconButton(
                                          onPressed: () {
                                            // Handle delete action
                                          },
                                          icon: Icon(Icons.delete),
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              );
                            },
                          ),
                        ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
