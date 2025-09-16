import 'package:flutter/material.dart';
import 'package:flutter_newprojct/core/theme/theme_extension/app_colors.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CustomButton extends StatelessWidget {
  const CustomButton({
    super.key,
    required this.style,
    this.title,
    this.containerColor,
    this.border,
    this.textStyle,
    this.width,
    this.padding, this.onPress,
  });

  final TextTheme style;
  final String? title;
  final Color? containerColor;
  final TextStyle? textStyle;
  final Border? border;
  final double? width;
  final Padding? padding;
  final VoidCallback? onPress;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onPress,
      child: Container(
        width: width,
        decoration: BoxDecoration(
          border: border ?? Border.all(color: AppColors.textContainerColor),
          borderRadius: BorderRadius.circular(12.r),
          color: containerColor ?? AppColors.textContainerColor,
        ),
        child: Center(
            child: padding ??
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 32.w, vertical: 16.h),
                  child: Text(
                    title ?? 'Back to home',
                    style: textStyle ??
                        style.bodyMedium?.copyWith(color: AppColors.textColor2),
                  ),
                )),
      ),
    );
  }
}
