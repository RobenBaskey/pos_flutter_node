import 'package:data_table_2/data_table_2.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:pos/presentations/controller/coupon_controller.dart';
import 'package:pos/presentations/views/coupon/component/add_coupon.dart';

import '../../../core/theme/app_colors.dart';
import '../../../core/utils/utils.dart';
import '../../widgets/custom_button.dart';
import '../../widgets/custom_container_shape.dart';
import '../../widgets/custom_divider.dart';
import '../../widgets/custom_text_field.dart';

class CouponPage extends GetView<CouponController> {
  const CouponPage({super.key});

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
                        controller.getCoupons();
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
                          child: AddCoupon(),
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
                            "Add Coupon",
                            style: TextStyle(color: Colors.white),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(width: 10),
                    SizedBox(
                      width: 260,
                      child: CustomTextField(
                        hintText: "Search Coupons",
                        borderRadius: 8,
                        borderColor: Theme.of(context).colorScheme.outline,
                        suffixIcon: Icon(
                          Icons.search,
                          color: AppColors.greyLightTextColor,
                        ),
                        onChanged: (value) {
                          controller.searchCoupon(value);
                        },
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
                              label: Center(child: Text("CODE")),
                              size: ColumnSize.S,
                            ),
                            DataColumn2(
                              label: Center(child: Text("TYPE")),
                              size: ColumnSize.S,
                            ),
                            DataColumn2(
                              label: Center(child: Text("DISCOUNT")),
                              size: ColumnSize.S,
                            ),
                            DataColumn2(
                              label: Center(child: Text("LIMIT")),
                              size: ColumnSize.S,
                            ),
                            DataColumn2(
                              label: Center(child: Text("USED")),
                              size: ColumnSize.S,
                            ),
                            DataColumn2(
                              label: Center(child: Text("ACTION")),
                              fixedWidth: 200,
                            ),
                          ],
                          rows: List<DataRow>.generate(
                            controller.searchedCouponList.length,
                            (index) {
                              var coupon = controller.searchedCouponList[index];
                              return DataRow(
                                cells: [
                                  DataCell(
                                    Center(child: Text(coupon.code ?? "")),
                                  ),
                                  DataCell(
                                    Center(
                                      child: Text(
                                        (coupon.discountType ?? "")
                                            .toUpperCase(),
                                      ),
                                    ),
                                  ),
                                  DataCell(
                                    Center(
                                      child: Text(
                                        "${coupon.discountValue ?? 0}${coupon.discountType == "percentage" ? "%" : "৳"}",
                                        style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          color: AppColors.primary,
                                        ),
                                      ),
                                    ),
                                  ),
                                  DataCell(
                                    Center(
                                      child: Text(
                                        coupon.usageLimit?.toString() ?? "0",
                                      ),
                                    ),
                                  ),
                                  DataCell(
                                    Center(
                                      child: Text(
                                        coupon.usageCount?.toString() ?? "0",
                                      ),
                                    ),
                                  ),
                                  DataCell(
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        IconButton(
                                          onPressed: () {},
                                          icon: Icon(
                                            FontAwesomeIcons.eye,
                                            size: 16,
                                            color: AppColors.primary,
                                          ),
                                        ),
                                        IconButton(
                                          onPressed: () {
                                            controller.initEdit(coupon);
                                            Utils.showCustomDialog(
                                              context: context,
                                              isDissmissable: false,
                                              alignment: Alignment.center,
                                              bearerColor: Theme.of(context)
                                                  .colorScheme
                                                  .outline
                                                  .withValues(alpha: 0.4),
                                              child: AddCoupon(coupon: coupon),
                                            );
                                          },
                                          icon: Icon(
                                            FontAwesomeIcons.penToSquare,
                                            size: 16,
                                            color: AppColors.secondary,
                                          ),
                                        ),
                                        IconButton(
                                          onPressed: () {
                                            Utils.showDeleteDialog(
                                              context,
                                              onYesTap: () {
                                                controller.deleteCoupon(
                                                  coupon.id ?? "",
                                                );
                                              },
                                              isLoading:
                                                  controller.isCouponDeleting,
                                              title: "Delete Coupon",
                                              description:
                                                  "Do you want to delete this coupon?",
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
