import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:pos/core/constants/app_sizes.dart';
import 'package:pos/core/theme/app_colors.dart';
import 'package:pos/core/utils/utils.dart';
import 'package:pos/domain/entities/package_entity.dart';
import 'package:pos/presentations/controller/package_controller.dart';
import 'package:pos/presentations/widgets/custom_button.dart';
import 'package:pos/presentations/widgets/custom_divider.dart';
import 'package:pos/presentations/widgets/custom_text_field.dart';
import 'package:pos/presentations/widgets/glass_widget.dart';

import '../../../../core/network/api_url.dart';
import '../../../widgets/custom_image.dart';

class PackageDetails extends StatefulWidget {
  const PackageDetails({super.key, required this.package});
  final PackageEntity package;

  @override
  State<PackageDetails> createState() => _PackageDetailsState();
}

class _PackageDetailsState extends State<PackageDetails> {
  final controller = Get.find<PackageController>();

  @override
  void initState() {
    controller.getSinglePackage(widget.package.id ?? "");
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: AppSizes.width * 0.3,
      height: AppSizes.height,
      child: Material(
        color: Theme.of(context).scaffoldBackgroundColor,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.only(top: 8, left: 12),
                    child: Text("Package Details"),
                  ),
                ),
                IconButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  icon: Icon(Icons.close),
                ),
              ],
            ),
            SizedBox(height: 20),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    GlassWidget(
                      child: Row(
                        children: [
                          CustomImage(
                            path:
                                ApiUrl.getImageBaseUrl() +
                                widget.package.image!,
                            width: 30,
                            height: 30,
                            fit: BoxFit.cover,
                          ),
                          SizedBox(width: 10),
                          Text(widget.package.name ?? ""),
                        ],
                      ),
                    ),
                    SizedBox(height: 20),
                    GlassWidget(
                      child: Column(
                        children: [
                          Obx(
                            () => Row(
                              children: [
                                Expanded(
                                  child: Text(
                                    controller.selectedContentId.value != null
                                        ? "Update Content"
                                        : "Insert Content",
                                  ),
                                ),
                                SizedBox(width: 8),
                                controller.selectedContentId.value != null
                                    ? IconButton(
                                        onPressed: () {
                                          controller.contentController.clear();
                                          controller.isContentActive(true);
                                          controller.selectedContentId(null);
                                        },
                                        icon: Icon(Icons.close),
                                      )
                                    : const SizedBox(),
                              ],
                            ),
                          ),
                          SizedBox(height: 10),
                          Row(
                            children: [
                              Expanded(
                                child: CustomTextField(
                                  controller: controller.contentController,
                                  hintText: "Content name",
                                  borderRadius: 8,
                                  borderColor: Theme.of(
                                    context,
                                  ).colorScheme.outline,
                                ),
                              ),
                              SizedBox(width: 8),
                              Obx(
                                () => Switch(
                                  value: controller.isContentActive.value,
                                  onChanged: (value) {
                                    controller.isContentActive.value = value;
                                  },
                                ),
                              ),
                            ],
                          ),
                          SizedBox(height: 10),
                          CustomTextField(
                            controller: controller.limitController,
                            hintText: "Limit",
                            borderRadius: 8,
                            borderColor: Theme.of(context).colorScheme.outline,
                            inputType: TextInputType.number,
                            inputFormatter: [
                              FilteringTextInputFormatter.digitsOnly,
                            ],
                          ),
                        ],
                      ),
                    ),
                    SizedBox(height: 10),
                    Obx(
                      () => CustomButton(
                        onTap: () {
                          if (controller.contentController.text.isEmpty) {
                            Utils.showSnackBar(
                              "Please enter content name",
                              title: "Warning",
                            );
                            return;
                          }

                          if (controller.selectedContentId.value != null) {
                            controller.updateContent(
                              packageId: widget.package.id ?? "",
                              contentId:
                                  controller.selectedContentId.value ?? "",
                            );
                          } else {
                            controller.addContent(
                              packageId: widget.package.id ?? "",
                            );
                          }
                        },
                        title: controller.selectedContentId.value != null
                            ? "Update"
                            : "Submit",
                        isLoading: controller.isContentLoading.value,
                      ),
                    ),
                    SizedBox(height: 30),
                    Text("Contents"),
                    SizedBox(height: 10),
                    Expanded(
                      child: GlassWidget(
                        child: Obx(
                          () => ListView.builder(
                            itemCount: controller.contentList.length,
                            itemBuilder: (context, index) {
                              var content = controller.contentList[index];
                              return Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Row(
                                    children: [
                                      content.isActive == true
                                          ? Icon(
                                              Icons.check,
                                              color: AppColors.primary,
                                            )
                                          : Icon(
                                              Icons.close,
                                              color: AppColors.greyTextColor,
                                            ),
                                      SizedBox(width: 4),
                                      Expanded(
                                        child: Text(
                                          content.name ?? "",
                                          style: TextStyle(
                                            color: content.isActive == true
                                                ? Colors.white
                                                : AppColors.greyLightTextColor
                                                      .withValues(alpha: 0.8),
                                          ),
                                        ),
                                      ),
                                      SizedBox(width: 6),
                                      IconButton(
                                        onPressed: () {
                                          controller.selectedContentId(
                                            content.id,
                                          );
                                          controller.contentController.text =
                                              content.name ?? "";
                                          controller.isContentActive.value =
                                              content.isActive ?? false;
                                        },
                                        icon: Icon(Icons.edit, size: 18),
                                      ),
                                      IconButton(
                                        onPressed: () {
                                          Utils.showDeleteDialog(
                                            context,
                                            onYesTap: () {
                                              Navigator.pop(context);
                                              controller.deleteContent(
                                                packageId:
                                                    widget.package.id ?? "",
                                                contentId: content.id ?? "",
                                              );
                                            },
                                            isLoading: false.obs,
                                            title: "Delete Content",
                                            description:
                                                "Do you want to delete this content?",
                                          );
                                        },
                                        icon: Icon(
                                          Icons.delete,
                                          size: 18,
                                          color: Colors.red,
                                        ),
                                      ),
                                    ],
                                  ),

                                  content.limit != null
                                      ? Padding(
                                          padding: EdgeInsets.only(
                                            left: 30,
                                            bottom: 8,
                                          ),
                                          child: RichText(
                                            text: TextSpan(
                                              style: TextStyle(
                                                color: Colors.white,
                                              ),
                                              children: [
                                                TextSpan(text: "Limit : "),
                                                TextSpan(
                                                  text: "${content.limit}",
                                                  style: TextStyle(
                                                    fontWeight: FontWeight.bold,
                                                    color: AppColors.primary,
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                        )
                                      : const SizedBox(height: 4),
                                  CustomDivider(),
                                  SizedBox(height: 8),
                                ],
                              );
                            },
                          ),
                        ),
                      ),
                    ),
                    SizedBox(height: 10),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
