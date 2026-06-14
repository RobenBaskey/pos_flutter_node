import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:pos/core/constants/app_constants.dart';
import 'package:pos/core/theme/app_colors.dart';
import 'package:pos/presentations/controller/main_shell_controller.dart';
import 'package:pos/presentations/routes/app_routes.dart';
import 'package:pos/presentations/widgets/custom_divider.dart';
import 'package:pos/presentations/widgets/custom_image.dart';

import '../../../../core/constants/app_icons.dart';

class SideBar extends GetView<MainShellController> {
  const SideBar({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(height: 14),
        Obx(
          () => Row(
            children: [
              Expanded(
                child: controller.isMinimized.value
                    ? CustomImage(path: AppIcons.logo, height: 40)
                    : Text(
                        AppConstants.appName,
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 30,
                        ),
                      ),
              ),
              IconButton(
                onPressed: () {
                  controller.isMinimized.value = !controller.isMinimized.value;
                },
                icon: CustomImage(
                  path: controller.isMinimized.value
                      ? AppIcons.rightChevron
                      : AppIcons.leftChevron,
                  height: 20,
                  color: Colors.white,
                ),
              ),
            ],
          ),
        ),
        // Text(
        //   "Your Point of Sale Solution",
        //   style: TextStyle(height: 1, fontSize: 10),
        // ),
        SizedBox(height: 14),
        Expanded(
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: ListView.builder(
              itemCount: controller.shellItemList.length,
              itemBuilder: (context, index) {
                var item = controller.shellItemList[index];
                return _navBarItem(
                  index: index,
                  icon: item.icon,
                  title: item.name,
                  size: item.size,
                  color: item.color,
                  isDivider: item.isDivider,
                  isMinimized: controller.isMinimized.value,
                );
              },
            ),
          ),
        ),
      ],
    );
  }

  Widget _navBarItem({
    required int index,
    required FaIconData icon,
    required String title,
    double size = 20,
    Color? color,
    bool? isDivider,
    bool isMinimized = false,
  }) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.only(bottom: 6.0, top: 6),
          child: InkWell(
            onTap: () {
              if (title.toLowerCase().contains("logout")) {
                Get.offAllNamed(AppRoutes.login);
              } else {
                controller.selectedIndex.value = index;
              }
            },
            borderRadius: BorderRadius.circular(8),
            child: Obx(
              () => Material(
                color: controller.selectedIndex.value == index
                    ? AppColors.primary.withValues(alpha: 0.1)
                    : Colors.transparent,
                borderRadius: BorderRadius.circular(8),
                child: Padding(
                  padding: const EdgeInsets.all(10),
                  child: Row(
                    children: [
                      SizedBox(
                        height: 30,
                        width: 30,
                        child: FaIcon(
                          icon,
                          size: size,
                          color:
                              color ??
                              (controller.selectedIndex.value == index
                                  ? AppColors.primary
                                  : AppColors.greyTextColor),
                        ),
                      ),
                      SizedBox(width: 10),
                      Expanded(
                        child: isMinimized
                            ? const SizedBox()
                            : Text(
                                title,
                                style: TextStyle(
                                  fontSize: 13,
                                  fontWeight: FontWeight.w600,
                                  color:
                                      color ??
                                      (controller.selectedIndex.value == index
                                          ? AppColors.primary
                                          : AppColors.greyTextColor),
                                ),
                              ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
        isDivider == true ? CustomDivider() : const SizedBox(),
      ],
    );
  }
}
