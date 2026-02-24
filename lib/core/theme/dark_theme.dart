import 'package:flutter/material.dart';

import 'app_colors.dart';

class DarkTheme {
  static ThemeData theme = ThemeData(
    brightness: Brightness.dark,
    primaryColor: AppColors.primary,
    scaffoldBackgroundColor: AppColors.darkBackground,
    cardColor: Color(0xFF0f172a).withValues(alpha: 0.8),
    primaryTextTheme: TextTheme(
      labelSmall: TextStyle(color: Colors.white),
      labelMedium: TextStyle(color: Colors.white54),
    ),
    colorScheme: ColorScheme.dark(
      primary: AppColors.primary,
      surface: Color(0xFF0f172a).withValues(alpha: 0.8),
      outline: Colors.white.withValues(alpha: 0.06),
    ),
    inputDecorationTheme: InputDecorationTheme(
      hintStyle: TextStyle(color: Colors.grey.withValues(alpha: 0.6)),
    ),
    bottomNavigationBarTheme: BottomNavigationBarThemeData(
      type: BottomNavigationBarType.fixed,
      selectedIconTheme: IconThemeData(color: AppColors.primary, size: 22),
      unselectedIconTheme: IconThemeData(color: Colors.grey, size: 18),
      selectedItemColor: AppColors.primary,
      unselectedItemColor: Colors.grey,
      backgroundColor: AppColors.darkBackground,
      selectedLabelStyle: TextStyle(fontSize: 12),
      unselectedLabelStyle: TextStyle(fontSize: 12),
    ),
    switchTheme: SwitchThemeData(
      thumbColor: WidgetStateProperty.all(Colors.white),
      trackColor: WidgetStateProperty.resolveWith((states) {
        if (states.contains(WidgetState.selected)) {
          return AppColors.primary;
        }
        return Colors.grey.withValues(alpha: 0.4);
      }),
      trackOutlineColor: WidgetStateProperty.resolveWith((states) {
        if (states.contains(WidgetState.selected)) {
          return AppColors.primary;
        }
        return Colors.transparent;
      }),
    ),
  );
}
