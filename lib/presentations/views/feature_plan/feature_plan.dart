import 'package:data_table_2/data_table_2.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pos/presentations/views/feature_plan/pages/add_feature_plan.dart';
import 'package:pos/presentations/views/feature_plan/pages/purchased_plans.dart';

import '../../../core/theme/app_colors.dart';
import '../../../core/utils/utils.dart';
import '../../controller/feature_plan_controller.dart';
import '../../widgets/custom_button.dart';
import '../../widgets/custom_container_shape.dart';
import '../../widgets/custom_divider.dart';

class FeaturePlan extends GetView<FeaturePlanController> {
  const FeaturePlan({super.key});

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
                      child: Obx(
                        () => Row(
                          children: [
                            TextButton(
                              onPressed: () {
                                controller.isFeaturePlanTabActive.value = true;
                              },
                              child: Text(
                                "Feature Plans",
                                style: TextStyle(
                                  fontWeight: FontWeight.w600,
                                  fontSize: 20,
                                  color:
                                      !controller.isFeaturePlanTabActive.value
                                      ? AppColors.greyTextColor.withValues(
                                          alpha: 0.6,
                                        )
                                      : Colors.white,
                                  decoration:
                                      !controller.isFeaturePlanTabActive.value
                                      ? null
                                      : TextDecoration.underline,
                                ),
                              ),
                            ),
                            TextButton(
                              onPressed: () {
                                controller.isFeaturePlanTabActive.value = false;
                                if (controller.purchasedList.isEmpty) {
                                  controller.getPurchasedFeature();
                                }
                              },
                              child: Text(
                                "Purchased Plans",
                                style: TextStyle(
                                  fontWeight: FontWeight.w600,
                                  fontSize: 20,
                                  color: controller.isFeaturePlanTabActive.value
                                      ? AppColors.greyTextColor.withValues(
                                          alpha: 0.6,
                                        )
                                      : Colors.white,
                                  decoration:
                                      controller.isFeaturePlanTabActive.value
                                      ? null
                                      : TextDecoration.underline,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    SizedBox(width: 10),
                    IconButton(
                      onPressed: () {
                        if (controller.isFeaturePlanTabActive.value) {
                          controller.getFeaturePlan();
                        } else {
                          controller.getPurchasedFeature();
                        }
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
                          child: AddFeaturePlan(),
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
                            "Add Feature Plans",
                            style: TextStyle(color: Colors.white),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(width: 10),
                  ],
                ),
              ),
              CustomDivider(),
              Expanded(
                child: Obx(
                  () => controller.isFeaturePlanTabActive.value
                      ? controller.isLoading.value
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
                                    label: Center(child: Text("NAME")),
                                    size: ColumnSize.S,
                                  ),
                                  DataColumn2(
                                    label: Center(child: Text("DAYS")),
                                    size: ColumnSize.S,
                                  ),
                                  DataColumn2(
                                    label: Center(child: Text("PRICE")),
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
                                  controller.featurePlans.length,
                                  (index) {
                                    var featurePlan =
                                        controller.featurePlans[index];
                                    return DataRow(
                                      cells: [
                                        DataCell(
                                          Center(child: Text(featurePlan.name)),
                                        ),
                                        DataCell(
                                          Center(
                                            child: Text(
                                              featurePlan.days.toString(),
                                            ),
                                          ),
                                        ),
                                        DataCell(
                                          Center(
                                            child: Text(
                                              "৳${featurePlan.price.toString()}",
                                              style: TextStyle(
                                                fontWeight: FontWeight.bold,
                                              ),
                                            ),
                                          ),
                                        ),

                                        DataCell(
                                          Center(
                                            child: Text(
                                              featurePlan.status
                                                  ? "Active"
                                                  : "Inactive",
                                              style: TextStyle(
                                                color: featurePlan.status
                                                    ? Colors.green
                                                    : Colors.red,
                                                fontWeight: FontWeight.bold,
                                              ),
                                            ),
                                          ),
                                        ),

                                        DataCell(
                                          Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            children: [
                                              IconButton(
                                                onPressed: () {
                                                  controller.initUpdate(
                                                    featurePlan,
                                                  );
                                                  Utils.showCustomDialog(
                                                    context: context,
                                                    alignment: Alignment.center,
                                                    bearerColor:
                                                        Theme.of(context)
                                                            .colorScheme
                                                            .outline
                                                            .withValues(
                                                              alpha: 0.4,
                                                            ),
                                                    child: AddFeaturePlan(
                                                      plan: featurePlan,
                                                    ),
                                                  );
                                                },
                                                icon: Icon(
                                                  Icons.edit,
                                                  size: 20,
                                                  color: AppColors.secondary,
                                                ),
                                              ),
                                              IconButton(
                                                onPressed: () {
                                                  Utils.showDeleteDialog(
                                                    context,
                                                    onYesTap: () {},
                                                    isLoading: false.obs,
                                                    title:
                                                        "Delete Feature Plan",
                                                    description:
                                                        "Do you want to delete this feature plan?",
                                                  );
                                                },
                                                icon: Icon(
                                                  Icons.delete,
                                                  size: 18,
                                                  color: AppColors.warningColor,
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ],
                                    );
                                  },
                                ),
                              )
                      : PurchasedPlans(),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
