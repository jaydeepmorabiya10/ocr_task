import 'package:flutter/material.dart';

import '../theme/app_colors.dart';

class CustomSnackbar {
  static void show({
    required BuildContext context,
    required String message,
    Color backgroundColor = AppColors.primary,
    Color textColor = AppColors.background,
    Duration duration = const Duration(seconds: 3),
  }) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message, style: TextStyle(color: textColor)),
        backgroundColor: backgroundColor,
        duration: duration,
        behavior: SnackBarBehavior.floating,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      ),
    );
  }

  static void showSuccess({
    required BuildContext context,
    required String message,
  }) {
    show(
      context: context,
      message: message,
      backgroundColor: AppColors.success,
    );
  }

  static void showError({
    required BuildContext context,
    required String message,
  }) {
    show(context: context, message: message, backgroundColor: AppColors.error);
  }
}
