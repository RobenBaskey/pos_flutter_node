import 'package:data_table_2/data_table_2.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import '../../../core/theme/app_colors.dart';
import '../../widgets/custom_button.dart';
import '../../widgets/custom_container_shape.dart';
import '../../widgets/custom_divider.dart';
import '../../widgets/custom_text_field.dart';

class CategoryPage extends StatelessWidget {
  const CategoryPage({super.key});

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
                        "Categories Management",
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
                            "Add Category",
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
                      label: Text("CATEGORY NAME"),
                      size: ColumnSize.M,
                    ),
                    DataColumn2(label: Text("DESCRIPTION"), size: ColumnSize.L),
                    DataColumn2(label: Text("ACTION"), fixedWidth: 200),
                  ],
                  rows: List<DataRow>.generate(
                    4,
                    (index) => DataRow(
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
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      Text(
                                        "Gift & Home Decor",
                                        maxLines: 1,
                                        style: TextStyle(
                                          fontSize: 12,
                                          fontWeight: FontWeight.w600,
                                          overflow: TextOverflow.ellipsis,
                                        ),
                                      ),
                                      Text(
                                        "ID: #50",
                                        style: TextStyle(
                                          fontSize: 10,
                                          fontWeight: FontWeight.w600,
                                          color: AppColors.greyTextColor,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                        DataCell(Text("Gift & Home Decor category for ")),
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
