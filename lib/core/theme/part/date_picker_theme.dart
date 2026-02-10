import 'package:flutter/material.dart';
import '../theme_extension/app_colors.dart';

class CustomDatePickerTheme {
  static DatePickerThemeData datePickerTheme = DatePickerThemeData(
    backgroundColor: Colors.white,
    headerBackgroundColor: AppColors.primary,
    headerForegroundColor: Colors.white,
    dayForegroundColor: WidgetStateColor.resolveWith((states) {
      if (states.contains(WidgetState.selected)) {
        return Colors.white;
      } else if (states.contains(WidgetState.disabled)) {
        return Colors.grey;
      }
      return AppColors.primary;
    }),
    dayBackgroundColor: WidgetStateColor.resolveWith((states) {
      if (states.contains(WidgetState.selected)) {
        return AppColors.primary;
      } else if (states.contains(WidgetState.disabled)) {
        return Colors.grey.shade200;
      }
      return Colors.transparent;
    }),
    todayForegroundColor: const WidgetStatePropertyAll(AppColors.primary),
    todayBackgroundColor: WidgetStatePropertyAll(
      // ignore: deprecated_member_use
      AppColors.primary.withOpacity(0.1),
    ),
    yearForegroundColor: WidgetStateColor.resolveWith((states) {
      return states.contains(WidgetState.selected)
          ? Colors.white
          : AppColors.primary;
    }),
    yearBackgroundColor: WidgetStateColor.resolveWith((states) {
      return states.contains(WidgetState.selected)
          ? AppColors.primary
          : Colors.transparent;
    }),
  );
}
