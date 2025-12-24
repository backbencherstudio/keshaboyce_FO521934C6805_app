import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../../core/constant/icons.dart';
import '../../../core/routes/route_name.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {

  @override
  void initState() {
    super.initState();
    // Navigate after the widget is mounted
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _moveToNextScreen();
    });
  }

  Future<void> _moveToNextScreen() async {
    await Future.delayed(const Duration(seconds: 2)); // 2s splash duration
    // ignore: use_build_context_synchronously
    context.pushReplacement(RouteName.homescreen); // ✅ Go to HomeScreen
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(
              AppIcons.logoPng,
              width: 200,
              height: 200,
              fit: BoxFit.cover,
            ),
            const SizedBox(height: 16),
            const Text(
              'KEY ROSE HOME CARE',
              style: TextStyle(color: Colors.black, fontSize: 24),
            ),
          ],
        ),
      ),
    );
  }
}
