import 'package:flutter/material.dart';
import 'package:flutter_newprojct/core/constant/icons.dart';
import 'package:flutter_newprojct/core/theme/theme_extension/app_colors.dart';
import 'package:flutter_newprojct/feature/screen/attendance_screen/presentation/widget/submit_alert_dialog.dart';
import 'package:flutter_svg/flutter_svg.dart';
import '../../../common_widgets/custom_calender.dart';
import 'package:flutter_newprojct/feature/common_widgets/custom_button.dart';

class Attendance extends StatefulWidget {
  const Attendance({super.key});

  @override
  State<Attendance> createState() => _AttendanceState();
}

class _AttendanceState extends State<Attendance> {
  final TextEditingController _dateController = TextEditingController();
  final TextEditingController _startTimeController = TextEditingController();
  final TextEditingController _endTimeController = TextEditingController();
  final TextEditingController _observationsController = TextEditingController();

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
                  child: const Icon(Icons.arrow_back, size: 24, color: Colors.white),
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
                  _buildTextField('Client name', 'Ex. Sharah A.',),
                  const SizedBox(height: 12),

                  _buildTextField('Caregiver name', 'Ex. John Carter'),
                  const SizedBox(height: 12),

                  _buildDateField(),
                  const SizedBox(height: 12),

                  Row(
                    children: [
                      Expanded(child: _buildTimeField('Start Time', _startTimeController)),
                      const SizedBox(width: 8),
                      Expanded(child: _buildTimeField('End Time', _endTimeController)),
                    ],
                  ),
                  const SizedBox(height: 12),

                  _buildObservationsField(),
                  const SizedBox(height: 24),

                  Row(
                    children: [
                      Expanded(
                        child: CustomButtonSecondary.build(
                          text: "Save Draft",
                          onPressed: () {
                            // Save draft logic
                          },
                        ),
                      ),
                      const SizedBox(width: 12),
                      Expanded(
                        child: CustomButtonPrimary.build(
                          text: "Submit",
                          onPressed: () {
                            onStartJobTap(context);
                          },
                        ),
                      ),
                    ],
                  ),
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
            child: SvgPicture.asset(AppIcons.calender, height: 24, width: 24),
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
          contentPadding: const EdgeInsets.symmetric(vertical: 12, horizontal: 12),
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(8)),
          suffixIcon: Padding(
            padding: const EdgeInsets.all(14.0),
            child: SvgPicture.asset('asset/icon/Icon(1).svg', width: 24, height: 24, fit: BoxFit.scaleDown),
          ),
        ),
        onTap: () => selectTime(context, controller),
      ),
    );
  }

  // Text Field
  Widget _buildTextField(String label, String hint) {
    return _buildLabeledField(
      label: label,
      child: TextFormField(
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
          contentPadding: const EdgeInsets.symmetric(vertical: 18, horizontal: 16),
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
              style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w500, color: AppColors.textColor)),
          const SizedBox(height: 8),
          child,
        ],
      ),
    );
  }
}
