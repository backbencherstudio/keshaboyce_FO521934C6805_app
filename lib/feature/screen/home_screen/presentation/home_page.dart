import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../core/routes/route_name.dart';
import '../../../../core/theme/theme_extension/app_colors.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final style = Theme.of(context).textTheme;

    return Scaffold(
      backgroundColor: const Color(0xffF7F8F9),

      body: SingleChildScrollView(
        child: Column(
          children: [
            // Header Section
            Container(
              width: double.infinity,
              decoration: BoxDecoration(
                 color:  Color(0xff092549),
                borderRadius: BorderRadius.only(
                  bottomRight: Radius.circular(8.r),
                  bottomLeft: Radius.circular(8.r),
                ),
              ),
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 24.h),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(height: 20.h),
                    Text(
                      'Welcome to',
                      style: style.headlineSmall?.copyWith(
                        color: Colors.white,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    SizedBox(height: 8.h),
                    Text(
                      'KEY ROSE HOME CARE',
                      style: style.bodyMedium?.copyWith(
                        color: const Color(0xFFE9E9EA),
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ],
                ),
              ),
            ),

            // Menu Cards Section
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 32.w, vertical: 16.h),
              child: Column(
                children: [
                  _buildMenuCard(
                    title: 'Tom Report',
                    onTap: () {
                      context.push(RouteName.attendance);
                    },
                  ),
                  SizedBox(height: 12.h),
                  _buildMenuCard(
                    title: 'Time-Off Request',
                    onTap: () {
                      context.push(RouteName.timeOffscreen);
                    },
                  ),
                  SizedBox(height: 12.h),
                  _buildMenuCard(
                    title: 'Attendance Log',
                    onTap: () {
                      context.push(RouteName.attendanceLog);
                    },
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  // Reusable Widget for Menu Cards
  Widget _buildMenuCard({
    required String title,
    required VoidCallback onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: EdgeInsets.all(16.w),
        decoration: BoxDecoration(
          color: AppColors.whiteBackgroundColor,
          borderRadius: BorderRadius.circular(10.r),
          boxShadow: const [
            BoxShadow(
              color: Colors.black12,
              blurRadius: 6,
              offset: Offset(0, 3),
            )
          ],
        ),
        child: Row(
          children: [
            Text(
              title,
              style: TextStyle(
                fontSize: 18.sp,
                fontWeight: FontWeight.w600,
                color: AppColors.textContainerColor,
              ),
            ),
            const Spacer(),
          ],
        ),
      ),
    );
  }
}
