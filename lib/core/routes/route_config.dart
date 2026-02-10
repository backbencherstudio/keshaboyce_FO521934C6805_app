import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../../feature/screen/Time_off_screen/presentation/time_off_screen.dart';
import '../../feature/screen/Attendance_log_screen/presentation/attendance_log.dart';
import '../../feature/screen/attendance_screen/presentation/attendance.dart';
import '../../feature/screen/home_screen/presentation/home_page.dart';
import '../../feature/screen/splash_screen/splash_screen.dart';
import 'route_name.dart';

class RouteConfig {
  static final GoRouter goRouter = GoRouter(
    initialLocation: RouteName.splashScreen,
    routes: [
      GoRoute(
        name: RouteName.splashScreen,
        path: RouteName.splashScreen,
        pageBuilder: (context, state) =>
        const MaterialPage(child: SplashScreen()),
      ),
      GoRoute(
        name: RouteName.attendance,
        path: RouteName.attendance,
        pageBuilder: (context, state) =>
        const MaterialPage(child: Attendance()),
      ),
      GoRoute(
        name: RouteName.homescreen,
        path: RouteName.homescreen,
        pageBuilder: (context, state) =>
        const MaterialPage(child: HomeScreen()),
      ),
      GoRoute(
        name: RouteName.timeOffscreen,
        path: RouteName.timeOffscreen,
        pageBuilder: (context, state) =>
            const MaterialPage(child: TimeOffScreen()),
      ),
      GoRoute(
        name: RouteName.attendanceLog,
        path: RouteName.attendanceLog,
        pageBuilder: (context, state) =>
        const MaterialPage(child: AttendanceLog()),
      ),

    ],
  );
}
