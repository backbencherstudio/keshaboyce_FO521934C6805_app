import 'package:flutter/material.dart';
import 'package:flutter_newprojct/feature/common_widgets/custom_calender.dart';
import 'package:flutter_newprojct/feature/screen/Attendance_log_screen/presentation/widget/attendence_log_header.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import '../../../../core/constant/icons.dart';
import '../../../../core/theme/theme_extension/app_colors.dart';
import '../../Time_off_screen/presentation/widget/input_label.dart';
import '../../attendance_screen/presentation/widget/custom_button.dart';
import '../../attendance_screen/presentation/widget/submit_alert_dialog.dart';

class AttendanceLog extends StatefulWidget {
  const AttendanceLog({super.key});

  @override
  State<AttendanceLog> createState() => _AttendanceLogState();
}

class _AttendanceLogState extends State<AttendanceLog> {
  // Move all controllers to the State class
  final TextEditingController _fromDateController = TextEditingController();
  final TextEditingController _startTimeController = TextEditingController();
  final TextEditingController _endTimeController = TextEditingController();

  Future<void> _pickTime(BuildContext context, TextEditingController controller) async {
    final TimeOfDay? pickedTime = await showTimePicker(
      context: context,
      initialTime: TimeOfDay.now(),
      builder: (context, child) {
        return Theme(
          data: Theme.of(context).copyWith(
            timePickerTheme: TimePickerThemeData(
              dialTextColor: AppColors.textContainerColor,
              hourMinuteTextColor: WidgetStateColor.resolveWith((states) {
                return AppColors.textContainerColor;
              }),
              hourMinuteColor: WidgetStateColor.resolveWith((states) {
                return Colors.white;
              }),
              helpTextStyle: const TextStyle(color: AppColors.textContainerColor),
              dayPeriodTextColor: AppColors.textContainerColor,
              dayPeriodColor: WidgetStateColor.resolveWith((states) {
                return Colors.white;
              }),
              dialHandColor: AppColors.textContainerColor,
              entryModeIconColor: AppColors.textContainerColor,
            ),
            textTheme: Theme.of(context).textTheme.apply(
              bodyColor: AppColors.textContainerColor,
              displayColor: AppColors.textContainerColor,
            ),
            colorScheme: const ColorScheme.light(
              primary: AppColors.textContainerColor,
              onSurface: AppColors.textContainerColor,
            ),
            dialogTheme: const DialogThemeData(backgroundColor: Colors.white),
          ),
          child: child!,
        );
      },
    );

    if (pickedTime != null) {
      controller.text = pickedTime.format(context);
    }
  }

  // Add date picker function
  Future<void> _selectDate(BuildContext context) async {
    final DateTime? pickedDate = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2020),
      lastDate: DateTime(2030),
    );

    if (pickedDate != null) {
      _fromDateController.text = "${pickedDate.day}/${pickedDate.month}/${pickedDate.year}";
    }
  }


  Widget _buildTimeField(String label, TextEditingController controller) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        InputLabel(labelText: label, optional: '*', style: Theme.of(context).textTheme),
        SizedBox(height: 8.h),
        TextFormField(
          controller: controller,
          readOnly: true,
          onTap: () => _pickTime(context, controller),
          decoration: InputDecoration(
            hintText: 'Select time',
            suffixIcon: Padding(
              padding: EdgeInsets.symmetric(vertical: 12.h),
              child: SvgPicture.asset(AppIcons.clockSvg, height: 16.h, width: 16.w),
            ),
          ),
        ),
      ],
    );
  }

  @override
  void dispose() {
    _fromDateController.dispose();
    _startTimeController.dispose();
    _endTimeController.dispose();
    super.dispose();
  }

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
                padding: EdgeInsets.symmetric(horizontal: 22.w),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    InputLabel(labelText: 'Date', optional: '*', style: style),
                    SizedBox(height: 8.h),
                    TextFormField(
                      controller: _fromDateController,
                      readOnly: true,
                      decoration: InputDecoration(
                        hintText: 'Select a date',
                        suffixIcon: InkWell(
                          onTap: () {
                            _selectDate(context);
                          },
                          child: Padding(
                            padding: EdgeInsets.symmetric(vertical: 8.h),
                            child: SvgPicture.asset(AppIcons.calender, height: 16.h, width: 16.w),
                          ),
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
                    Row(
                      children: [
                        Expanded(child: _buildTimeField('Clock-In', _startTimeController)),
                        SizedBox(width: 8.w),
                        Expanded(child: _buildTimeField('Clock-Out', _endTimeController)),
                      ],
                    ),
                    SizedBox(height: 12.h),
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
                        hintText: 'Select an option',
                        suffixIcon: Padding(
                          padding: EdgeInsets.symmetric(vertical: 4.h),
                          child: SvgPicture.asset(AppIcons.dropDownSvg, height: 4.h, width: 10.h),
                        ),
                      ),
                    ),
                    SizedBox(height: 12.h),

                    InputLabel(labelText: 'Violation (optional)',  style: style),
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
                            title: 'Submit',
                            width: 162.w,
                            style: style,
                            onPress: () {
                              onStartJobTap(context);
                            },
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