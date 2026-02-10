import 'package:flutter/material.dart';
import 'package:flutter_newprojct/core/theme/theme_extension/app_colors.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class TimeOffHeader extends StatelessWidget {
  const TimeOffHeader({
    super.key,
    required this.style,
  });

  final TextTheme style;

  @override
  Widget build(BuildContext context) {
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

            // Back Button Fixed
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
              'Time-Off Requests',
              style: style.headlineSmall?.copyWith(
                color: AppColors.textColor2,
                fontWeight: FontWeight.w600,
              ),
            ),
            SizedBox(height: 8.h),
            Text(
              'Daily shift glace',
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
