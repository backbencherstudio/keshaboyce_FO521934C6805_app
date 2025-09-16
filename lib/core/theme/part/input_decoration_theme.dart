import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../theme_extension/app_colors.dart';

class AppInputDecorationTheme {

  static InputDecorationTheme inputDecorationTheme = InputDecorationTheme(
    hintStyle: TextStyle(
      color: AppColors.textColor6,
      fontSize: 14.sp,
      fontWeight: FontWeight.w400,
    ),

    border: OutlineInputBorder(
      borderRadius: BorderRadius.circular(8.r),
      // borderSide: BorderSide(color: AppColors.borderColor,),
    ),
    enabledBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(8.r),
      borderSide: BorderSide(color: AppColors.borderColor,width: 1.w),
    ),
    focusedBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(8.r),
      // borderSide: BorderSide(color: AppColors.borderColor),
    ),
    errorBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(8.r),
      // borderSide: BorderSide(color: AppColors.borderColor),
    ),

    disabledBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(8.r),
      // borderSide: BorderSide(color: AppColors.borderColor,),
    ),

    contentPadding: EdgeInsets.symmetric(
      horizontal: 16.w,
      vertical: 16.h,
    ),
    filled: true,
    fillColor: AppColors.borderColor2,
    focusColor: AppColors.borderColor2,
    hoverColor: AppColors.borderColor2,

  );
}
