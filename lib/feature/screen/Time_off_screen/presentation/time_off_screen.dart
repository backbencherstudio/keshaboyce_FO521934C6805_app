import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_newprojct/core/constant/icons.dart';
import 'package:flutter_newprojct/core/theme/theme_extension/app_colors.dart';
import 'package:flutter_newprojct/feature/screen/Time_off_screen/presentation/widget/input_label.dart';
import 'package:flutter_newprojct/feature/screen/Time_off_screen/presentation/widget/time_off_header.dart';
import 'package:flutter_newprojct/feature/screen/attendance_screen/presentation/widget/custom_button.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import '../../../../core/service/google_sheet_api.dart';
import '../../../common_widgets/custom_calender.dart';
import '../../attendance_screen/presentation/widget/submit_alert_dialog.dart';
import '../time_off_provider/time_off_provider.dart';


class TimeOffScreen extends ConsumerStatefulWidget {
  const TimeOffScreen({super.key});

  @override
  ConsumerState<TimeOffScreen> createState() => _TimeOffScreenState();
}

class _TimeOffScreenState extends ConsumerState<TimeOffScreen> {
  final TextEditingController _fromDateTEController = TextEditingController();
  final TextEditingController _toDateTEController = TextEditingController();
  final TextEditingController _additionalStatusTEController = TextEditingController();
  final GlobalKey _formKey=GlobalKey();

  String? _selectedNote;
  String? _selectedStatus;

  @override
  void initState() {
    super.initState();
    _loadDraft();
  }

  void _loadDraft() {
    final draft = ref.read(timeOffDraftProvider);
    if (draft.isNotEmpty) {
      _fromDateTEController.text = draft['fromDate'] ?? '';
      _toDateTEController.text = draft['toDate'] ?? '';
      _selectedNote = draft['note'];
      _selectedStatus = draft['status'];
      _additionalStatusTEController.text = draft['additionalNote'] ?? '';
    }
  }

