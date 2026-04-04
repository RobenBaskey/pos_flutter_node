import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:intl/intl.dart';
import 'package:pos/core/theme/app_colors.dart';

import '../../widgets/custom_button.dart';
import '../../widgets/custom_container_shape.dart';
import '../../widgets/custom_divider.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});

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
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "My Profile",
                            style: TextStyle(
                              fontWeight: FontWeight.w600,
                              fontSize: 20,
                            ),
                          ),
                          Text(
                            "Manage your account information and settings",
                            style: TextStyle(fontSize: 16),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(width: 10),

                    CustomButton(
                      onTap: () {},
                      title: "",
                      verticalPadding: 20,
                      horizontalPadding: 30,
                      borderRadius: 8,
                      borderColor: Theme.of(context).colorScheme.outline,
                      color: Theme.of(context).scaffoldBackgroundColor,
                      child: Row(
                        children: [
                          Icon(
                            FontAwesomeIcons.penToSquare,
                            size: 18,
                            color: AppColors.primary,
                          ),
                          SizedBox(width: 6),
                          Text(
                            "Edit Profile",
                            style: TextStyle(color: AppColors.primary),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(width: 10),
                    CustomButton(
                      onTap: () {},
                      title: "",
                      verticalPadding: 20,
                      horizontalPadding: 30,
                      borderRadius: 8,
                      borderColor: Theme.of(context).colorScheme.outline,
                      color: Theme.of(context).scaffoldBackgroundColor,
                      child: Row(
                        children: [
                          Icon(
                            Icons.lock_open_rounded,
                            color: AppColors.primary,
                          ),
                          SizedBox(width: 6),
                          Text(
                            "Change Password",
                            style: TextStyle(color: AppColors.primary),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              CustomDivider(),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Column(
                    children: [
                      Row(
                        children: [
                          CircleAvatar(
                            radius: 34,
                            child: Icon(
                              Icons.person_outline,
                              color: Colors.white,
                              size: 30,
                            ),
                          ),
                          SizedBox(width: 14),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  "KGB Admin",
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 20,
                                  ),
                                ),
                                Text("kgb_admin"),
                              ],
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: 30),
                      Row(
                        children: [
                          Expanded(
                            child: Column(
                              children: [
                                _profileItem(
                                  context,
                                  title: "Email Address",
                                  icon: Icons.mail_outline,
                                  data: "example@gmail.com",
                                ),
                                SizedBox(height: 30),
                                _profileItem(
                                  context,
                                  title: "Member Since",
                                  icon: Icons.calendar_today_outlined,
                                  data: DateFormat(
                                    "dd-MM-yyyy",
                                  ).format(DateTime.now()),
                                ),
                              ],
                            ),
                          ),
                          SizedBox(width: 20),
                          Expanded(
                            child: Column(
                              children: [
                                _profileItem(
                                  context,
                                  title: "Username",
                                  icon: Icons.mail_outline,
                                  data: "kgb_admin",
                                ),
                                SizedBox(height: 30),
                                _profileItem(
                                  context,
                                  title: "Last Updated",
                                  icon: Icons.calendar_today_outlined,
                                  data: DateFormat(
                                    "dd-MM-yyyy",
                                  ).format(DateTime.now()),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _profileItem(
    BuildContext context, {
    required String title,
    required IconData icon,
    required String data,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Icon(
              icon,
              size: 20,
              color: Theme.of(context).primaryTextTheme.labelMedium?.color,
            ),
            SizedBox(width: 10),
            Text(
              title,
              style: TextStyle(
                color: Theme.of(context).primaryTextTheme.labelMedium?.color,
              ),
            ),
          ],
        ),
        SizedBox(height: 6),
        Text(data, style: TextStyle(fontSize: 16)),
      ],
    );
  }
}
