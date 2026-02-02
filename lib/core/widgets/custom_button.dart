import 'package:flutter/material.dart';
import 'package:ocr_task/core/widgets/custom_loader.dart';
import '../services/app_dimens.dart';
import '../theme/app_colors.dart';

class CustomButton extends StatelessWidget {
  final String text;
  final VoidCallback? onPressed;
  final bool isLoading;
  final Color? backgroundColor;
  final Color? textColor;
  final double? width;
  final double? height;
  final double radius;

  const CustomButton({
    super.key,
    required this.text,
    this.onPressed,
    this.isLoading = false,
    this.backgroundColor,
    this.textColor,
    this.width,
    this.height,
    this.radius = AppDimens.s8,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: width ?? double.infinity,
      height: height ?? 50,
      child: ElevatedButton(
        onPressed: isLoading ? null : onPressed,
        style: ElevatedButton.styleFrom(
          backgroundColor: backgroundColor ?? AppColors.primary,
          foregroundColor: textColor ?? AppColors.background,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(radius),
          ),
        ),
        child: isLoading
            ? const CustomLoader(color: AppColors.background)
            : Text(text),
      ),
    );
  }
}
