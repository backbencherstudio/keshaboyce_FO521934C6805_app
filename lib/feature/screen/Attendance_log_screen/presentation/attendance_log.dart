import 'package:flutter/material.dart';
import 'package:flutter_newprojct/feature/screen/Attendance_log_screen/presentation/widget/attendence_log_header.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:hive_flutter/hive_flutter.dart';
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
  final TextEditingController _fromDateController = TextEditingController();
  final TextEditingController _startTimeController = TextEditingController();
  final TextEditingController _endTimeController = TextEditingController();

  String? _selectedShift;
  String? _selectedStatus;
  String? _selectedNote;
  String? _selectedViolation;

  @override
  void initState() {
    super.initState();
    _loadDraft();
  }

  /// Load draft from Hive
  void _loadDraft() {
    final draftBox = Hive.box('draftBox');
    final savedData = draftBox.get('attendance_log_draft');

    if (savedData != null) {
      _fromDateController.text = savedData['date'] ?? '';
      _startTimeController.text = savedData['startTime'] ?? '';
      _endTimeController.text = savedData['endTime'] ?? '';
      _selectedShift = savedData['shift'];
      _selectedStatus = savedData['status'];
      _selectedNote = savedData['note'];
      _selectedViolation = savedData['violation'];
      setState(() {});
    }
  }

  /// Save draft locally
  void _saveDraft() async {
    final draftBox = Hive.box('draftBox');
    final draftData = {
      'date': _fromDateController.text,
      'startTime': _startTimeController.text,
      'endTime': _endTimeController.text,
      'shift': _selectedShift,
      'status': _selectedStatus,
      'note': _selectedNote,
      'violation': _selectedViolation,
      'createdAt': DateTime.now().toString(),
    };
    await draftBox.put('attendance_log_draft', draftData);

    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text("Draft Saved Successfully")),
    );
  }

  /// Clear draft after submit
  void _clearDraft() async {
    final draftBox = Hive.box('draftBox');
    await draftBox.delete('attendance_log_draft');

    _fromDateController.clear();
    _startTimeController.clear();
    _endTimeController.clear();
    _selectedShift = null;
    _selectedStatus = null;
    _selectedNote = null;
    _selectedViolation = null;
    setState(() {});
  }

  /// Pick time helper
  Future<void> _pickTime(BuildContext context, TextEditingController controller) async {
    final TimeOfDay? pickedTime = await showTimePicker(
      context: context,
      initialTime: TimeOfDay.now(),
    );
    if (pickedTime != null) {
      controller.text = pickedTime.format(context);
    }
  }

  /// Pick date helper
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
                    DropdownButtonFormField<String>(
                      decoration: InputDecoration(
                        filled: true,
                        fillColor: Colors.white,
                        hintText: 'Select your shift',
                        hintStyle: style.bodySmall,
                        border: OutlineInputBorder(borderRadius: BorderRadius.circular(8)),
                        suffixIcon: Padding(
                          padding: EdgeInsets.symmetric(vertical: 8.h, horizontal: 8.w),
                          child: SvgPicture.asset(
                            AppIcons.dropDownSvg,
                            height: 24.h,
                            width: 24.w,
                          ),
                        ),
                      ),
                      style: TextStyle(fontSize: 14.sp, color: Colors.black),
                      value: null, // No value selected initially
                      items: ['Morning', 'Day', 'Night']
                          .map((shift) => DropdownMenuItem(
                        value: shift,
                        child: Text(shift, style: TextStyle(fontSize: 14.sp)),
                      ))
                          .toList(),
                      onChanged: (value) {
                        print("Selected Shift: $value");
                      },
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
                    DropdownButtonFormField<String>(
                      decoration: InputDecoration(
                        filled: true,
                        fillColor: Colors.white,
                        hintText: 'Select a option',
                        hintStyle: style.bodySmall, // control text size here
                        border: OutlineInputBorder(borderRadius: BorderRadius.circular(8)),
                        suffixIcon: Padding(
                          padding: EdgeInsets.symmetric(vertical: 8.h, horizontal: 8.w),
                          child: SvgPicture.asset(
                            AppIcons.dropDownSvg,
                            height: 24.h, // icon size
                            width: 24.w,  // fix icon size
                          ),
                        ),
                      ),
                      style: TextStyle(fontSize: 14.sp, color: Colors.black), // normal text size
                      value: null,
                      items: [' Late Arrival ', ' No Show ', 'On Time']
                          .map((reason) => DropdownMenuItem(
                        value: reason,
                        child: Text(reason, style: TextStyle(fontSize: 14.sp)), // same size
                      ))
                          .toList(),
                      onChanged: (value) {
                        print("Selected Reason: $value");
                      },
                    ),

                    SizedBox(height: 12.h),
                    InputLabel(labelText: 'Notes', optional: '*', style: style),
                    SizedBox(height: 8.h),
                    DropdownButtonFormField<String>(
                      decoration: InputDecoration(
                        filled: true,
                        fillColor: Colors.white,
                        hintText: 'Select a reason',
                        hintStyle: style.bodySmall, // control text size here
                        border: OutlineInputBorder(borderRadius: BorderRadius.circular(8)),
                        suffixIcon: Padding(
                          padding: EdgeInsets.symmetric(vertical: 8.h, horizontal: 8.w),
                          child: SvgPicture.asset(
                            AppIcons.dropDownSvg,
                            height: 24.h, // icon size
                            width: 24.w,  // fix icon size
                          ),
                        ),
                      ),
                      style: TextStyle(fontSize: 14.sp, color: Colors.black), // normal text size
                      value: null,
                      items: ['Vacation', 'Family', 'Medical', 'Other']
                          .map((reason) => DropdownMenuItem(
                        value: reason,
                        child: Text(reason, style: TextStyle(fontSize: 14.sp)), // same size
                      ))
                          .toList(),
                      onChanged: (value) {
                        print("Selected Reason: $value");
                      },
                    ),


                    SizedBox(height: 12.h),

                    InputLabel(labelText: 'Violation (optional)',  style: style),
                    SizedBox(height: 8.h),
                    DropdownButtonFormField<String>(
                      decoration: InputDecoration(
                        filled: true,
                        fillColor: Colors.white,
                        hintText: 'Select a option',
                        hintStyle: style.bodySmall, // control text size here
                        border: OutlineInputBorder(borderRadius: BorderRadius.circular(8)),
                        suffixIcon: Padding(
                          padding: EdgeInsets.symmetric(vertical: 8.h, horizontal: 8.w),
                          child: SvgPicture.asset(
                            AppIcons.dropDownSvg,
                            height: 24.h, // icon size
                            width: 24.w,  // fix icon size
                          ),
                        ),
                      ),
                      style: TextStyle(fontSize: 14.sp, color: Colors.black), // normal text size
                      value: null,
                      items: [' Verbal Warning', 'Written Warning',' None ', 'Final Warning']
                          .map((reason) => DropdownMenuItem(
                        value: reason,
                        child: Text(reason, style: TextStyle(fontSize: 14.sp)), // same size
                      ))
                          .toList(),
                      onChanged: (value) {
                        print("Selected Reason: $value");
                      },
                    ),

                    SizedBox(height: 12.h),
                    Row(
                      children: [
                        Expanded(
                          child: CustomButton(
                            onPress: () {
                              _saveDraft(); // Save the draft
                              ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(
                                  content: Text(
                                      "Draft Saved Successfully"), //Success message
                                  duration: Duration(seconds: 2),
                                ),
                              );
                            },
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
                            onPress: () async {
                              onStartJobTap(context);
                              final draftBox = Hive.box('draftBox');

                              await draftBox.delete('attendance_draft');
                              _clearDraft();
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