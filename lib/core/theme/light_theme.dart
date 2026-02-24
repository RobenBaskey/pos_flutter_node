import 'package:flutter/material.dart';

import 'app_colors.dart';

class LightTheme {
  static ThemeData theme = ThemeData(
    brightness: Brightness.light,
    primaryColor: AppColors.primary,
    scaffoldBackgroundColor: AppColors.lightBackground,
    cardColor: Colors.white,
    primaryTextTheme: TextTheme(
      labelSmall: TextStyle(color: Colors.black),
      labelMedium: TextStyle(color: Colors.grey),
    ),
    colorScheme: ColorScheme.light(
      primary: AppColors.primary,
      surface: Colors.white,
      outline: AppColors.darkBackground.withValues(alpha: 0.06),
    ),
    inputDecorationTheme: InputDecorationTheme(
      hintStyle: TextStyle(color: Colors.grey),
    ),
    appBarTheme: const AppBarTheme(elevation: 0, centerTitle: true),
  );
}
