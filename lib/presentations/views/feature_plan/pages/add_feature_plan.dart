import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/state_manager.dart';
import 'package:pos/core/theme/app_colors.dart';
import 'package:pos/core/utils/utils.dart';
import 'package:pos/data/model/feature_plan_model.dart';
import 'package:pos/presentations/widgets/custom_button.dart';
import 'package:pos/presentations/widgets/custom_divider.dart';
import 'package:pos/presentations/widgets/custom_text_field.dart';

import '../../../controller/feature_plan_controller.dart';

class AddFeaturePlan extends GetView<FeaturePlanController> {
  const AddFeaturePlan({super.key, this.plan});
  final FeaturePlanModel? plan;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 700,
      child: Material(
        color: Theme.of(context).scaffoldBackgroundColor,
        borderRadius: BorderRadius.circular(12),
        child: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Padding(
                padding: const EdgeInsets.only(left: 12, top: 8, right: 8),
                child: Row(
                  children: [
                    Text(
                      plan == null
                          ? "Add New Feature Plan"
                          : "Edit Feature Plan",
                      style: TextStyle(
                        fontWeight: FontWeight.w600,
                        fontSize: 18,
                      ),
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
                    Text("Feature Plan Name *"),
                    SizedBox(height: 8),
                    CustomTextField(
                      controller: controller.nameController,
                      hintText: "Enter Feature Plan Name",
                      borderRadius: 8,
                      borderColor: Theme.of(context).colorScheme.outline,
                    ),
                    SizedBox(height: 20),
                    Text("Days *"),
                    SizedBox(height: 8),
                    CustomTextField(
                      controller: controller.dayController,
                      hintText: "Enter Days",
                      borderRadius: 8,
                      borderColor: Theme.of(context).colorScheme.outline,
                      inputType: TextInputType.number,
                      inputFormatter: [FilteringTextInputFormatter.digitsOnly],
                    ),
                    SizedBox(height: 20),
                    Text("Price *"),
                    SizedBox(height: 8),
                    CustomTextField(
                      controller: controller.priceController,
                      hintText: "Enter Price",
                      borderRadius: 8,
                      borderColor: Theme.of(context).colorScheme.outline,
                      inputType: TextInputType.number,
                      inputFormatter: [FilteringTextInputFormatter.digitsOnly],
                    ),
                    SizedBox(height: 20),

                    Row(
                      children: [
                        Expanded(child: Text("Active Status *")),
                        SizedBox(width: 8),
                        Obx(
                          () => Switch(
                            value: controller.isActive.value,
                            onChanged: (v) {
                              controller.isActive.value = v;
                            },
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 20),
                    Text("Advantages *"),
                    SizedBox(height: 6),
                    Row(
                      children: [
                        Expanded(
                          child: CustomTextField(
                            controller: controller.advantageContentController,
                            hintText: "Content",
                            borderColor: AppColors.greyTextColor.withValues(
                              alpha: 0.4,
                            ),
                            borderRadius: 8,
                          ),
                        ),
                        SizedBox(width: 8),
                        TextButton(
                          onPressed: () {
                            if (controller
                                .advantageContentController
                                .text
                                .isEmpty) {
                              Utils.showSnackBar("Please enter content");
                              return;
                            }

                            controller.advantageList.add(
                              controller.advantageContentController.text,
                            );
                            controller.advantageContentController.clear();
                          },
                          child: Text("Add New"),
                        ),
                      ],
                    ),
                    SizedBox(height: 4),
                    Obx(
                      () => Column(
                        children: List.generate(
                          controller.advantageList.length,
                          (index) {
                            return Row(
                              children: [
                                Icon(Icons.check, size: 16),
                                SizedBox(width: 8),
                                Expanded(
                                  child: Text(controller.advantageList[index]),
                                ),
                                SizedBox(width: 8),
                                IconButton(
                                  onPressed: () {
                                    controller.advantageList.removeAt(index);
                                  },
                                  icon: Icon(Icons.close, size: 16),
                                ),
                              ],
                            );
                          },
                        ),
                      ),
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
                        CustomButton(
                          onTap: () {
                            if (plan == null) {
                              controller.insertFeaturePlan();
                            } else {
                              controller.updateFeaturePlan(plan!);
                            }
                          },
                          title: plan == null ? "Save Plan" : "Update Plan",
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
      ),
    );
  }
}
