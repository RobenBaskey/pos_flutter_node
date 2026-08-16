import 'package:data_table_2/data_table_2.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pos/core/constants/app_sizes.dart';
import 'package:pos/core/utils/utils.dart';
import 'package:pos/presentations/widgets/circle_image.dart';

import '../../../../core/theme/app_colors.dart';
import '../../../../data/model/purchased_plan_model.dart';
import '../../../controller/feature_plan_controller.dart';

class PurchasedPlans extends GetView<FeaturePlanController> {
  const PurchasedPlans({super.key});

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => controller.isPurchasedDataLoading.value
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
                DataColumn2(label: Text("User"), size: ColumnSize.S),
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
              rows: List<DataRow>.generate(controller.purchasedList.length, (
                index,
              ) {
                var purchasePlan = controller.purchasedList[index];
                return DataRow(
                  cells: [
                    DataCell(
                      Row(
                        children: [
                          CircleImage(
                            path: purchasePlan.user?.image ?? "",
                            height: 40,
                            width: 40,
                          ),
                          SizedBox(width: 6),
                          Text(
                            "${purchasePlan.user?.firstName ?? ""} ${purchasePlan.user?.lastName ?? ""}",
                          ),
                        ],
                      ),
                    ),
                    DataCell(
                      Center(child: Text(purchasePlan.plan?.name ?? "")),
                    ),
                    DataCell(Center(child: Text(purchasePlan.days.toString()))),
                    DataCell(
                      Center(
                        child: Text(
                          "৳${purchasePlan.price.toString()}",
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                      ),
                    ),

                    DataCell(
                      Center(
                        child: Text(
                          purchasePlan.status == "active"
                              ? "Active"
                              : "Inactive",
                          style: TextStyle(
                            color: purchasePlan.status == "active"
                                ? Colors.green
                                : Colors.red,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),

                    DataCell(
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          IconButton(
                            onPressed: () {
                              _showReviewPlanDialog(context, purchasePlan);
                            },
                            icon: Icon(Icons.edit_note),
                          ),
                        ],
                      ),
                    ),
                  ],
                );
              }),
            ),
    );
  }

  void _showReviewPlanDialog(BuildContext context, PurchasedPlanModel plan) {
    Utils.showCustomDialog(
      context: context,
      child: Center(
        child: SizedBox(
          width: AppSizes.width * 0.4,
          child: Material(
            borderRadius: BorderRadius.circular(14),
            child: Padding(
              padding: const EdgeInsets.all(20),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Header
                  Row(
                    children: [
                      Container(
                        width: 44,
                        height: 44,
                        decoration: BoxDecoration(
                          color: Colors.orange.withValues(alpha: 0.12),
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: const Icon(
                          Icons.rule_folder_outlined,
                          color: Colors.orange,
                        ),
                      ),
                      const SizedBox(width: 12),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text(
                              "Review Purchase Plan",
                              style: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.w700,
                              ),
                            ),
                            const SizedBox(height: 4),
                            Text(
                              plan.plan?.name ?? "Untitled plan",
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                              style: TextStyle(
                                color: AppColors.greyLightTextColor,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ],
                        ),
                      ),
                      IconButton(
                        onPressed: Get.back,
                        icon: const Icon(Icons.close),
                      ),
                    ],
                  ),

                  const SizedBox(height: 18),

                  // Status badge
                  _buildStatusBadge(plan.status),

                  const SizedBox(height: 18),
                  const Divider(height: 1),
                  const SizedBox(height: 18),

                  // Plan details
                  _buildDetailRow(
                    "User",
                    "${plan.user?.firstName} ${plan.user?.lastName}",
                  ),
                  _buildDetailRow(
                    "Duration",
                    plan.days != null ? "${plan.days} days" : "-",
                  ),
                  _buildDetailRow(
                    "Price",
                    plan.price != null ? "৳${plan.price}" : "-",
                  ),
                  _buildDetailRow(
                    "Purchase Date",
                    _formatDate(plan.purchaseDate),
                  ),
                  _buildDetailRow("Expiry Date", _formatDate(plan.expiryDate)),
                  _buildDetailRow(
                    "Payment Status",
                    plan.payment?.status ?? "-",
                  ),
                  const SizedBox(height: 24),

                  // Actions
                  _buildActions(context, plan),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildActions(BuildContext context, PurchasedPlanModel plan) {
    final status = plan.status?.toLowerCase();

    // Expired plans: no action allowed
    if (status == "expired") {
      return Container(
        width: double.infinity,
        padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 14),
        decoration: BoxDecoration(
          color: Colors.grey.withValues(alpha: 0.1),
          borderRadius: BorderRadius.circular(8),
        ),
        child: Row(
          children: const [
            Icon(Icons.info_outline, size: 18, color: Colors.grey),
            SizedBox(width: 8),
            Expanded(
              child: Text(
                "This plan has expired. No further action is available.",
                style: TextStyle(fontSize: 13, color: Colors.grey),
              ),
            ),
          ],
        ),
      );
    }

    final isActive = status == "active";

    return Row(
      children: [
        Expanded(
          child: OutlinedButton(
            onPressed: Get.back,
            style: OutlinedButton.styleFrom(
              padding: const EdgeInsets.symmetric(vertical: 12),
            ),
            child: const Text("Close"),
          ),
        ),
        const SizedBox(width: 12),
        Expanded(
          child: ElevatedButton.icon(
            onPressed: () => _handleStatusChange(context, plan, isActive),
            style: ElevatedButton.styleFrom(
              backgroundColor: isActive ? Colors.red : Colors.green,
              foregroundColor: Colors.white,
              padding: const EdgeInsets.symmetric(vertical: 12),
            ),
            icon: Icon(
              isActive
                  ? Icons.pause_circle_outline
                  : Icons.check_circle_outline,
              size: 18,
            ),
            label: Text(isActive ? "Deactivate" : "Activate"),
          ),
        ),
      ],
    );
  }

  void _handleStatusChange(
    BuildContext context,
    PurchasedPlanModel plan,
    bool isActive,
  ) {
    // controller.updatePlanStatus(plan.id, isActive ? "inactive" : "active");
    Get.back();
  }

  Widget _buildDetailRow(String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 6),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            width: 130,
            child: Text(
              label,
              style: TextStyle(
                fontSize: 13,
                color: AppColors.greyLightTextColor,
              ),
            ),
          ),
          Expanded(
            child: Text(
              value,
              style: const TextStyle(fontSize: 13, fontWeight: FontWeight.w600),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildStatusBadge(String? status) {
    Color color;
    IconData icon;

    switch (status?.toLowerCase()) {
      case "active":
        color = Colors.green;
        icon = Icons.check_circle;
        break;
      case "inactive":
        color = Colors.grey;
        icon = Icons.pause_circle;
        break;
      case "expired":
        color = Colors.red;
        icon = Icons.cancel;
        break;
      default:
        color = Colors.grey;
        icon = Icons.help_outline;
    }

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
      decoration: BoxDecoration(
        color: color.withValues(alpha: 0.12),
        borderRadius: BorderRadius.circular(20),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, size: 14, color: color),
          const SizedBox(width: 6),
          Text(
            (status ?? "unknown").toUpperCase(),
            style: TextStyle(
              fontSize: 12,
              fontWeight: FontWeight.w700,
              color: color,
              letterSpacing: 0.4,
            ),
          ),
        ],
      ),
    );
  }

  String _formatDate(DateTime? date) {
    if (date == null) return "-";
    return "${date.day.toString().padLeft(2, '0')}/${date.month.toString().padLeft(2, '0')}/${date.year}";
  }
}
