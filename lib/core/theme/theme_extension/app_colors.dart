import 'package:flutter/material.dart';

class AppColors {
  // Light Color Scheme
  static final ColorScheme lightColorScheme = ColorScheme.light(
    brightness: Brightness.light,
    primary: primary,
    onPrimary: onPrimary,
    secondary: secondary,
    onSecondary: onSecondary,
    error: onError,
    onError: Colors.white,
    surface: surface,
    onSurface: onSurface,
  );

  // Primary Colors for Light Theme
  static const Color primary = Color(0xff3F51B5);      // Lightened version of 0xff031445
  static const Color onPrimary = Colors.white;         // Text color on primary
  static const Color secondary = Color(0xff5C6BC0);    // Light secondary color
  static const Color onSecondary = Colors.white;
  static const Color error = Color(0xffffe6e6);        // Light error background
  static const Color onError = Color(0xffD32F2F);      // Error text/icon color
  static const Color surface = Colors.white;           // Light background surface
  static const Color onSurface = Colors.black;         // Text color on surface

  // Extra Custom Colors for Light Theme
  static const Color bottomNavBarBackground = Color(0xFFE8EAF6);
  static const Color bgColor = Color(0xffF5F6FA);
  static const Color secondaryTextColor = Color(0xff555770);
  static const Color deActiveTextColor = Color(0xffA0A0A0);
  static const Color primaryContainer = Color(0xffE3E6F0);
  static const Color secondaryContainer = Color(0xffE0E2EC);
  static const Color ternaryContainer = Color(0xffE6E8F0);
  static const Color buttonActiveColor = Color(0xff3F51B5);
  static const Color fillColor = Color(0xffF0F1F6);
  static const Color fillColorTwo = Color(0xffE8E9F0);
  static const Color subTextColor = Color(0xff1A9882);
  static const Color containerTextColor = Color(0xff2D2D32);
  static const Color columnHeader = Color(0xffF0F0F5);
  static const Color resetButtonColor = Color(0xffD9D9D9);
  static const Color redColor = Color(0xffFF4C4F);
  static const Color customButtonBack = Color(0xFF3F51B5);

  // Text Colors
  static const Color textColor = Color(0xFF212121);
  static const Color textColor2 = Color(0xFFffffff);
  static const Color textColor3 = Color(0xFF1D1F2C);
  static const Color textColor4 = Color(0xFF4A4C56);
  static const Color textColor5 = Color(0xFFE9E9EA);
  static const Color textColor6 = Color(0xFF8F9BB3);
  static const Color textColor7 = Color(0xFFEB3D4D);
  static const Color textColor8= Color(0xFFA5A5AB);

  // Additional Colors
  static const Color customBox = Color(0xFFE8EAF6);
  static const Color secondaryAppColor = Color(0xff5C6BC0);
  static const Color whiteBackgroundColor = Color(0xFFffffff);
  static const Color textContainerColor = Color(0xff092549);

  // border color
  static const Color borderColor = Color(0xffE8ECF4);
  static const Color borderColor2 = Color(0xffF7F8F9);
}
