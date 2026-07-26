import 'package:flutter/material.dart';
import 'package:get/state_manager.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:pos/core/constants/app_sizes.dart';
import 'package:pos/core/theme/app_colors.dart';
import 'package:pos/presentations/controller/zone_controller.dart';
import 'package:pos/presentations/widgets/custom_button.dart';
import 'package:pos/presentations/widgets/custom_divider.dart';
import 'package:pos/presentations/widgets/custom_text_field.dart';

class AddZones extends GetView<ZoneController> {
  const AddZones({super.key, this.isEdit = false});
  final bool isEdit;

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
                    isEdit ? "Edit Zone" : "Add New Zone",
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
                  Text("Zone Name *"),
                  SizedBox(height: 8),
                  CustomTextField(
                    controller: controller.nameController,
                    hintText: "Enter full name",
                    borderRadius: 8,
                    borderColor: Theme.of(context).colorScheme.outline,
                  ),
                  SizedBox(height: 10),
                  Row(
                    children: [
                      Expanded(child: Text("Status")),
                      SizedBox(width: 10),
                      Obx(
                        () => Switch(
                          value: controller.isStatusActive.value,
                          onChanged: (value) {
                            controller.isStatusActive(value);
                          },
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 20),
                  SizedBox(
                    height: AppSizes.height * 0.5,
                    child: Stack(
                      children: [
                        Obx(
                          () => GoogleMap(
                            initialCameraPosition: CameraPosition(
                              target: controller.center.value,
                              zoom: 13,
                            ),
                            onMapCreated: (mPController) {
                              controller.mapController.value = mPController;
                            },

                            onTap: (position) {
                              controller.center.value = position;
                            },

                            circles: {
                              Circle(
                                circleId: const CircleId("zone"),
                                center: controller.center.value,
                                radius: controller.radius.value ?? 6000,
                                strokeWidth: 2,
                                strokeColor: Colors.blue,
                                fillColor: Colors.blue.withValues(alpha: .2),
                              ),
                            },
                          ),
                        ),
                        Positioned(
                          right: 0,
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: SizedBox(
                              width: AppSizes.width * 0.14,
                              child: Material(
                                color: AppColors.darkBackground.withValues(
                                  alpha: 0.4,
                                ),
                                borderRadius: BorderRadius.circular(8),
                                child: Padding(
                                  padding: const EdgeInsets.symmetric(
                                    horizontal: 12,
                                    vertical: 8,
                                  ),
                                  child: Column(
                                    children: [
                                      Row(
                                        children: [
                                          Text("Radius - "),
                                          Obx(
                                            () => Text(
                                              "${controller.radius.value?.toInt().toStringAsFixed(0)}",
                                            ),
                                          ),
                                        ],
                                      ),
                                      Obx(
                                        () => Slider(
                                          value:
                                              controller.radius.value ?? 6000,
                                          onChanged: (value) {
                                            controller.radius.value = value
                                                .roundToDouble();
                                          },
                                          min: 100,
                                          max: 10000,
                                          padding: EdgeInsets.symmetric(
                                            vertical: 8,
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
                      ],
                    ),
                  ),
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
                          if (isEdit) {
                            controller.updateZone();
                          } else {
                            controller.saveZone();
                          }
                        },
                        title: "Submit",
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
