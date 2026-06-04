import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pos/presentations/views/settings/page/about_us.dart';

import '../../controller/setting_controller.dart';
import '../../widgets/custom_container_shape.dart';
import '../../widgets/custom_divider.dart';
import 'page/general_setting.dart';

class SettingsPage extends GetView<SettingController> {
  const SettingsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          SizedBox(
            width: double.infinity,
            child: Obx(
              () => Wrap(
                crossAxisAlignment: WrapCrossAlignment.start,
                alignment: WrapAlignment.start,
                children: List.generate(controller.settingItemList.length, (
                  index,
                ) {
                  return Padding(
                    padding: const EdgeInsets.only(right: 20.0),
                    child: InkWell(
                      onTap: () {
                        controller.selectedItem.value =
                            controller.settingItemList[index];
                      },
                      borderRadius: BorderRadius.circular(8),
                      child: Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 16,
                          vertical: 8,
                        ),
                        decoration: BoxDecoration(
                          border: Border.all(
                            color:
                                controller.settingItemList[index] ==
                                    controller.selectedItem.value
                                ? Theme.of(context).colorScheme.primary
                                : Colors.transparent,
                          ),
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: Text(
                          controller.settingItemList[index],
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w500,
                            color:
                                controller.settingItemList[index] ==
                                    controller.selectedItem.value
                                ? Theme.of(context).colorScheme.primary
                                : Theme.of(context).colorScheme.onSurfaceVariant
                                      .withValues(alpha: 0.4),
                          ),
                        ),
                      ),
                    ),
                  );
                }),
              ),
            ),
          ),
          SizedBox(height: 10),
          CustomDivider(),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(20.0),
              child: CustomContainerShape(
                padding: 0,
                child: Obx(
                  () => controller.selectedItem.value == "General Setting"
                      ? GeneralSetting()
                      : controller.settingKeys.containsKey(
                          controller.selectedItem.value,
                        )
                      ? AboutUs()
                      : Center(
                          child: Text(
                            controller.selectedItem.value,
                            style: TextStyle(
                              fontSize: 24,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
