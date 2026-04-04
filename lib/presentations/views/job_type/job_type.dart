import 'package:data_table_2/data_table_2.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:pos/core/utils/utils.dart';
import 'package:pos/presentations/controller/job_type_controller.dart';
import 'package:pos/presentations/widgets/custom_button.dart';

import '../../../core/theme/app_colors.dart';
import '../../widgets/custom_container_shape.dart';
import '../../widgets/custom_divider.dart';
import '../../widgets/custom_text_field.dart';

class JobTypePage extends GetView<JobTypeController> {
  const JobTypePage({super.key});

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
                        "Job Type Management",
                        style: TextStyle(
                          fontWeight: FontWeight.w600,
                          fontSize: 20,
                        ),
                      ),
                    ),
                    SizedBox(width: 10),
                    SizedBox(
                      width: 260,
                      child: CustomTextField(
                        hintText: "Search Job Type",
                        borderRadius: 8,
                        borderColor: Theme.of(context).colorScheme.outline,
                        suffixIcon: Icon(
                          Icons.search,
                          color: AppColors.greyLightTextColor,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              CustomDivider(),
              Expanded(
                child: Row(
                  children: [
                    Expanded(
                      child: Padding(
                        padding: const EdgeInsets.all(20.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text("Add Job Type"),
                            SizedBox(height: 30),
                            CustomTextField(
                              controller: controller.typeNameController,
                              hintText: "Job Type name",
                              borderRadius: 8,
                              borderColor: Theme.of(
                                context,
                              ).colorScheme.outline,
                            ),
                            SizedBox(height: 30),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                CustomButton(
                                  onTap: () {
                                    controller.typeNameController.clear();
                                    controller.selectedJobType.value = null;
                                  },
                                  title: "Reset",
                                  horizontalPadding: 20,
                                  borderRadius: 8,
                                  color: AppColors.greyTextColor,
                                ),
                                Obx(
                                  () => CustomButton(
                                    onTap: () {
                                      if (controller.selectedJobType.value !=
                                          null) {
                                        controller.updateJobType();
                                      } else {
                                        controller.addJobType();
                                      }
                                    },
                                    title:
                                        controller.selectedJobType.value != null
                                        ? "Update"
                                        : "Add",
                                    horizontalPadding: 40,
                                    borderRadius: 8,
                                    isLoading: controller.isAdding.value,
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                    CustomDivider(isVertical: true),
                    Expanded(
                      flex: 2,
                      child: Obx(
                        () => controller.isJobTypeLoading.value
                            ? Center(child: CircularProgressIndicator())
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
                                    label: Center(child: Text("TITLE")),
                                    size: ColumnSize.M,
                                  ),
                                  DataColumn2(
                                    label: Center(child: Text("ACTION")),
                                    fixedWidth: 200,
                                  ),
                                ],
                                rows: List<DataRow>.generate(
                                  controller.jobList.length,
                                  (index) {
                                    var job = controller.jobList[index];
                                    return DataRow(
                                      cells: [
                                        DataCell(
                                          Center(child: Text(job.title ?? "")),
                                        ),
                                        DataCell(
                                          Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            children: [
                                              IconButton(
                                                onPressed: () {
                                                  controller
                                                          .typeNameController
                                                          .text =
                                                      job.title ?? "";
                                                  controller
                                                          .selectedJobType
                                                          .value =
                                                      job;
                                                },
                                                icon: Icon(
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
                                                      controller
                                                          .deleteWorkplace(
                                                            job.id ?? "",
                                                          );
                                                    },
                                                    isLoading: controller.isDeleting,
                                                    
                                                    title: "Delete Job Type",
                                                    description: "De you want to delete this job type?",
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
            ],
          ),
        ),
      ),
    );
  }
}
