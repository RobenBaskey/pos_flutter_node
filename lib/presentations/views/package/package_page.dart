import 'package:data_table_2/data_table_2.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:pos/core/constants/app_constants.dart';
import 'package:pos/core/network/api_url.dart';
import 'package:pos/presentations/views/package/components/add_package.dart';
import 'package:pos/presentations/views/package/components/package_details.dart';
import 'package:pos/presentations/widgets/custom_image.dart';

import '../../../core/theme/app_colors.dart';
import '../../../core/utils/utils.dart';
import '../../controller/package_controller.dart';
import '../../widgets/custom_button.dart';
import '../../widgets/custom_container_shape.dart';
import '../../widgets/custom_divider.dart';
import '../../widgets/custom_text_field.dart';

class PackagePage extends GetView<PackageController> {
  const PackagePage({super.key});

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
                        "Package Management",
                        style: TextStyle(
                          fontWeight: FontWeight.w600,
                          fontSize: 20,
                        ),
                      ),
                    ),
                    SizedBox(width: 10),
                    IconButton(
                      onPressed: () {
                        controller.getPackages();
                      },
                      icon: Icon(Icons.replay_outlined),
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
                          child: AddPackage(),
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
                            "Add Package",
                            style: TextStyle(color: Colors.white),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(width: 10),
                    SizedBox(
                      width: 260,
                      child: CustomTextField(
                        hintText: "Search Packages",
                        borderRadius: 8,
                        borderColor: Theme.of(context).colorScheme.outline,
                        suffixIcon: Icon(
                          Icons.search,
                          color: AppColors.greyLightTextColor,
                        ),
                        onChanged: (value) {
                          controller.searchPackage(value);
                        },
                      ),
                    ),
                  ],
                ),
              ),
              CustomDivider(),
              Expanded(
                child: Obx(
                  () => controller.isPackageGetLoading.value
                      ? const Center(child: CircularProgressIndicator())
                      : DataTable2(
                          dataRowHeight: 100,
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
                            DataColumn2(
                              label: Center(child: Text("PRICE")),
                              size: ColumnSize.S,
                            ),
                            DataColumn2(
                              label: Center(child: Text("TIME")),
                              size: ColumnSize.S,
                            ),
                            DataColumn2(
                              label: Center(child: Text("ACTION")),
                              fixedWidth: 200,
                            ),
                          ],
                          rows: List<DataRow>.generate(
                            controller.searchedPackageList.length,
                            (index) {
                              var package =
                                  controller.searchedPackageList[index];
                              return DataRow(
                                cells: [
                                  DataCell(
                                    Row(
                                      children: [
                                        CustomImage(
                                          path:
                                              ApiUrl.getImageBaseUrl() +
                                              package.image!,
                                          width: 30,
                                          height: 30,
                                          fit: BoxFit.cover,
                                        ),
                                        SizedBox(width: 10),
                                        Text(package.name ?? ""),
                                      ],
                                    ),
                                  ),
                                  DataCell(
                                    Center(
                                      child: Text(
                                        "${AppConstants.taksSign}${package.price ?? 0}",
                                        style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          color: AppColors.primary,
                                        ),
                                      ),
                                    ),
                                  ),
                                  DataCell(
                                    Center(
                                      child: Text(
                                        package.isMonthly == true
                                            ? "Monthly"
                                            : "Yearly",
                                        style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          color: AppColors.primary,
                                        ),
                                      ),
                                    ),
                                  ),
                                  DataCell(
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        IconButton(
                                          onPressed: () {
                                            controller.selectedContentId(null);
                                            Utils.showCustomDialog(
                                              context: context,
                                              alignment: Alignment.centerRight,
                                              bearerColor: Theme.of(context)
                                                  .colorScheme
                                                  .outline
                                                  .withValues(alpha: 0.4),
                                              isFromRight: true,
                                              child: PackageDetails(
                                                package: package,
                                              ),
                                            );
                                          },
                                          icon: Icon(
                                            Icons.visibility,
                                            size: 16,
                                            color: AppColors.primary,
                                          ),
                                        ),
                                        IconButton(
                                          onPressed: () {
                                            controller.initPackage(package);
                                            Utils.showCustomDialog(
                                              context: context,
                                              alignment: Alignment.center,
                                              bearerColor: Theme.of(context)
                                                  .colorScheme
                                                  .outline
                                                  .withValues(alpha: 0.4),
                                              child: AddPackage(
                                                package: package,
                                              ),
                                            );
                                          },
                                          icon: FaIcon(
                                            FontAwesomeIcons.penToSquare,
                                            size: 16,
                                            color: AppColors.secondary,
                                          ),
                                        ),
                                        IconButton(
                                          onPressed: () {
                                            Utils.showDeleteDialog(
                                              context,
                                              onYesTap: () {
                                                controller.deletePackage(
                                                  package.id!,
                                                );
                                              },
                                              isLoading: false.obs,
                                              title: "Delete Package",
                                              description:
                                                  "Do you want to delete this package?",
                                            );
                                          },
                                          icon: Icon(
                                            Icons.delete,
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
