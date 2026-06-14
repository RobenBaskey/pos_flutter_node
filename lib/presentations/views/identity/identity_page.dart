import 'package:data_table_2/data_table_2.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pos/core/constants/enum.dart';
import 'package:pos/core/network/api_url.dart';
import 'package:pos/core/utils/utils.dart';
import 'package:pos/presentations/widgets/custom_image.dart';

import '../../../core/theme/app_colors.dart';
import '../../controller/identity_controller.dart';
import '../../widgets/circle_image.dart';
import '../../widgets/custom_container_shape.dart';
import '../../widgets/custom_divider.dart';
import '../../widgets/custom_text_field.dart';

class IdentityPage extends GetView<IdentityController> {
  const IdentityPage({super.key});

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
                        "Identity Management",
                        style: TextStyle(
                          fontWeight: FontWeight.w600,
                          fontSize: 20,
                        ),
                      ),
                    ),
                    SizedBox(width: 10),
                    IconButton(
                      onPressed: () {
                        controller.fetchIdentity();
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
                    IconButton(onPressed: () {}, icon: Icon(Icons.filter_list)),
                  ],
                ),
              ),
              CustomDivider(),
              Expanded(
                child: Obx(
                  () => controller.isLoading.value
                      ? Center(child: CircularProgressIndicator())
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
                              label: Text("Name"),
                              size: ColumnSize.L,
                            ),
                            DataColumn2(
                              label: Text("Phone"),
                              size: ColumnSize.S,
                            ),
                            DataColumn2(
                              label: Text("Front Image"),
                              size: ColumnSize.M,
                            ),
                            DataColumn2(
                              label: Text("Back Image"),
                              size: ColumnSize.M,
                            ),
                            DataColumn2(
                              label: Text("Status"),
                              size: ColumnSize.S,
                            ),
                            DataColumn2(
                              label: Text("Actions"),
                              size: ColumnSize.S,
                              headingRowAlignment: MainAxisAlignment.center,
                            ),
                          ],
                          rows: List<DataRow>.generate(
                            controller.identityList.length,
                            (index) {
                              var identity = controller.identityList[index];
                              return DataRow(
                                cells: [
                                  DataCell(
                                    Row(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      children: [
                                        CircleImage(
                                          path: identity.user?.image ?? "",
                                          height: 35,
                                          width: 35,
                                        ),
                                        SizedBox(width: 10),
                                        Expanded(
                                          child: Text(
                                            "${identity.user?.firstName} ${identity.user?.lastName}",
                                            style: TextStyle(
                                              fontWeight: FontWeight.w500,
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  DataCell(Text("${identity.user?.phone}")),
                                  DataCell(
                                    InkWell(
                                      onTap: () {
                                        Utils.showImageViewer(
                                          context,
                                          path: identity.frontImage,
                                        );
                                      },
                                      child: CustomImage(
                                        path:
                                            ApiUrl.getImageBaseUrl() +
                                            identity.frontImage,
                                        width: 50,
                                        height: 30,
                                      ),
                                    ),
                                  ),
                                  DataCell(
                                    InkWell(
                                      onTap: () {
                                        Utils.showImageViewer(
                                          context,
                                          path: identity.backImage,
                                        );
                                      },
                                      child: CustomImage(
                                        path:
                                            ApiUrl.getImageBaseUrl() +
                                            identity.backImage,
                                        width: 50,
                                        height: 30,
                                      ),
                                    ),
                                  ),
                                  DataCell(
                                    Text(
                                      identity.status.toUpperCase(),
                                      style: TextStyle(
                                        color: Utils.getStatusColor(
                                          identity.status,
                                        ),
                                      ),
                                    ),
                                  ),
                                  DataCell(
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        identity.status ==
                                                IdentityStatus.verified.name
                                            ? const SizedBox()
                                            : IconButton(
                                                onPressed: () {
                                                  Utils.showDeleteDialog(
                                                    context,
                                                    onYesTap: () {
                                                      controller.verifyIdentity(
                                                        id:
                                                            identity.user?.id ??
                                                            "",
                                                        status: IdentityStatus
                                                            .verified
                                                            .name,
                                                      );
                                                    },
                                                    isLoading:
                                                        controller.isVerifying,
                                                    title: "Approve Indentity",
                                                    description:
                                                        "Do you want to approve this identity?",
                                                    yesButtonText: "Approve",
                                                  );
                                                },
                                                icon: Icon(
                                                  Icons.check,
                                                  size: 18,
                                                  color: AppColors.primary,
                                                ),
                                              ),
                                        IconButton(
                                          onPressed: () {
                                            Utils.showDeleteDialog(
                                              context,
                                              onYesTap: () {
                                                controller.verifyIdentity(
                                                  id: identity.user?.id ?? "",
                                                  status: IdentityStatus
                                                      .rejected
                                                      .name,
                                                );
                                              },
                                              isLoading: controller.isVerifying,
                                              title: "Reject Identity",
                                              description:
                                                  "Do you want to reject this identity?",
                                              yesButtonText: "Reject",
                                            );
                                          },
                                          icon: Icon(
                                            Icons.close,
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
