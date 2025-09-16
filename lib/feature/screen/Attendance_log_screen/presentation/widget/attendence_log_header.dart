import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_newprojct/core/theme/theme_extension/app_colors.dart';

class AttendanceLogHeader extends StatelessWidget {
  const AttendanceLogHeader({super.key});

  @override
  Widget build(BuildContext context) {
    final style = Theme.of(context).textTheme;
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        color: AppColors.textContainerColor,
        borderRadius: BorderRadius.only(
          bottomRight: Radius.circular(8.r),
          bottomLeft: Radius.circular(8.r),
        ),
      ),
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 24.h),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: 20.h),
            GestureDetector(
              onTap: () => Navigator.pop(context),
              child: const Icon(
                Icons.arrow_back,
                size: 24,
                color: AppColors.whiteBackgroundColor,
              ),
            ),
            SizedBox(height: 8.h),
            Text(
              'Attendance Log',
              style: style.headlineSmall?.copyWith(
                color: AppColors.textColor2,
                fontWeight: FontWeight.w600,
              ),
            ),
            SizedBox(height: 8.h),
            Text(
              'Daily shift glance',
              style: style.bodyMedium?.copyWith(
                color: AppColors.textColor5,
                fontWeight: FontWeight.w600,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
