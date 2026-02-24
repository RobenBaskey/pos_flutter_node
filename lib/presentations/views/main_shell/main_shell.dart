import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pos/core/constants/app_sizes.dart';
import 'package:pos/presentations/controller/main_shell_controller.dart';
import 'package:pos/presentations/views/main_shell/widget/side_bar.dart';

import '../../../core/theme/theme_controller.dart';
import '../../widgets/pos_appbar.dart';

class MainShell extends GetView<MainShellController> {
  const MainShell({super.key});

  ThemeController get theme => Get.find();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: IntrinsicHeight(
        child: Row(
          children: [
            SizedBox(width: 300, height: AppSizes.height, child: SideBar()),
            VerticalDivider(
              color: Theme.of(context).colorScheme.outline,
              width: 1,
            ),
            Expanded(
              child: Column(
                children: [
                  PosAppbar(theme: theme),
                  Divider(
                    color: Theme.of(context).colorScheme.outline,
                    height: 1,
                  ),
                  Expanded(
                    child: Padding(
                      padding: EdgeInsets.all(8),
                      child: Obx(() {
                        return Stack(
                          children: List.generate(
                            controller.shellItemList.length,
                            (index) {
                              final isActive =
                                  controller.selectedIndex.value == index;

                              /// Do not build until first visit
                              if (!controller.isBuilt(index) && !isActive) {
                                return const SizedBox();
                              }

                              /// Mark as built
                              if (isActive) {
                                controller.markBuilt(index);
                              }

                              return Offstage(
                                offstage: !isActive,
                                child: controller.getPage(index),
                              );
                            },
                          ),
                        );
                      }),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
