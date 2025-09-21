import 'package:flutter/material.dart';
import 'package:flutter_newprojct/feature/screen/Attendance_log_screen/presentation/widget/attendence_log_header.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:hive_flutter/hive_flutter.dart';
import '../../../../core/constant/icons.dart';
import '../../../../core/service/google_sheet_api.dart';
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
  final TextEditingController _observationsController = TextEditingController(); // Added

  String? _selectedShift;
  String? _selectedStatus;
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
      _observationsController.text = savedData['violation'] ?? ''; // Updated
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
      'violation': _observationsController.text, // Updated
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
    _observationsController.clear(); // Added
    _selectedShift = null;
    _selectedStatus = null;
    _selectedViolation = null;
    setState(() {});
  }

  /// Pick time helper
  Future<void> _pickTime(
      BuildContext context, TextEditingController controller) async {
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
      _fromDateController.text =
      "${pickedDate.day}/${pickedDate.month}/${pickedDate.year}";
    }
  }

  Widget _buildTimeField(String label, TextEditingController controller) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        InputLabel(
          labelText: label,
          optional: '*',
          style: Theme.of(context).textTheme,
        ),
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
    _observationsController.dispose(); // Added
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
                          onTap: () => _selectDate(context),
                          child: Padding(
                            padding: EdgeInsets.symmetric(vertical: 8.h),
                            child: SvgPicture.asset(AppIcons.calender,
                                height: 16.h, width: 16.w),
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
                          child: SvgPicture.asset(AppIcons.dropDownSvg, height: 24.h, width: 24.w),
                        ),
                      ),
                      style: TextStyle(fontSize: 14.sp, color: Colors.black),
                      value: _selectedShift,
                      items: ['Morning', 'Evening', 'Over Night']
                          .map((shift) => DropdownMenuItem(
                        value: shift,
                        child: Text(shift, style: TextStyle(fontSize: 14.sp)),
                      ))
                          .toList(),
                      onChanged: (value) {
                        setState(() {
                          _selectedShift = value;
                        });
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
                        hintStyle: style.bodySmall,
                        border: OutlineInputBorder(borderRadius: BorderRadius.circular(8)),
                        suffixIcon: Padding(
                          padding: EdgeInsets.symmetric(vertical: 8.h, horizontal: 8.w),
                          child: SvgPicture.asset(AppIcons.dropDownSvg, height: 24.h, width: 24.w),
                        ),
                      ),
                      style: TextStyle(fontSize: 14.sp, color: Colors.black),
                      value: _selectedStatus,
                      items: ['Late Arrival', 'No Show']
                          .map((reason) => DropdownMenuItem(
                        value: reason,
                        child: Text(reason, style: TextStyle(fontSize: 14.sp)),
                      ))
                          .toList(),
                      onChanged: (value) {
                        setState(() {
                          _selectedStatus = value;
                        });
                      },
                    ),
                    SizedBox(height: 12.h),
                    InputLabel(labelText: 'Violation', style: style),
                    SizedBox(height: 8.h),
                    TextFormField(
                      controller: _observationsController,
                      maxLines: 4,
                      decoration: InputDecoration(
                        hintText: 'Type the notable observations here...',
                        filled: true,
                        fillColor: Colors.white,
                        contentPadding: const EdgeInsets.symmetric(vertical: 18, horizontal: 16),
                        border: OutlineInputBorder(borderRadius: BorderRadius.circular(8)),
                      ),
                      style: const TextStyle(fontSize: 16, color: Colors.black),
                    ),
                    SizedBox(height: 12.h),
                    Row(
                      children: [
                        Expanded(
                          child: CustomButton(
                            onPress: _saveDraft,
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
                              // Enhanced validation
                              if (_fromDateController.text.isEmpty ||
                                  _startTimeController.text.isEmpty ||
                                  _endTimeController.text.isEmpty ||
                                  _selectedShift == null ||
                                  _selectedStatus == null) {
                                ScaffoldMessenger.of(context).showSnackBar(
                                  const SnackBar(content: Text("Please fill all required fields")),
                                );
                                return;
                              }

                              try {
                                GoogleSheetService g = GoogleSheetService();
                                await g.init();
                                await g.insertAttendanceLog(
                                  date: _fromDateController.text,
                                  scheduledShift: _selectedShift!,
                                  clockIn: _startTimeController.text,
                                  clockOut: _endTimeController.text,
                                  status: _selectedStatus!,
                                  notes: '', // Removed _selectedNote
                                  violation: _observationsController.text,
                                );
                                ScaffoldMessenger.of(context).showSnackBar(
                                  const SnackBar(content: Text("Data submitted successfully")),
                                );
                                onStartJobTap(context,"Attendance Log Submitted");
                                _clearDraft();
                                // Replace with appropriate navigation or action
                                // onStartJobTap(context);
                                Navigator.pop(context); // Example: Go back after submission
                              } catch (e) {
                                ScaffoldMessenger.of(context).showSnackBar(
                                  SnackBar(content: Text("Failed to submit data: $e")),
                                );
                              }
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