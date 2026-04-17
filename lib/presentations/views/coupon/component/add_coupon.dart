import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/state_manager.dart';
import 'package:pos/domain/entities/coupon_entity.dart';
import 'package:pos/presentations/controller/coupon_controller.dart';
import 'package:pos/presentations/widgets/custom_button.dart';
import 'package:pos/presentations/widgets/custom_divider.dart';
import 'package:pos/presentations/widgets/custom_text_field.dart';

import '../../../../core/theme/app_colors.dart';

class AddCoupon extends GetView<CouponController> {
  const AddCoupon({super.key, this.coupon});
  final CouponEntity? coupon;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 700,
      child: Material(
        color: Theme.of(context).scaffoldBackgroundColor,
        borderRadius: BorderRadius.circular(12),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Padding(
              padding: const EdgeInsets.only(left: 12, top: 8, right: 8),
              child: Row(
                children: [
                  Text(
                    coupon == null ? "Add New Coupon" : "Edit Coupon",
                    style: TextStyle(fontWeight: FontWeight.w600, fontSize: 18),
                  ),
                  Spacer(),
                  IconButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    icon: Icon(Icons.close),
                  ),
                ],
              ),
            ),
            CustomDivider(),
            SizedBox(height: 20),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text("Coupon Code *"),
                  SizedBox(height: 8),
                  CustomTextField(
                    controller: controller.codeController,
                    hintText: "Enter Coupon Code",
                    borderRadius: 8,
                    borderColor: Theme.of(context).colorScheme.outline,
                  ),
                  SizedBox(height: 20),
                  Text("Discount Value *"),
                  SizedBox(height: 8),
                  CustomTextField(
                    controller: controller.discountValueController,
                    hintText: "Enter Discount Value",
                    borderRadius: 8,
                    borderColor: Theme.of(context).colorScheme.outline,
                    inputType: TextInputType.number,
                    inputFormatter: [FilteringTextInputFormatter.digitsOnly],
                  ),
                  SizedBox(height: 20),
                  Text("Discount Type *"),
                  SizedBox(height: 8),
                  Row(
                    children: [
                      Expanded(
                        child: _packgeTimeType(context, isMonthly: true),
                      ),
                      SizedBox(width: 12),
                      Expanded(
                        child: _packgeTimeType(context, isMonthly: false),
                      ),
                    ],
                  ),
                  SizedBox(height: 20),
                  Text("Used Limit*"),
                  SizedBox(height: 8),
                  CustomTextField(
                    controller: controller.usageLimitController,
                    hintText: "Enter Used Limit",
                    borderRadius: 8,
                    borderColor: Theme.of(context).colorScheme.outline,
                    inputType: TextInputType.number,
                    inputFormatter: [FilteringTextInputFormatter.digitsOnly],
                  ),
                  SizedBox(height: 20),
                  Text("Min Order Value *"),
                  SizedBox(height: 8),
                  CustomTextField(
                    controller: controller.minOrderValueController,
                    hintText: "Enter Min Order Value",
                    borderRadius: 8,
                    borderColor: Theme.of(context).colorScheme.outline,
                    inputType: TextInputType.number,
                    inputFormatter: [FilteringTextInputFormatter.digitsOnly],
                  ),
                  SizedBox(height: 20),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      CustomButton(
                        onTap: () {
                          Navigator.pop(context);
                        },
                        title: "Cancel",
                        color: Theme.of(context).scaffoldBackgroundColor,
                        borderColor: Theme.of(context).colorScheme.outline,
                        titleColor: Theme.of(
                          context,
                        ).primaryTextTheme.labelSmall?.color,
                        horizontalPadding: 20,
                      ),
                      SizedBox(width: 20),
                      Obx(
                        () => CustomButton(
                          onTap: () {
                            if (coupon == null) {
                              controller.addCoupon();
                            } else {
                              controller.editCoupon(coupon?.id ?? "");
                            }
                          },
                          isLoading: controller.isCouponAdding.value,
                          title: coupon == null
                              ? "Save Coupon"
                              : "Update Coupon",
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 20),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _packgeTimeType(BuildContext context, {bool isMonthly = false}) {
    return InkWell(
      onTap: () {
        controller.isPercentage.value = isMonthly;
      },
      borderRadius: BorderRadius.circular(8),
      child: Obx(
        () => Container(
          padding: EdgeInsets.symmetric(vertical: 12, horizontal: 8),
          decoration: BoxDecoration(
            border: controller.isPercentage.value == isMonthly
                ? Border.all(color: AppColors.primary)
                : Border.all(color: Theme.of(context).colorScheme.outline),
            borderRadius: BorderRadius.circular(8),
          ),
          child: Row(
            children: [
              CircleAvatar(
                radius: 8,
                backgroundColor: controller.isPercentage.value == isMonthly
                    ? Theme.of(context).primaryColor
                    : Colors.grey.withValues(alpha: 0.4),
              ),
              Expanded(
                child: Center(child: Text(isMonthly ? "Percentage" : "Fixed")),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
