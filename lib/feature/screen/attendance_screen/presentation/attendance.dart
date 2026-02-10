import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_newprojct/core/constant/icons.dart';
import 'package:flutter_newprojct/core/theme/theme_extension/app_colors.dart';
import 'package:flutter_newprojct/feature/screen/attendance_screen/presentation/widget/submit_alert_dialog.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:hive_flutter/hive_flutter.dart';
import '../../../../core/service/google_sheet_api.dart';
import '../../../common_widgets/custom_calender.dart';
import '../../Attendance_log_screen/presentation/widget/custom_button_3.dart';

class Attendance extends StatefulWidget {
  const Attendance({super.key});

  @override
  State<Attendance> createState() => _AttendanceState();
}

class _AttendanceState extends State<Attendance> {
  final TextEditingController _clientNameController = TextEditingController();
  final TextEditingController _caregiverNameController =
      TextEditingController();
  final TextEditingController _dateController = TextEditingController();
  final TextEditingController _startTimeController = TextEditingController();
  final TextEditingController _endTimeController = TextEditingController();
  final TextEditingController _observationsController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _loadDraft(); // Load saved draft on page open
      SystemChrome.setSystemUIOverlayStyle(
    const SystemUiOverlayStyle(
      statusBarColor: Colors.transparent,
      statusBarIconBrightness: Brightness.light, // White icons on Android
      statusBarBrightness: Brightness.dark, // White icons on iOS
    ),
  );

  }



  ///  Load saved data from Hive
  void _loadDraft() {
    final draftBox = Hive.box('draftBox');
    final savedData = draftBox.get('attendance_draft');

    if (savedData != null) {
      _clientNameController.text = savedData['clientName'] ?? '';
      _caregiverNameController.text = savedData['caregiverName'] ?? '';
      _dateController.text = savedData['date'] ?? '';
      _startTimeController.text = savedData['startTime'] ?? '';
      _endTimeController.text = savedData['endTime'] ?? '';
      _observationsController.text = savedData['observations'] ?? '';
    }
  }

  /// Save draft data locally
  void _saveDraft() async {
    final draftBox = Hive.box('draftBox');

    final draftData = {
      'clientName': _clientNameController.text,
      'caregiverName': _caregiverNameController.text,
      'date': _dateController.text,
      'startTime': _startTimeController.text,
      'endTime': _endTimeController.text,
      'observations': _observationsController.text,
      'createdAt': DateTime.now().toString(),
    };

    await draftBox.put('attendance_draft', draftData); // Save by key

    // ignore: use_build_context_synchronously
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text("Draft Saved Successfully")),
    );
  }


  @override
  Widget build(BuildContext context) {
    final style = Theme.of(context).textTheme;
    return Scaffold(
      backgroundColor: const Color(0xffF7F8F9),
      body: Column(
        children: [
          // Custom AppBar Section
          Container(
            width: double.infinity,
            decoration: const BoxDecoration(
              color: AppColors.textContainerColor,
              borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(8),
                bottomRight: Radius.circular(8),
              ),
            ),
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 24),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 40),
                GestureDetector(
                  onTap: () => Navigator.pop(context),
                  child: const Icon(Icons.arrow_back,
                      size: 24, color: Colors.white),
                ),
                const SizedBox(height: 8),
                Text(
                  'TOM REPORT',
                  style: style.headlineSmall?.copyWith(
                    color: AppColors.textColor2,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                const SizedBox(height: 8),
                Text(
                  'Daily shift glance',
                  style: style.bodyMedium?.copyWith(
                    color: AppColors.textColor5,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ],
            ),
          ),

          // Scrollable Form Section
          Expanded(
            child: SingleChildScrollView(
              padding: const EdgeInsets.symmetric(vertical: 20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _buildTextField(
                      'Client name', 'Ex. Sharah A.', _clientNameController),
                  const SizedBox(height: 12),
                  _buildTextField('Caregiver name', 'Ex. John Carter',
                      _caregiverNameController),
                  const SizedBox(height: 12),
                  _buildDateField(),
                  const SizedBox(height: 12),
                  Row(
                    children: [
                      Expanded(
                          child: _buildTimeField(
                              'Start Time', _startTimeController)),
                      const SizedBox(width: 8),
                      Expanded(
                          child:
                              _buildTimeField('End Time', _endTimeController)),
                    ],
                  ),
                  const SizedBox(height: 12),
                  _buildObservationsField(),
                  const SizedBox(height: 24),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      CustomButton(
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
                      SizedBox(width: 11.w),
                      CustomButton(
                        title: 'Submit',
                        width: 162.w,
                        style: style,
                        onPress: () async {
                          try {
                            GoogleSheetService g = GoogleSheetService();
                            await g.init();
                            await g.insertUser(
                              clientname: _clientNameController.text,
                              caregivername: _caregiverNameController.text,
                              date: _dateController.text,
                              start_time: _startTimeController.text,
                              end_time: _endTimeController.text,
                              observation: _observationsController.text,
                            );
                            // ignore: use_build_context_synchronously
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(content: Text("Data submitted successfully")),
                            );
                            // ignore: use_build_context_synchronously
                            onStartJobTap(context,'Tom Submitted');
                          } catch (e) {
                            // ignore: use_build_context_synchronously
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(content: Text("Error submitting data: $e")),
                            );
                          }
                        },

                      ),
                    ],
                  ),
                  SizedBox(height: 24.h),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  // Date Field
  Widget _buildDateField() {
    return _buildLabeledField(
      label: "Date",
      child: TextFormField(
        controller: _dateController,
        readOnly: true,
        decoration: InputDecoration(
          hintText: 'Select a date',
          filled: true,
          fillColor: Colors.white,
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(8)),
          suffixIcon: Padding(
            padding: const EdgeInsets.all(14.0),
            child:
                SvgPicture.asset(AppIcons.clockSvg, height: 16.h, width: 16.w),
          ),
        ),
        onTap: () => selectDate(context, _dateController),
      ),
    );
  }

  // Time Field
  Widget _buildTimeField(String label, TextEditingController controller) {
    return _buildLabeledField(
      label: label,
      child: TextFormField(
        controller: controller,
        readOnly: true,
        decoration: InputDecoration(
          hintText: 'Select time',
          filled: true,
          fillColor: Colors.white,
          contentPadding:
              const EdgeInsets.symmetric(vertical: 12, horizontal: 12),
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(8)),
          suffixIcon: Padding(
            padding: const EdgeInsets.all(14.0),
            child:
                SvgPicture.asset(AppIcons.clockSvg, height: 16.h, width: 16.w),
          ),
        ),
        onTap: () => selectTime(context, controller),
      ),
    );
  }

  // Text Field
  Widget _buildTextField(
      String label, String hint, TextEditingController controller) {
    return _buildLabeledField(
      label: label,
      child: TextFormField(
        controller: controller,
        decoration: InputDecoration(
          hintText: hint,
          filled: true,
          fillColor: Colors.white,
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(8)),
        ),
        style: const TextStyle(color: Colors.black),
      ),
    );
  }

  // Observations Field
  Widget _buildObservationsField() {
    return _buildLabeledField(
      label: "Notable Observations (Refusals, Pain, Falls, Complaints)",
      child: TextFormField(
        controller: _observationsController,
        maxLines: 4,
        decoration: InputDecoration(
          hintText: 'Type the notable observations here...',
          filled: true,
          fillColor: Colors.white,
          contentPadding:
              const EdgeInsets.symmetric(vertical: 18, horizontal: 16),
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(8)),
        ),
        style: const TextStyle(fontSize: 16, color: Colors.black),
      ),
    );
  }

  // Wrapper for Label + Field
  Widget _buildLabeledField({required String label, required Widget child}) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(label,
              style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w500,
                  color: AppColors.textColor)),
          const SizedBox(height: 8),
          child,
        ],
      ),
    );
  }
}
