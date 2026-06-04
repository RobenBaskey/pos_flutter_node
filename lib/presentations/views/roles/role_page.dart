import 'package:data_table_2/data_table_2.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:pos/core/constants/enum.dart';
import 'package:pos/presentations/controller/role_controller.dart';

import '../../../core/theme/app_colors.dart';
import '../../../core/utils/utils.dart';
import '../../widgets/custom_button.dart';
import '../../widgets/custom_container_shape.dart';
import '../../widgets/custom_divider.dart';
import '../../widgets/custom_text_field.dart';
import 'components/add_roles.dart';

class RolePage extends GetView<RoleController> {
  const RolePage({super.key});

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
                        "Roles Management",
                        style: TextStyle(
                          fontWeight: FontWeight.w600,
                          fontSize: 20,
                        ),
                      ),
                    ),
                    SizedBox(width: 10),
                    IconButton(
                      onPressed: () {
                        controller.fetchRoles();
                      },
                      icon: Icon(Icons.refresh),
                    ),
                    SizedBox(width: 10),
                    SizedBox(
                      width: 260,
                      child: CustomTextField(
                        onChanged: (value) {
                          controller.searchRoles(value);
                        },
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
                          child: AddRoles(),
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
                            "Add Role",
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
                  () => controller.isLoading.value
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
                              label: Text("ROLE NAME"),
                              size: ColumnSize.M,
                            ),
                            DataColumn2(
                              label: Text("PHONE"),
                              size: ColumnSize.L,
                            ),
                            DataColumn2(
                              label: Text("TYPE"),
                              size: ColumnSize.M,
                            ),
                            DataColumn2(
                              label: Text("CREATED AT"),
                              size: ColumnSize.M,
                            ),
                            DataColumn2(label: Text("ACTION"), fixedWidth: 160),
                          ],
                          rows: List<DataRow>.generate(
                            controller.filterRoleList.length,
                            (index) {
                              final role = controller.filterRoleList[index];
                              return DataRow(
                                cells: [
                                  DataCell(
                                    SizedBox(
                                      width: double.maxFinite,
                                      child: Row(
                                        children: [
                                          CircleAvatar(
                                            radius: 18,
                                            backgroundColor: AppColors.primary,
                                            child: Icon(
                                              Icons.folder_outlined,
                                              size: 16,
                                              color: Colors.white,
                                            ),
                                          ),
                                          SizedBox(width: 8),
                                          Expanded(
                                            child: Text(
                                              role.fullName,
                                              maxLines: 1,
                                              style: TextStyle(
                                                fontSize: 12,
                                                fontWeight: FontWeight.w600,
                                                overflow: TextOverflow.ellipsis,
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                  DataCell(Text(role.phone)),
                                  DataCell(Text(role.role)),
                                  DataCell(
                                    Text(
                                      DateFormat(
                                        "dd MMM yyyy",
                                      ).format(role.createdAt),
                                    ),
                                  ),
                                  DataCell(
                                    Row(
                                      mainAxisSize: MainAxisSize.min,
                                      children: [
                                        IconButton(
                                          onPressed: () {
                                            if (role.role ==
                                                UserRole.super_admin.name) {
                                            } else {
                                              Utils.showSnackBar(
                                                "You are not allowed to edit this role.",
                                              );
                                              return;
                                            }
                                          },
                                          icon: Icon(
                                            Icons.edit_outlined,
                                            size: 18,
                                            color: AppColors.secondary,
                                          ),
                                        ),
                                        IconButton(
                                          onPressed: () {
                                            if (Utils.isSuperAdmin()) {
                                              Utils.showDeleteDialog(
                                                context,
                                                onYesTap: () => controller
                                                    .deleteRole(role.id),
                                                title: "Delete Role",
                                                description:
                                                    "Are you sure you want to delete this role? This action cannot be undone.",
                                                isLoading: controller.isLoading,
                                              );
                                            } else {
                                              Utils.showSnackBar(
                                                "You are not allowed to edit this role.",
                                              );
                                              return;
                                            }
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
