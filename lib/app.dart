import 'package:flutter/material.dart';
import 'package:ocr_task/features/home/presentation/pages/home_screen.dart';
import 'package:provider/provider.dart';
import 'core/injection_container.dart' as di;
import 'core/navigation/custom_navigator.dart';
import 'features/auth/presentation/pages/login_page.dart';
import 'features/auth/presentation/provider/auth_provider.dart';
import 'features/home/presentation/provider/home_provider.dart';
import 'features/ocr/presentation/pages/ocr_page.dart';
import 'features/ocr/presentation/provider/ocr_provider.dart';
import 'features/profile/presentation/pages/profile_page.dart';
import 'features/splash/presentation/pages/splash_screen.dart';

class OcrTaskApp extends StatelessWidget {
  const OcrTaskApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => di.sl<AuthProvider>()),
        ChangeNotifierProvider(create: (_) => di.sl<HomeProvider>()),
        ChangeNotifierProvider(create: (_) => di.sl<OcrProvider>()),
      ],
      child: MaterialApp(
        title: 'OCR Task',
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
          useMaterial3: true,
        ),
        debugShowCheckedModeBanner: false,
        navigatorKey: CustomNavigator.navigatorKey,
        initialRoute: CustomNavigator.splashRoute,
        routes: {
          CustomNavigator.splashRoute: (context) => const SplashScreen(),
          CustomNavigator.loginRoute: (context) => const LoginPage(),
          CustomNavigator.homeRoute: (context) =>
              const HomeScreen(), //HomePage(),
          CustomNavigator.profileRoute: (context) => const ProfilePage(),
          CustomNavigator.ocrRoute: (context) => const OcrPage(),
        },
      ),
    );
  }
}
