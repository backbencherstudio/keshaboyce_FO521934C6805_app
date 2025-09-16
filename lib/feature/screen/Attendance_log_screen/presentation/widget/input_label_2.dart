import 'package:flutter/material.dart';
import '../../../../../../core/theme/theme_extension/app_colors.dart';

class InputLabel extends StatelessWidget {
  const InputLabel({
    super.key,
    required this.style,
    this.labelText,
    this.optional,
    this.color,
  });

  final TextTheme style;
  final String? labelText;
  final String? optional;
  final Color? color;

  @override
  Widget build(BuildContext context) {
    return RichText(
      text: TextSpan(
        style: style.labelLarge?.copyWith(color: AppColors.textColor3),
        children: [
          TextSpan(text: labelText),
          TextSpan(
            text: optional ?? "",
            style: style.labelLarge?.copyWith(
              color: color ?? AppColors.textColor7,
            ),
          ),
        ],
      ),
    );
  }
}
