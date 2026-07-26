import 'package:data_table_2/data_table_2.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pos/presentations/controller/zone_controller.dart';
import 'package:pos/presentations/views/zones/widgets/insert_zones.dart';

import '../../../core/theme/app_colors.dart';
import '../../../core/utils/utils.dart';
import '../../widgets/custom_button.dart';
import '../../widgets/custom_container_shape.dart';
import '../../widgets/custom_divider.dart';
import '../../widgets/custom_text_field.dart';

class ZonePage extends GetView<ZoneController> {
  const ZonePage({super.key});

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
                        "Zones Management",
                        style: TextStyle(
                          fontWeight: FontWeight.w600,
                          fontSize: 20,
                        ),
                      ),
                    ),
                    SizedBox(width: 10),
                    IconButton(
                      onPressed: () {
                        controller.getZones();
                      },
                      icon: Icon(Icons.refresh),
                    ),
                    SizedBox(width: 10),
                    SizedBox(
                      width: 260,
                      child: CustomTextField(
                        onChanged: (value) {},
                        hintText: "Search roles...",
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
                          child: AddZones(),
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
                            "Add Zone",
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
                  () => controller.isZoneGetLoading.value
                      ? const Center(child: CircularProgressIndicator())
                      : DataTable2(
                          minWidth: 900,
                          dataRowHeight: 70,
                          columnSpacing: 12,
                          horizontalMargin: 12,
                          headingTextStyle: TextStyle(
                            color: AppColors.greyLightTextColor,
                            fontSize: 12,
                            fontWeight: FontWeight.w600,
                          ),
                          dividerThickness: 0.1,
                          columns: [
                            DataColumn2(
                              label: Text("NAME"),
                              size: ColumnSize.M,
                            ),
                            DataColumn2(label: Text("LAT"), size: ColumnSize.M),
                            DataColumn2(
                              label: Text("LONG"),
                              size: ColumnSize.M,
                            ),
                            DataColumn2(
                              label: Text("RADIUS"),
                              size: ColumnSize.M,
                            ),
                            DataColumn2(
                              label: Text("STATUS"),
                              size: ColumnSize.M,
                            ),
                            DataColumn2(label: Text("ACTION"), fixedWidth: 160),
                          ],
                          rows: List<DataRow>.generate(
                            controller.zoneList.length,
                            (index) {
                              final zone = controller.zoneList[index];
                              return DataRow(
                                cells: [
                                  DataCell(
                                    Text(
                                      zone.name,
                                      maxLines: 1,
                                      style: TextStyle(
                                        fontSize: 12,
                                        fontWeight: FontWeight.w600,
                                        overflow: TextOverflow.ellipsis,
                                      ),
                                    ),
                                  ),
                                  DataCell(Text(zone.lat)),
                                  DataCell(Text(zone.long)),
                                  DataCell(Text(zone.radius.toString())),
                                  DataCell(
                                    Text(
                                      zone.status ? "Active" : "In-Active",
                                      style: TextStyle(
                                        color: zone.status
                                            ? AppColors.primary
                                            : AppColors.greyLightTextColor,
                                        fontWeight: FontWeight.w600,
                                      ),
                                    ),
                                  ),
                                  DataCell(
                                    Row(
                                      mainAxisSize: MainAxisSize.min,
                                      children: [
                                        IconButton(
                                          onPressed: () {
                                            controller.prepareUpdateData(zone);
                                            Utils.showCustomDialog(
                                              context: context,
                                              alignment: Alignment.center,
                                              bearerColor: Theme.of(context)
                                                  .colorScheme
                                                  .outline
                                                  .withValues(alpha: 0.4),
                                              child: AddZones(isEdit: true),
                                            );
                                          },
                                          icon: Icon(
                                            Icons.edit_outlined,
                                            size: 18,
                                            color: AppColors.secondary,
                                          ),
                                        ),
                                        IconButton(
                                          onPressed: () {
                                            Utils.showDeleteDialog(
                                              context,
                                              onYesTap: () {
                                                controller.deleteZone(zone.id);
                                              },
                                              title: "Delete Zone",
                                              description:
                                                  "Are you sure you want to delete this zone? This action cannot be undone.",
                                              isLoading: false.obs,
                                            );
                                          },
                                          icon: Icon(
                                            Icons.delete_outline,
                                            size: 18,
                                            color: AppColors.warningColor,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              );
                            },
                          ),
                        ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
