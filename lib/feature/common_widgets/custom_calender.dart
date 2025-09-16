import 'package:flutter/material.dart';

import '../../core/theme/theme_extension/app_colors.dart';

// Date Picker Function
Future<void> selectDate(BuildContext context, TextEditingController controller) async {
  final DateTime? picked = await showDatePicker(
    context: context,
    initialDate: DateTime.now(),
    firstDate: DateTime(2000),
    lastDate: DateTime(2101),
    builder: (context, child) {
      return Theme(
        data: Theme.of(context).copyWith(
          colorScheme: const ColorScheme.light(
            primary: Color(0xff092549),
            onPrimary: Colors.white,
            onSurface:AppColors.textColor6,
          ),
        ),
        child: child!,
      );
    },
  );

  if (picked != null) {
    controller.text = "${picked.day}/${picked.month}/${picked.year}";
  }
}

Future<void> selectTime(BuildContext context, TextEditingController controller) async {
  final TimeOfDay? pickedTime = await showTimePicker(
    context: context,
    initialTime: TimeOfDay.now(),
    builder: (context, child) {
      return Theme(
        data: Theme.of(context).copyWith(
          timePickerTheme: const TimePickerThemeData(
            backgroundColor: Colors.white,            // Whole picker background white
            dialHandColor: Color(0xff092549),          // Dial hand in theme color
            dialBackgroundColor: Colors.white,        // Dial background white
            hourMinuteColor: Colors.white,            // Hour/Minute box background white
            hourMinuteTextColor: Colors.black,        // Hour/Minute text black
            dayPeriodColor: Colors.white,             // AM/PM background white
            dayPeriodTextColor: Colors.black,         // AM/PM text black
            helpTextStyle: TextStyle(                  // "SELECT TIME" text black
              color: Colors.black,
              fontSize: 14,
              fontWeight: FontWeight.w500,
            ),
            entryModeIconColor: Colors.black,         // Keyboard icon black
          ),

          textButtonTheme: TextButtonThemeData(
            style: TextButton.styleFrom(
              foregroundColor: const Color(0xff092549),      // OK & Cancel button text in theme color
            ),
          ),
        ),
        child: child!,
      );
    },
  );

  if (pickedTime != null) {
    controller.text = pickedTime.format(context);
  }
}



