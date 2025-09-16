import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter/material.dart';


class AppTextTheme {
  static TextTheme darkTextTheme = TextTheme(
    headlineLarge: GoogleFonts.lato(
      fontSize: 32.sp,
      fontWeight: FontWeight.w700,
    ),
    headlineMedium: GoogleFonts.lato(
      fontSize: 26.sp,
      fontWeight: FontWeight.w400,
    ),
    headlineSmall: GoogleFonts.lato(
      fontSize: 24.sp,

      fontWeight: FontWeight.w400,

    ),
    titleLarge: GoogleFonts.lato(
      fontSize: 22.sp,
      fontWeight: FontWeight.w600,
    ),
    titleMedium: GoogleFonts.lato(
      fontSize: 20.sp,
      fontWeight: FontWeight.w500,
    ),
    titleSmall: GoogleFonts.lato(
      fontSize: 18.sp,
      fontWeight: FontWeight.w500,
    ),

    bodyLarge: GoogleFonts.lato(
      fontSize: 18.sp,
      fontWeight: FontWeight.w500,
    ),
    bodyMedium: GoogleFonts.lato(
      fontSize: 16.sp,
      fontWeight: FontWeight.w400,
    ),
    bodySmall: GoogleFonts.lato(
      fontSize: 14.sp,
      fontWeight: FontWeight.w400,
    ),

    labelLarge: GoogleFonts.lato(
      fontSize: 14.sp,
      fontWeight: FontWeight.w500,
    ),
    labelMedium: GoogleFonts.lato(
      fontSize: 12.sp,
      fontWeight: FontWeight.w500,
    ),
    labelSmall: GoogleFonts.lato(
      fontSize: 11.sp,
      fontWeight: FontWeight.w400,
    ),
  );
}
