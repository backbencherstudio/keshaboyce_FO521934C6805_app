import 'package:flutter/material.dart';
import 'package:flutter_newprojct/core/constant/icons.dart';
import 'package:flutter_newprojct/core/theme/theme_extension/app_colors.dart';
import 'package:flutter_newprojct/feature/screen/Time_off_screen/presentation/widget/input_label.dart';
import 'package:flutter_newprojct/feature/screen/Time_off_screen/presentation/widget/time_off_header.dart';
import 'package:flutter_newprojct/feature/screen/attendance_screen/presentation/widget/custom_button.dart';
import 'package:flutter_newprojct/feature/screen/attendance_screen/presentation/widget/submit_alert_dialog.dart';

import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../../common_widgets/custom_calender.dart';

class TimeOffScreen extends StatelessWidget {
  TimeOffScreen({super.key});

  // Controllers for date fields
  final TextEditingController fromDateController = TextEditingController();
  final TextEditingController toDateController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final style = Theme.of(context).textTheme;
    return Scaffold(
      backgroundColor: AppColors.textColor2,
      body: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        // Header
        TimeOffHeader(style: style),
        SizedBox(height: 24.h),

        // Content
        Expanded(
          child: SingleChildScrollView(
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 20.w),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // From Date
                  InputLabel(
                      labelText: 'From Date', optional: '*', style: style),
                  SizedBox(height: 8.h),
                  TextFormField(
                    controller: fromDateController,
                    readOnly: true,
                    decoration: InputDecoration(
                      hintText: 'Select a date',
                      suffixIcon: InkWell(
                        onTap: () => selectDate(context, fromDateController),
                        child: Padding(
                          padding: EdgeInsets.symmetric(vertical: 8.h),
                          child: SvgPicture.asset(
                            AppIcons.calender,
                            height: 16.h,
                            width: 16.w,
                          ),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(height: 12.h),

                  // To Date
                  InputLabel(labelText: 'To Date', optional: '*', style: style),
                  SizedBox(height: 8.h),
                  TextFormField(
                    controller: toDateController,
                    readOnly: true,
                    decoration: InputDecoration(
                      hintText: 'Select a date',
                      suffixIcon: InkWell(
                        onTap: () => selectDate(context, toDateController),
                        child: Padding(
                          padding: EdgeInsets.symmetric(vertical: 8.h),
                          child: SvgPicture.asset(
                            AppIcons.calender,
                            height: 16.h,
                            width: 16.w,
                          ),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(height: 12.h),

                  // Notes
                  InputLabel(labelText: 'Notes', optional: '*', style: style),
                  SizedBox(height: 8.h),
                  TextFormField(
                    decoration: InputDecoration(
                      hintText: 'Select a reason',
                      suffixIcon: Padding(
                        padding: EdgeInsets.symmetric(vertical: 4.h),
                        child: SvgPicture.asset(
                          AppIcons.dropDownSvg,
                          height: 4.h,
                          width: 10.h,
                        ),
                      ),
                    ),
                  ),
                  SizedBox(height: 12.h),

                  // Status
                  InputLabel(labelText: 'Status', optional: '*', style: style),
                  SizedBox(height: 8.h),
                  TextFormField(
                    decoration: InputDecoration(
                      hintText: 'Select an option',
                      suffixIcon: Padding(
                        padding: EdgeInsets.symmetric(vertical: 4.h),
                        child: SvgPicture.asset(
                          AppIcons.dropDownSvg,
                          height: 4.h,
                          width: 10.h,
                        ),
                      ),
                    ),
                  ),
                  SizedBox(height: 12.h),

                  // Additional Notes
                  InputLabel(
                    labelText: 'Additional Note',
                    optional: '(optional)',
                    color: AppColors.textColor8,
                    style: style,
                  ),
                  SizedBox(height: 8.h),
                  TextFormField(
                    maxLines: 3,
                    decoration: const InputDecoration(
                      hintText: 'Add your notes',
                    ),
                  ),
                  SizedBox(height: 24.h),

                  // Buttons
                  Row(
                    children: [
                      Expanded(
                        child: CustomButton(
                          title: 'Save Draft',
                          textStyle: style.bodyMedium?.copyWith(
                            fontWeight: FontWeight.w600,
                            color: AppColors.textColor3,
                          ),
                          width: 162.w,
                          containerColor: AppColors.whiteBackgroundColor,
                          border:
                              Border.all(color: AppColors.textContainerColor),
                          style: style,
                        ),
                      ),
                      SizedBox(width: 11.w),
                      Expanded(
                        child: CustomButton(
                          onPress: () => onStartJobTap(context),
                          title: 'Submit',
                          width: 162.w,
                          style: style,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 24.h),
                ],
              ),
            ),
          ),
        ),
      ]),
    );
  }
}
