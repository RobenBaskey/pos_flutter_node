import 'package:flutter/material.dart';
import 'package:get/state_manager.dart';
import 'package:pos/data/model/banner_model.dart';
import 'package:pos/presentations/controller/banner_controller.dart';
import 'package:pos/presentations/widgets/custom_button.dart';
import 'package:pos/presentations/widgets/custom_category_dropdown.dart';
import 'package:pos/presentations/widgets/custom_divider.dart';
import 'package:pos/presentations/widgets/custom_select_image_widget.dart';
import 'package:pos/presentations/widgets/custom_text_field.dart';

class AddBanner extends GetView<BannerController> {
  const AddBanner({super.key, this.banner});
  final BannerModel? banner;

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
                    "Add New Banner",
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
                  Text("Banner Name *"),
                  SizedBox(height: 8),
                  CustomTextField(
                    controller: controller.bannerNameController,
                    hintText: "Enter Banner Name",
                    borderRadius: 8,
                    borderColor: Theme.of(context).colorScheme.outline,
                  ),
                  SizedBox(height: 20),
                  Text("Category *"),
                  SizedBox(height: 8),
                  Obx(
                    () => CustomCategoryDropdown(
                      onChange: (v) {
                        controller.selectedCategory.value = v;
                      },
                      items: controller.categoryList,
                      selectedValue: controller.selectedCategory.value,
                    ),
                  ),
                  SizedBox(height: 20),
                  Text("Image *"),
                  SizedBox(height: 8),
                  Obx(
                    () => CustomSelectImageWidget(
                      onTap: () {
                        controller.pickImage();
                      },
                      onRemove: () {
                        controller.selectedLocalImage.value = null;
                      },
                      selectedImage: controller.selectedLocalImage.value,
                    ),
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
                            controller.addBanner();
                          },
                          title: "Create Banner",
                          isLoading: controller.isBannerAdding.value,
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
}
