import 'package:data_table_2/data_table_2.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:pos/presentations/widgets/custom_container_shape.dart';

import '../../../core/theme/app_colors.dart';
import '../../widgets/custom_divider.dart';
import '../../widgets/custom_text_field.dart';
import '../../widgets/glass_widget.dart';

class PosOrders extends StatelessWidget {
  const PosOrders({super.key});

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
                        "POS Orders",
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
                        hintText: "Search",
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
                child: DataTable2(
                  minWidth: 900,
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
                    DataColumn2(label: Text("INVOICE #"), size: ColumnSize.M),
                    DataColumn2(label: Text("DATE"), size: ColumnSize.M),
                    DataColumn2(label: Text("DETAILS"), size: ColumnSize.L),
                    DataColumn2(label: Text("TOTAL"), size: ColumnSize.S),
                    DataColumn2(label: Text("PAYMENT"), size: ColumnSize.S),
                    DataColumn2(label: Text("STATUS"), size: ColumnSize.S),
                    DataColumn2(label: Text("ACTION"), size: ColumnSize.S),
                  ],
                  rows: List<DataRow>.generate(
                    4,
                    (index) => DataRow(
                      cells: [
                        DataCell(
                          Row(
                            children: [
                              Icon(
                                Icons.money_sharp,
                                size: 16,
                                color: AppColors.greyTextColor,
                              ),
                              SizedBox(width: 6),
                              Text(
                                "POS-20260224-0003",
                                style: TextStyle(
                                  fontSize: 10,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ],
                          ),
                        ),
                        DataCell(
                          Row(
                            children: [
                              Icon(
                                Icons.calendar_today_outlined,
                                size: 16,
                                color: AppColors.greyTextColor,
                              ),
                              SizedBox(width: 6),
                              Text(
                                DateFormat(
                                  "MMM dd,yyyy, hh:mm aa",
                                ).format(DateTime.now()),
                                style: TextStyle(
                                  fontSize: 10,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ],
                          ),
                        ),
                        DataCell(
                          SizedBox(
                            width: double.maxFinite,
                            child: GlassWidget(
                              padding: 6,
                              child: Column(
                                mainAxisSize: MainAxisSize.min,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Row(
                                    children: [
                                      Icon(Icons.location_pin, size: 12),
                                      SizedBox(width: 6),
                                      Expanded(
                                        child: Text(
                                          "Location: Krishibid HQ",
                                          style: TextStyle(fontSize: 10),
                                        ),
                                      ),
                                    ],
                                  ),
                                  Row(
                                    children: [
                                      Icon(Icons.monitor, size: 12),
                                      SizedBox(width: 6),
                                      Expanded(
                                        child: Text(
                                          "Terminal: POS-KGH-01",
                                          style: TextStyle(fontSize: 10),
                                        ),
                                      ),
                                    ],
                                  ),
                                  Row(
                                    children: [
                                      Icon(Icons.person_2_outlined, size: 12),
                                      SizedBox(width: 6),
                                      Expanded(
                                        child: Text(
                                          "Client: James",
                                          style: TextStyle(fontSize: 10),
                                        ),
                                      ),
                                    ],
                                  ),
                                  Row(
                                    children: [
                                      Icon(Icons.person_2_outlined, size: 12),
                                      SizedBox(width: 6),
                                      Expanded(
                                        child: Text(
                                          "Cashier: Store Cashier",
                                          style: TextStyle(fontSize: 10),
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                        DataCell(
                          Text(
                            "\$100.00",
                            style: TextStyle(
                              color: AppColors.primary,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                        DataCell(
                          Material(
                            color: AppColors.secondary.withValues(alpha: 0.1),
                            borderRadius: BorderRadius.circular(6),
                            child: Padding(
                              padding: const EdgeInsets.symmetric(
                                horizontal: 6,
                                vertical: 2,
                              ),
                              child: Text(
                                "PAID",
                                style: TextStyle(
                                  fontSize: 10,
                                  color: AppColors.secondary,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ),
                          ),
                        ),
                        DataCell(
                          Material(
                            color: Colors.blue.withValues(alpha: 0.1),
                            borderRadius: BorderRadius.circular(6),
                            child: Padding(
                              padding: const EdgeInsets.symmetric(
                                horizontal: 6,
                                vertical: 2,
                              ),
                              child: Text(
                                "Completed",
                                style: TextStyle(
                                  fontSize: 10,
                                  color: Colors.blue,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ),
                          ),
                        ),
                        DataCell(
                          Row(
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
                                  Icons.print,
                                  size: 18,
                                  color: AppColors.secondary,
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
