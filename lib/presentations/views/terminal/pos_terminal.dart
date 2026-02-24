import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:pos/core/theme/app_colors.dart';
import 'package:pos/presentations/widgets/custom_button.dart';
import 'package:pos/presentations/widgets/custom_divider.dart';
import 'package:pos/presentations/widgets/custom_text_field.dart';

import '../../widgets/custom_container_shape.dart';

class PosTerminal extends StatelessWidget {
  const PosTerminal({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: CustomContainerShape(
          padding: 0,
          child: CustomScrollView(
            slivers: [
              SliverToBoxAdapter(
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
                              "POS Terminals Management",
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
                              hintText: "Search terminals ..",
                              borderRadius: 8,
                              borderColor: Theme.of(
                                context,
                              ).colorScheme.outline,
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
                                  "Add Terminal",
                                  style: TextStyle(color: Colors.white),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                    CustomDivider(),
                  ],
                ),
              ),
              SliverPadding(
                padding: EdgeInsetsGeometry.all(20),
                sliver: SliverGrid.builder(
                  itemCount: 6,
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 3,
                    mainAxisSpacing: 20,
                    crossAxisSpacing: 20,
                    childAspectRatio: 1.3,
                  ),
                  itemBuilder: (context, index) {
                    return CustomContainerShape(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Material(
                                color: AppColors.primary,
                                borderRadius: BorderRadius.circular(8),
                                child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Icon(
                                    Icons.monitor,
                                    color: Colors.white,
                                  ),
                                ),
                              ),
                              Spacer(),
                              Material(
                                color: Colors.green.withValues(alpha: 0.2),
                                borderRadius: BorderRadius.circular(12),
                                child: Padding(
                                  padding: const EdgeInsets.symmetric(
                                    horizontal: 8,
                                    vertical: 2,
                                  ),
                                  child: Row(
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      Icon(
                                        FontAwesomeIcons.circleCheck,
                                        size: 10,
                                        color: Colors.green,
                                      ),
                                      SizedBox(width: 4),
                                      Text(
                                        "Active",
                                        style: TextStyle(
                                          color: Colors.green,
                                          fontSize: 12,
                                          fontWeight: FontWeight.w600,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ],
                          ),
                          SizedBox(height: 20),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  "POS-KGB-01",
                                  style: TextStyle(
                                    fontWeight: FontWeight.w600,
                                    fontSize: 18,
                                  ),
                                ),
                                SizedBox(height: 14),
                                Row(
                                  children: [
                                    Icon(
                                      Icons.location_pin,
                                      color: AppColors.greyLightTextColor,
                                      size: 16,
                                    ),
                                    SizedBox(width: 10),
                                    Expanded(
                                      child: Text(
                                        "801,West Shewrapara,Mirpur",
                                        style: TextStyle(
                                          color: AppColors.greyLightTextColor,
                                          fontWeight: FontWeight.w500,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                          SizedBox(height: 10),
                          CustomDivider(),
                          SizedBox(height: 10),
                          Row(
                            children: [
                              Expanded(
                                child: CustomButton(
                                  onTap: () {},
                                  title: "",
                                  verticalPadding: 14,
                                  horizontalPadding: 14,
                                  borderRadius: 8,
                                  child: Row(
                                    children: [
                                      Icon(
                                        Icons.login,
                                        color: Colors.white,
                                        size: 16,
                                      ),
                                      SizedBox(width: 6),
                                      Text(
                                        "Login",
                                        style: TextStyle(color: Colors.white),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                              SizedBox(width: 8),
                              Expanded(
                                child: CustomButton(
                                  onTap: () {},
                                  title: "",
                                  verticalPadding: 14,
                                  horizontalPadding: 14,
                                  borderRadius: 8,
                                  elevation: 0,
                                  color: Theme.of(
                                    context,
                                  ).scaffoldBackgroundColor,
                                  borderColor: Theme.of(
                                    context,
                                  ).colorScheme.outline,
                                  child: Row(
                                    children: [
                                      Icon(
                                        FontAwesomeIcons.penToSquare,
                                        color: Colors.blue,
                                        size: 14,
                                      ),
                                      SizedBox(width: 6),
                                      Text(
                                        "Edit",
                                        style: TextStyle(color: Colors.blue),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                              SizedBox(width: 8),
                              Expanded(
                                child: CustomButton(
                                  onTap: () {},
                                  title: "",
                                  verticalPadding: 14,
                                  horizontalPadding: 14,
                                  borderRadius: 8,
                                  elevation: 0,
                                  color: Theme.of(
                                    context,
                                  ).scaffoldBackgroundColor,
                                  borderColor: Theme.of(
                                    context,
                                  ).colorScheme.outline,
                                  child: Row(
                                    children: [
                                      Icon(Icons.delete, color: Colors.red),
                                      SizedBox(width: 6),
                                      Text(
                                        "Delete",
                                        style: TextStyle(color: Colors.red),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
