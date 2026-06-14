import 'package:flutter/material.dart';
import 'package:get/state_manager.dart';
import 'package:pos/domain/entities/category_entity.dart';
import 'package:pos/presentations/controller/category_controller.dart';
import 'package:pos/presentations/widgets/custom_button.dart';
import 'package:pos/presentations/widgets/custom_divider.dart';
import 'package:pos/presentations/widgets/custom_select_image_widget.dart';
import 'package:pos/presentations/widgets/custom_text_field.dart';

import '../../../../core/network/api_url.dart';
import '../../../widgets/custom_image.dart';

class AddCategory extends GetView<CategoryController> {
  const AddCategory({super.key, this.category});
  final CategoryEntity? category;

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
                    "Add New ${category != null ? "Sub " : ""}Category",
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
                  category != null
                      ? Column(
                          children: [
                            Material(
                              borderRadius: BorderRadius.circular(14),
                              child: Padding(
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 14,
                                  vertical: 10,
                                ),
                                child: Row(
                                  children: [
                                    SizedBox(
                                      width: 24,
                                      height: 24,
                                      child: CustomImage(
                                        path:
                                            "${ApiUrl.getImageBaseUrl()}${category!.image}",
                                        fit: BoxFit.cover,
                                      ),
                                    ),
                                    SizedBox(width: 20),
                                    Expanded(
                                      child: Text(
                                        category?.name ?? "",
                                        maxLines: 1,
                                        style: TextStyle(
                                          fontSize: 12,
                                          fontWeight: FontWeight.w600,
                                          overflow: TextOverflow.ellipsis,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            SizedBox(height: 20),
                          ],
                        )
                      : const SizedBox(),
                  Text(
                    category != null ? "Sub Category Name" : "Category Name *",
                  ),
                  SizedBox(height: 8),
                  CustomTextField(
                    controller: controller.categoryNameController,
                    hintText:
                        "Enter ${category != null ? "Sub " : ""}Category Name",
                    borderRadius: 8,
                    borderColor: Theme.of(context).colorScheme.outline,
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
                          value: controller.isStatusActive.value,
                          onChanged: (v) {
                            controller.isStatusActive.value = v;
                          },
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 20),
                  Text("Description"),
                  SizedBox(height: 8),
                  CustomTextField(
                    controller: controller.categoryDescriptionController,
                    hintText:
                        "Enter ${category != null ? "Sub " : ""}Category Description",
                    borderRadius: 8,
                    borderColor: Theme.of(context).colorScheme.outline,
                    maxLines: 4,
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
                            controller.addCategory(category: category);
                          },
                          title:
                              "Create ${category != null ? "Sub " : ""}Category",
                          isLoading: controller.isCategoryAdding.value,
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
