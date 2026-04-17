import 'package:data_table_2/data_table_2.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:pos/presentations/controller/provider_controller.dart';

import '../../../core/theme/app_colors.dart';
import '../../widgets/circle_image.dart';
import '../../widgets/custom_container_shape.dart';
import '../../widgets/custom_divider.dart';
import '../../widgets/custom_text_field.dart';

class CustomerPage extends GetView<ProviderController> {
  const CustomerPage({super.key});

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
                        "Customer Management",
                        style: TextStyle(
                          fontWeight: FontWeight.w600,
                          fontSize: 20,
                        ),
                      ),
                    ),
                    SizedBox(width: 10),
                    IconButton(
                      onPressed: () {
                        controller.getCustomers();
                      },
                      icon: Icon(Icons.replay_outlined),
                    ),
                    SizedBox(width: 10),
                    SizedBox(
                      width: 260,
                      child: CustomTextField(
                        hintText: "Search customer",
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
              CustomDivider(),
              Expanded(
                child: Obx(
                  () => controller.isCustomerLoading.value
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
                              label: Text("Email"),
                              size: ColumnSize.M,
                            ),
                            DataColumn2(
                              label: Text("Address"),
                              size: ColumnSize.S,
                            ),
                            DataColumn2(
                              label: Text("Actions"),
                              size: ColumnSize.S,
                            ),
                          ],
                          rows: List<DataRow>.generate(
                            controller.customerList.length,
                            (index) {
                              var provider = controller.customerList[index];
                              return DataRow(
                                cells: [
                                  DataCell(
                                    Row(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      children: [
                                        CircleImage(path: provider.image ?? ""),
                                        SizedBox(width: 10),
                                        Expanded(
                                          child: Text(
                                            "${provider.firstName} ${provider.lastName}",
                                            style: TextStyle(
                                              fontWeight: FontWeight.w500,
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  DataCell(Text("${provider.phone}")),
                                  DataCell(Text("${provider.companyName}")),
                                  DataCell(Text("${provider.address ?? ""}")),
                                  DataCell(
                                    Row(
                                      mainAxisSize: MainAxisSize.min,
                                      children: [
                                        IconButton(
                                          onPressed: () {},
                                          icon: Icon(
                                            Icons.visibility_outlined,
                                            size: 18,
                                            color: AppColors.primary,
                                          ),
                                        ),
                                        IconButton(
                                          onPressed: () {},
                                          icon: Icon(
                                            FontAwesomeIcons.penToSquare,
                                            size: 16,
                                            color: AppColors.secondary,
                                          ),
                                        ),
                                        IconButton(
                                          onPressed: () {},
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
