import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_newprojct/core/routes/route_config.dart';
import 'package:flutter_newprojct/core/theme/theme.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'core/service/google_sheet_api.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  SystemChrome.setSystemUIOverlayStyle(
    const SystemUiOverlayStyle(
      statusBarColor: Colors.transparent,
      statusBarIconBrightness: Brightness.light, // White icons on Android
      statusBarBrightness: Brightness.dark, // White icons on iOS
    ),
  );

  // Initialize Hive
  await Hive.initFlutter();
  await Hive.openBox('draftBox');

  // Initialize Google Sheets API
  final googleSheetService = GoogleSheetService();
  await googleSheetService.init();

  runApp(
    ProviderScope(
      child: MyApp(googleSheetService: googleSheetService),
    ),
  );
}

class MyApp extends StatelessWidget {
  final GoogleSheetService googleSheetService;
  const MyApp({super.key, required this.googleSheetService});

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(375, 812),
      minTextAdapt: true,
      splitScreenMode: true,
      builder: (context, child) {
        return MaterialApp.router(
          debugShowCheckedModeBanner: false,
          title: 'Attendance App',
          theme: AppTheme.darkTheme,
          routerConfig: RouteConfig.goRouter,
        );
      },
    );
  }
}
