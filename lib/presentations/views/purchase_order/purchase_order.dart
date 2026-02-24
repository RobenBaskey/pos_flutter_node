import 'package:data_table_2/data_table_2.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:intl/intl.dart';

import '../../../core/theme/app_colors.dart';
import '../../widgets/custom_button.dart';
import '../../widgets/custom_container_shape.dart';
import '../../widgets/custom_divider.dart';
import '../../widgets/custom_text_field.dart';

class PurchaseOrder extends StatelessWidget {
  const PurchaseOrder({super.key});

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
                        "Purchase Order",
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
                        hintText: "Search order",
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
                      onTap: () {},
                      title: "",
                      verticalPadding: 20,
                      horizontalPadding: 14,
                      borderRadius: 8,
                      child: Row(
                        children: [
                          Icon(Icons.add, color: Colors.white),
                          SizedBox(width: 6),
                          Text(
                            "Create Purchase Order",
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
                child: DataTable2(
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
                    DataColumn2(label: Text("ID"), size: ColumnSize.S),
                    DataColumn2(label: Text("Date"), size: ColumnSize.S),
                    DataColumn2(
                      label: Text("Payment Method"),
                      size: ColumnSize.S,
                    ),
                    DataColumn2(label: Text("User"), size: ColumnSize.S),
                    DataColumn2(label: Text("Supplier"), size: ColumnSize.S),
                    DataColumn2(label: Text("Status"), size: ColumnSize.S),
                    DataColumn2(
                      label: Text("Delivery Date"),
                      size: ColumnSize.S,
                    ),
                    DataColumn2(label: Text("Actions"), size: ColumnSize.S),
                  ],
                  rows: List<DataRow>.generate(
                    4,
                    (index) => DataRow(
                      cells: [
                        DataCell(Text("REQ123")),
                        DataCell(
                          Text(DateFormat("dd-MM-yyyy").format(DateTime.now())),
                        ),
                        DataCell(Text("Cash")),
                        DataCell(Text("James")),
                        DataCell(Text("KgClick")),
                        DataCell(
                          Material(
                            borderRadius: BorderRadius.circular(6),
                            color: Colors.green.withValues(alpha: 0.1),
                            child: Padding(
                              padding: EdgeInsets.all(8),
                              child: Text("Draft"),
                            ),
                          ),
                        ),
                        DataCell(
                          Text(DateFormat("dd-MM-yyyy").format(DateTime.now())),
                        ),
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
