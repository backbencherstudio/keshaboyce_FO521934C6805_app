import 'package:flutter/material.dart';
import 'package:flutter_newprojct/core/constant/icons.dart';
import 'package:flutter_newprojct/core/routes/route_name.dart';
import 'package:flutter_newprojct/core/theme/theme_extension/app_colors.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';

import 'custom_button.dart';

void onStartJobTap(BuildContext context) {
  showDialog(
    context: context,
    builder: (_) {
      final style = Theme.of(context).textTheme;
      return Dialog(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadiusGeometry.circular(16.r),
        ),
        backgroundColor: AppColors.whiteBackgroundColor,
        elevation: 1,
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 24.h),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Image.asset(
                AppIcons.logoPng,
                width: 154,
                height: 148,
              ),
              SizedBox(
                height: 14,
              ),
              Text('TOM Submitted',style:style.headlineSmall?.copyWith(
                color: AppColors.textColor3,
                fontWeight: FontWeight.w700,

              ) ,),
              SizedBox(
                height: 8,
              ),
              Text(
                textAlign: TextAlign.center,
                'Congratulations, The Report\nsubmit has been completed',style: style.titleSmall?.copyWith(
                color: AppColors.textColor4,
                fontWeight: FontWeight.w500,
              ),),
              SizedBox(
                height: 24,
              ),
              CustomButton(
                  onPress: (){
                    context.push(RouteName.homescreen);
                  },
                  style: style),
              SizedBox(
                height: 24,
              ),
              CustomButton(
                  onPress: (){
                    Navigator.pop(context);
                  },
                  containerColor: AppColors.whiteBackgroundColor,
                  textStyle:
                  style.bodyMedium?.copyWith(color: AppColors.textColor3),
                  title: 'Close the App',
                  style: style),
            ],
          ),
        ),
      );
    },
  );
}





