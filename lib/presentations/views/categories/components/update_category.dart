import 'package:flutter/material.dart';
import 'package:get/state_manager.dart';
import 'package:pos/domain/entities/category_entity.dart';
import 'package:pos/presentations/controller/category_controller.dart';
import 'package:pos/presentations/widgets/custom_button.dart';
import 'package:pos/presentations/widgets/custom_divider.dart';
import 'package:pos/presentations/widgets/custom_select_image_widget.dart';
import 'package:pos/presentations/widgets/custom_text_field.dart';

class UpdateCategory extends GetView<CategoryController> {
  const UpdateCategory({super.key, required this.category});
  final CategoryEntity category;

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
                    "Update Category",
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
                  Text("Category Name *"),
                  SizedBox(height: 8),
                  CustomTextField(
                    controller: controller.updateNameController,
                    hintText: "Enter Category Name",
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
                        controller.selectedImagePath.value = null;
                      },
                      selectedImage:
                          controller.selectedImagePath.value ??
                          controller.selectedCategoryEntity.value?.image,
                      isFile: controller.selectedImagePath.value != null,
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
                    controller: controller.updateDescriptionController,
                    hintText: "Enter Category Description",
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
                            controller.updateCategory(category: category);
                          },
                          title: "Update Category",
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