  void _saveDraft() {
    final draftData = {
      'fromDate': _fromDateTEController.text,
      'toDate': _toDateTEController.text,
      'note': _selectedNote ?? '',
      'status': _selectedStatus ?? '',
      'additionalNote': _additionalStatusTEController.text,
    };
    ref.read(timeOffDraftProvider.notifier).saveDraft(draftData);

    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text("Draft Saved Successfully")),
    );
  }

  void _submit() {
    // TODO: Handle submit logic (send to server or Google Sheet)
    ref.read(timeOffDraftProvider.notifier).clearDraft();

    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text("Submitted Successfully")),
    );

    _fromDateTEController.clear();
    _toDateTEController.clear();
    _selectedNote = null;
    _selectedStatus = null;
    _additionalStatusTEController.clear();
    setState(() {});
  }

  Future<void> selectDate(BuildContext context, TextEditingController controller) async {
    final DateTime? pickedDate = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2020),
      lastDate: DateTime(2030),
    );
    if (pickedDate != null) {
      controller.text = "${pickedDate.day}/${pickedDate.month}/${pickedDate.year}";
    }
  }

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
              child: Form(
                key: _formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // From Date
                    InputLabel(
                        labelText: 'From Date', optional: '*', style: style),
                    SizedBox(height: 8.h),
                    TextFormField(
                      controller: _fromDateTEController,
                      readOnly: true,
                      decoration: InputDecoration(
                        hintText: 'Select a date',
                        suffixIcon: InkWell(
                          onTap: () => selectDate(context, _fromDateTEController),
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
                      controller: _toDateTEController,
                      readOnly: true,
                      decoration: InputDecoration(
                        hintText: 'Select a date',
                        suffixIcon: InkWell(
                          onTap: () => selectDate(context, _toDateTEController),
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

                    // Notes Label
                    InputLabel(labelText: 'Notes', optional: '*', style: style),
                    SizedBox(height: 8.h),

                    DropdownButtonFormField<String>(
                      decoration: InputDecoration(
                        filled: true,
                        fillColor: Colors.white,
                        hintText: 'Select a reason',
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
                      value: _selectedNote, // Bind to _selectedNote
                      items: ['Vacation', 'Family', 'Medical', 'Other']
                          .map((reason) => DropdownMenuItem(
                        value: reason,
                        child: Text(reason, style: TextStyle(fontSize: 14.sp)),
                      ))
                          .toList(),
                      onChanged: (value) {
                        setState(() {
                          _selectedNote = value; // Update _selectedNote
                        });
                      },
                    ),

                    SizedBox(height: 12.h),

                    // Status Dropdown
                    InputLabel(labelText: 'Status', optional: '*', style: style),
                    SizedBox(height: 8.h),

                    // Notes Dropdown
                    // DropdownButtonFormField<String>(
                    //   decoration: InputDecoration(
                    //     filled: true,
                    //     fillColor: Colors.white,
                    //     hintText: 'Select a reason',
                    //     hintStyle: style.bodySmall,
                    //     border: OutlineInputBorder(borderRadius: BorderRadius.circular(8)),
                    //     suffixIcon: Padding(
                    //       padding: EdgeInsets.symmetric(vertical: 8.h, horizontal: 8.w),
                    //       child: SvgPicture.asset(
                    //         AppIcons.dropDownSvg,
                    //         height: 24.h,
                    //         width: 24.w,
                    //       ),
                    //     ),
                    //   ),
                    //   style: TextStyle(fontSize: 14.sp, color: Colors.black),
                    //   value: _selectedNote, // Bind to _selectedNote
                    //   items: ['Vacation', 'Family', 'Medical', 'Other']
                    //       .map((reason) => DropdownMenuItem(
                    //     value: reason,
                    //     child: Text(reason, style: TextStyle(fontSize: 14.sp)),
                    //   ))
                    //       .toList(),
                    //   onChanged: (value) {
                    //     setState(() {
                    //       _selectedNote = value; // Update _selectedNote
                    //     });
                    //   },
                    // ),

// Status Dropdown
                    DropdownButtonFormField<String>(
                      decoration: InputDecoration(
                        filled: true,
                        fillColor: Colors.white,
                        hintText: 'Select an option',
                        hintStyle: TextStyle(fontSize: 14.sp),
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
                      value: _selectedStatus, // Bind to _selectedStatus
                      items: ['Pending', 'Approved', 'Denied']
                          .map((status) => DropdownMenuItem(
                        value: status,
                        child: Text(status, style: TextStyle(fontSize: 14.sp)),
                      ))
                          .toList(),
                      onChanged: (value) {
                        setState(() {
                          _selectedStatus = value; // Update _selectedStatus
                        });
                      },
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
                      controller: _additionalStatusTEController,
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
                            onPress: () async {
                              if (_fromDateTEController.text.isEmpty ||
                                  _toDateTEController.text.isEmpty ||
                                  _selectedNote == null ||
                                  _selectedStatus == null) {
                                ScaffoldMessenger.of(context).showSnackBar(
                                  const SnackBar(content: Text("Please fill all required fields")),
                                );
                                return;
                              }
                              try {
                                GoogleSheetService g = GoogleSheetService();
                                await g.init();
                                await g.insertTimeOffRequest(
                                  fromDate: _fromDateTEController.text,
                                  toDate: _toDateTEController.text,
                                  notes: _selectedNote!,
                                  status: _selectedStatus!,
                                  additionalNotes: _additionalStatusTEController.text,
                                );
                                ScaffoldMessenger.of(context).showSnackBar(
                                  const SnackBar(content: Text("Data submitted successfully")),
                                );
                                _submit();
                                onStartJobTap(context);
                              } catch (e) {
                                ScaffoldMessenger.of(context).showSnackBar(
                                  SnackBar(content: Text("Error submitting data: $e")),
                                );
                              }
                            },
                            title: 'Submit',
                            width: 162.w,
                            style: style,
                          ),
                        ),
                        SizedBox(width: 11.w),
                        Expanded(
                          child: CustomButton(
                            onPress: () async {
                              try {
                                GoogleSheetService g = GoogleSheetService();
                                await g.init();
                                await g.insertTimeOffRequest(
                                  fromDate: _fromDateTEController.text,
                                  toDate: _toDateTEController.text,
                                  notes: _selectedNote!,
                                  status: _selectedStatus!,
                                  additionalNotes: _additionalStatusTEController.text,
                                );
                                ScaffoldMessenger.of(context).showSnackBar(
                                  const SnackBar(content: Text("Data submitted successfully")),
                                );
                                _submit(); // Clear draft and reset form
                                onStartJobTap(context);
                              } catch (e) {
                                ScaffoldMessenger.of(context).showSnackBar(
                                  SnackBar(content: Text("Error submitting data: $e")),
                                );
                              }
                            },
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
        ),
      ]),
    );
  }
}