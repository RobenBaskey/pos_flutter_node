import 'package:flutter/material.dart';
import 'package:get/state_manager.dart';
import 'package:pos/domain/entities/role_entity.dart';
import 'package:pos/presentations/controller/role_controller.dart';
import 'package:pos/presentations/widgets/custom_button.dart';
import 'package:pos/presentations/widgets/custom_divider.dart';
import 'package:pos/presentations/widgets/custom_string_dropdown.dart';
import 'package:pos/presentations/widgets/custom_text_field.dart';

class AddRoles extends GetView<RoleController> {
  const AddRoles({super.key, this.role});
  final AdministratorEntity? role;

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
                    role != null ? "Edit Role" : "Add New Role",
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
                  Text("Full Name *"),
                  SizedBox(height: 8),
                  CustomTextField(
                    controller: controller.fullNameController,
                    hintText: "Enter full name",
                    borderRadius: 8,
                    borderColor: Theme.of(context).colorScheme.outline,
                  ),
                  SizedBox(height: 20),
                  Text("Phone *"),
                  SizedBox(height: 8),
                  CustomTextField(
                    controller: controller.phoneController,
                    hintText: "Enter phone number",
                    borderRadius: 8,
                    borderColor: Theme.of(context).colorScheme.outline,
                  ),
                  SizedBox(height: 20),
                  Text("Password *"),
                  SizedBox(height: 8),
                  CustomTextField(
                    controller: controller.passwordController,
                    hintText: "Enter password",
                    borderRadius: 8,
                    borderColor: Theme.of(context).colorScheme.outline,
                  ),
                  SizedBox(height: 20),
                  Text("Type *"),
                  SizedBox(height: 8),
                  Obx(
                    () => CustomStringDropdown(
                      onChange: (v) {
                        controller.selectedRole.value = v;
                      },
                      items: controller.roleList,
                      selectedValue: controller.selectedRole.value,
                    ),
                  ),
                  SizedBox(height: 20),
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
                          controller.saveRoles();
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
