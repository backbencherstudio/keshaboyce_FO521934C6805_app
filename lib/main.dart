import 'package:flutter/material.dart';
import 'package:flutter_newprojct/core/routes/route_config.dart';
import 'package:flutter_newprojct/core/theme/theme.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hive_flutter/hive_flutter.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // Initialize Hive before UI loads
  await Hive.initFlutter();
  await Hive.openBox('draftBox'); // Local storage for drafts

  runApp(
    const ProviderScope( // Riverpod wrapper
      child: MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

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
