import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../core/theme/theme_controller.dart';
import 'custom_button.dart';

class PosAppbar extends StatelessWidget {
  const PosAppbar({super.key, required this.theme});

  final ThemeController theme;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 14, horizontal: 24),
      decoration: BoxDecoration(
        color: Theme.of(context).scaffoldBackgroundColor,
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withValues(alpha: 0.1),
            blurRadius: 6,
            spreadRadius: 2,
          ),
        ],
      ),
      child: Row(
        children: [
          Expanded(
            child: Text(
              "Point of Sale",
              style: TextStyle(fontWeight: FontWeight.w600, fontSize: 20),
            ),
          ),
          CustomButton(
            onTap: () {},
            title: "",
            verticalPadding: 4,
            horizontalPadding: 14,
            borderRadius: 4,
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  "POS",
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                SizedBox(width: 10),
                Icon(
                  Icons.keyboard_arrow_down_rounded,
                  color: Colors.white,
                  weight: 2,
                ),
              ],
            ),
          ),
          SizedBox(width: 14),
          Container(
            decoration: BoxDecoration(
              border: Border.all(color: Theme.of(context).colorScheme.outline),
              borderRadius: BorderRadius.circular(8),
            ),
            child: Obx(
              () => TextButton.icon(
                onPressed: theme.toggleTheme,
                label: Text(
                  theme.isDarkMode.value ? "Light" : "Dark",
                  style: TextStyle(fontWeight: FontWeight.w600),
                ),
                icon: Icon(Icons.dark_mode),
              ),
            ),
          ),
          SizedBox(width: 14),
          Text("Welcome Krishibid Bazar Admin"),
          SizedBox(width: 10),
          TextButton(
            onPressed: () {},
            child: Text(
              "Logout",
              style: TextStyle(color: Colors.red, fontWeight: FontWeight.w600),
            ),
          ),
        ],
      ),
    );
  }
}
