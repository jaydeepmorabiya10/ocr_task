import 'package:flutter/material.dart';

class AppConstants {
  const AppConstants._();

  static double mainHeight(BuildContext context) =>
      MediaQuery.of(context).size.height;
  static double mainWidth(BuildContext context) =>
      MediaQuery.of(context).size.width;
  static ThemeData theme(BuildContext context) => Theme.of(context);
  static TextTheme textTheme(BuildContext context) => theme(context).textTheme;
  static ColorScheme colorScheme(BuildContext context) =>
      theme(context).colorScheme;

  // App Info
  static const String appName = 'OCR Task';
  static const String appTagline = 'Your Opinion Matters';

  /// Key for storing in shared preferences
  static const String isFirstTime = 'is_first_time';
  static const String isLoggedInKey = 'is_logged_in';
  static const String isBiometricKey = 'is_biometric_enabled';
  static const String isDarkModeKey = 'is_dark_mode';
  static const String userIdKey = 'user_id';
  static const String userEmailKey = 'user_email';
  static const String userNameKey = 'user_name';
  static const String authTokenKey = 'auth_token';
  static const String authRoleKey = 'auth_role';
  static const String userFirstNameKey = 'user_first_name';
  static const String userLastNameKey = 'user_last_name';
  static const String userMobileKey = 'user_mobile';
  static const String userProfileImageKey = 'user_profile_image';
  static const String userCreatedAtKey = 'user_created_at';
  static const String nextAdTimeKey = 'next_ad_time';
}
