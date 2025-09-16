import 'package:flutter/material.dart';
import 'package:flutter_newprojct/feature/screen/Attendance_log_screen/presentation/widget/attendence_log_header.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../../../core/constant/icons.dart';
import '../../../../core/theme/theme_extension/app_colors.dart';
import '../../Time_off_screen/presentation/widget/input_label.dart';
import '../../attendance_screen/presentation/widget/custom_button.dart';

class AttendanceLog extends StatefulWidget {
  const AttendanceLog({super.key});

  @override
  State<AttendanceLog> createState() => _AttendanceLogState();
}

class _AttendanceLogState extends State<AttendanceLog> {
  @override
  Widget build(BuildContext context) {
    final style = Theme.of(context).textTheme;
    return Scaffold(
      backgroundColor: AppColors.textColor2,
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const AttendanceLogHeader(),
          SizedBox(height: 24.h),
          Expanded(
            child: SingleChildScrollView(
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 20.w),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    InputLabel(labelText: 'Date', optional: '*', style: style),
                    SizedBox(height: 8.h),
                    TextFormField(
                      decoration: InputDecoration(
                        hintText: 'Select a date',
                        suffixIcon: Padding(
                          padding: EdgeInsets.symmetric(vertical: 8.h),
                          child: SvgPicture.asset(AppIcons.calender, height: 16.h, width: 16.w),
                        ),
                      ),
                    ),
                    SizedBox(height: 12.h),

                    InputLabel(labelText: 'Scheduled Shift*', optional: '*', style: style),
                    SizedBox(height: 8.h),
                    TextFormField(
                      decoration: InputDecoration(
                        hintText: 'Select your shift',
                        suffixIcon: Padding(
                          padding: EdgeInsets.symmetric(vertical: 4.h),
                          child: SvgPicture.asset(AppIcons.dropDownSvg, height: 4.h, width: 10.h),
                        ),
                      ),
                    ),
                    SizedBox(height: 12.h),

                    // Time picker
                    _buildDateField(),
                    Row(
                      children: [
                        Expanded(child: _buildTimeField('Start Time', _startTimeController)),
                        const SizedBox(width: 8),
                        Expanded(child: _buildTimeField('End Time', _endTimeController)),
                      ],
                    ),


                    InputLabel(labelText: 'Status', optional: '*', style: style),
                    SizedBox(height: 8.h),
                    TextFormField(
                      decoration: InputDecoration(
                        hintText: 'Select an option',
                        suffixIcon: Padding(
                          padding: EdgeInsets.symmetric(vertical: 4.h),
                          child: SvgPicture.asset(AppIcons.dropDownSvg, height: 4.h, width: 10.h),
                        ),
                      ),
                    ),
                    SizedBox(height: 12.h),

                    InputLabel(labelText: 'Notes', optional: '*', style: style),
                    SizedBox(height: 8.h),
                    TextFormField(
                      decoration: InputDecoration(
                        hintText: 'Write your notes here',
                        suffixIcon: Padding(
                          padding: EdgeInsets.symmetric(vertical: 4.h),
                          child: SvgPicture.asset(AppIcons.dropDownSvg, height: 4.h, width: 10.h),
                        ),
                      ),
                    ),
                    SizedBox(height: 12.h),

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
                            border: Border.all(color: AppColors.textContainerColor),
                            style: style,
                          ),
                        ),
                        SizedBox(width: 11.w),
                        Expanded(
                          child: CustomButton(
                            onPress: () {},
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
        ],
      ),
    );
  }
}

