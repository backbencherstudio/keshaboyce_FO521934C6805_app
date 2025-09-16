import 'package:flutter/material.dart';
import 'package:flutter_newprojct/core/routes/route_config.dart';
import 'package:flutter_newprojct/core/theme/theme.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(375, 812), // ✅ Set your base design size here
      minTextAdapt: true,
      splitScreenMode: true,
      builder: (context, child) {
        return MaterialApp.router(
          debugShowCheckedModeBanner: false,
          title: 'Attendance App',
          theme: AppTheme.darkTheme, // ✅ Now safe to use ScreenUtil in themes
          // themeMode: ThemeMode.dark,
          // darkTheme: AppTheme.darkTheme,
          routerConfig: RouteConfig.goRouter,
        );
      },
    );
  }
}
