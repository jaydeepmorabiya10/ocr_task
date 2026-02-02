import 'package:flutter/material.dart';
import 'package:ocr_task/core/injection_container.dart';

import '../../../../core/navigation/custom_navigator.dart';
import '../../../../core/services/shared_preferences_service.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    _navigateToNext();
  }

  Future<void> _navigateToNext() async {
    final minDelay = Future.delayed(const Duration(seconds: 2));
    final prefs = sl.get<SharedPreferencesService>();
    final isLoggedIn = await prefs.isLoggedIn;

    await minDelay;

    if (mounted) {
      if (isLoggedIn) {
        CustomNavigator.goToHome();
      } else {
        CustomNavigator.goToLogin();
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return const Scaffold(body: Center(child: FlutterLogo(size: 100)));
  }
}
