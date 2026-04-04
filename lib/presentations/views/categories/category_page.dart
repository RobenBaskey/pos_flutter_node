import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/state_manager.dart';
import 'package:pos/core/network/api_url.dart';
import 'package:pos/core/utils/utils.dart';
import 'package:pos/presentations/controller/category_controller.dart';
import 'package:pos/presentations/views/categories/components/add_category.dart';
import 'package:pos/presentations/views/categories/components/update_category.dart';
import 'package:pos/presentations/widgets/custom_image.dart';

import '../../../core/theme/app_colors.dart';
import '../../widgets/custom_button.dart';
import '../../widgets/custom_container_shape.dart';
import '../../widgets/custom_divider.dart';
import '../../widgets/custom_text_field.dart';

class CategoryPage extends GetView<CategoryController> {
  const CategoryPage({super.key});

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
                        "Categories Management",
                        style: TextStyle(
                          fontWeight: FontWeight.w600,
                          fontSize: 20,
                        ),
                      ),
                    ),
                    SizedBox(width: 10),
                    IconButton(
                      onPressed: () {
                        controller.getCategories();
                      },
                      icon: Icon(Icons.refresh),
                    ),
                    SizedBox(width: 10),
                    SizedBox(
                      width: 260,
                      child: CustomTextField(
                        hintText: "Search",
                        borderRadius: 8,
                        borderColor: Theme.of(context).colorScheme.outline,
                        suffixIcon: Icon(
                          Icons.search,
                          color: AppColors.greyLightTextColor,
                        ),
                      ),
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
                          child: AddCategory(),
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
                            "Add Category",
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
                  () => controller.isCategoryLoading.value
                      ? Center(child: CircularProgressIndicator())
                      : Column(
                          children: [
                            Padding(
                              padding: const EdgeInsets.symmetric(
                                horizontal: 20,
                                vertical: 24,
                              ),
                              child: Row(
                                children: [
                                  Expanded(
                                    child: Text(
                                      "CATEGORY NAME",
                                      style: TextStyle(
                                        color: AppColors.greyTextColor,
                                        fontSize: 13,
                                        fontWeight: FontWeight.w600,
                                      ),
                                    ),
                                  ),
                                  Text(
                                    "ACTION",
                                    style: TextStyle(
                                      color: AppColors.greyTextColor,
                                      fontSize: 13,
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            CustomDivider(),
                            Expanded(
                              child: ListView.builder(
                                itemCount: controller.categoryList.length,
                                itemBuilder: (context, index) {
                                  var catItem = controller.categoryList[index];
                                  return Column(
                                    children: [
                                      Padding(
                                        padding: EdgeInsets.only(
                                          left: 20,
                                          right: 20,
                                          top: 20,
                                          bottom:
                                              (catItem.children?.isEmpty ??
                                                  false)
                                              ? 20
                                              : 8,
                                        ),
                                        child: Column(
                                          children: [
                                            Row(
                                              children: [
                                                CustomImage(
                                                  path:
                                                      "${ApiUrl.getImageBaseUrl()}${catItem.image}",
                                                  height: 24,
                                                  width: 24,
                                                ),
                                                SizedBox(width: 10),
                                                Expanded(
                                                  child: Text(
                                                    catItem.name ?? "",
                                                  ),
                                                ),
                                                Row(
                                                  mainAxisSize:
                                                      MainAxisSize.min,
                                                  children: [
                                                    IconButton(
                                                      onPressed: () {
                                                        Utils.showCustomDialog(
                                                          context: context,
                                                          alignment:
                                                              Alignment.center,
                                                          bearerColor:
                                                              Theme.of(context)
                                                                  .colorScheme
                                                                  .outline
                                                                  .withValues(
                                                                    alpha: 0.4,
                                                                  ),
                                                          child: AddCategory(
                                                            category: catItem,
                                                          ),
                                                        );
                                                      },
                                                      icon: Icon(
                                                        FontAwesomeIcons.plus,
                                                        size: 16,
                                                        color:
                                                            AppColors.primary,
                                                      ),
                                                    ),
                                                    IconButton(
                                                      onPressed: () {
                                                        controller
                                                                .updateNameController
                                                                .text =
                                                            catItem.name ?? "";
                                                        Utils.showCustomDialog(
                                                          context: context,
                                                          alignment:
                                                              Alignment.center,
                                                          bearerColor:
                                                              Theme.of(context)
                                                                  .colorScheme
                                                                  .outline
                                                                  .withValues(
                                                                    alpha: 0.4,
                                                                  ),
                                                          child: UpdateCategory(
                                                            category: catItem,
                                                          ),
                                                        );
                                                      },
                                                      icon: Icon(
                                                        FontAwesomeIcons
                                                            .penToSquare,
                                                        size: 16,
                                                        color:
                                                            AppColors.secondary,
                                                      ),
                                                    ),
                                                    IconButton(
                                                      onPressed: () {
                                                        showDeleteDialog(
                                                          context,
                                                          catItem.id ?? "",
                                                        );
                                                      },
                                                      icon: Icon(
                                                        Icons.delete,
                                                        size: 18,
                                                        color: AppColors
                                                            .warningColor,
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              ],
                                            ),
                                            (catItem.children?.isNotEmpty ??
                                                    false)
                                                ? Padding(
                                                    padding:
                                                        const EdgeInsets.only(
                                                          left: 30,
                                                          top: 16,
                                                        ),
                                                    child: ListView.builder(
                                                      physics:
                                                          const NeverScrollableScrollPhysics(),
                                                      shrinkWrap: true,
                                                      itemCount: catItem
                                                          .children
                                                          ?.length,
                                                      itemBuilder: (context, subIndex) {
                                                        var childItem = catItem
                                                            .children![subIndex];
                                                        return Column(
                                                          children: [
                                                            CustomDivider(),
                                                            Padding(
                                                              padding:
                                                                  const EdgeInsets.symmetric(
                                                                    vertical:
                                                                        10.0,
                                                                  ),
                                                              child: Row(
                                                                children: [
                                                                  Icon(
                                                                    Icons
                                                                        .remove,
                                                                  ),
                                                                  SizedBox(
                                                                    width: 6,
                                                                  ),
                                                                  CustomImage(
                                                                    path:
                                                                        "${ApiUrl.getImageBaseUrl()}${childItem.image}",
                                                                    height: 24,
                                                                    width: 24,
                                                                  ),
                                                                  SizedBox(
                                                                    width: 10,
                                                                  ),
                                                                  Expanded(
                                                                    child: Text(
                                                                      childItem
                                                                              .name ??
                                                                          "",
                                                                    ),
                                                                  ),
                                                                  Row(
                                                                    mainAxisSize:
                                                                        MainAxisSize
                                                                            .min,
                                                                    children: [
                                                                      IconButton(
                                                                        onPressed:
                                                                            () {},
                                                                        icon: Icon(
                                                                          FontAwesomeIcons
                                                                              .penToSquare,
                                                                          size:
                                                                              16,
                                                                          color:
                                                                              AppColors.secondary,
                                                                        ),
                                                                      ),
                                                                      IconButton(
                                                                        onPressed: () {
                                                                          showDeleteDialog(
                                                                            context,
                                                                            catItem.id ??
                                                                                "",
                                                                          );
                                                                        },
                                                                        icon: Icon(
                                                                          Icons
                                                                              .delete,
                                                                          size:
                                                                              18,
                                                                          color:
                                                                              AppColors.warningColor,
                                                                        ),
                                                                      ),
                                                                    ],
                                                                  ),
                                                                ],
                                                              ),
                                                            ),
                                                          ],
                                                        );
                                                      },
                                                    ),
                                                  )
                                                : const SizedBox(),
                                          ],
                                        ),
                                      ),
                                      CustomDivider(),
                                    ],
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
      ),
    );
  }

  void showDeleteDialog(BuildContext context, String id) {
    Utils.showCustomDialog(
      context: context,
      alignment: Alignment.center,
      bearerColor: Theme.of(context).colorScheme.outline.withValues(alpha: 0.4),
      child: SizedBox(
        width: 280,
        child: Material(
          borderRadius: BorderRadius.circular(8),
          child: Padding(
            padding: const EdgeInsets.all(12.0),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Delete Category",
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
                ),
                SizedBox(height: 10),
                Text(
                  "Are you sure you want to delete this category?",
                  style: TextStyle(fontSize: 14, fontWeight: FontWeight.w600),
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
                      verticalPadding: 12,
                      horizontalPadding: 20,
                      borderRadius: 8,
                      color: Theme.of(
                        context,
                      ).colorScheme.outline.withValues(alpha: 0.2),
                    ),
                    SizedBox(width: 10),
                    Obx(
                      () => CustomButton(
                        onTap: () {
                          controller.deleteCategory(id);
                        },
                        isLoading: controller.isCategoryDeleting.value,
                        title: "Delete",
                        verticalPadding: 12,
                        horizontalPadding: 20,
                        borderRadius: 8,
                        color: AppColors.warningColor,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
