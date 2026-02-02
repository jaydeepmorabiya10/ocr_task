import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../theme/app_colors.dart';

class CustomTextFormField extends StatelessWidget {
  final TextEditingController? controller;
  final String? labelText;
  final String? hintText;
  final bool obscureText;
  final TextInputType? keyboardType;
  final String? Function(String?)? validator;
  final ValueChanged<String>? onChanged;
  final int? maxLines;
  final int? maxLength;
  final bool? isReadOnly;
  final Widget? prefixIcon;
  final Widget? suffixIcon;
  final VoidCallback? onTap;
  final List<TextInputFormatter>? inputFormatters;

  const CustomTextFormField({
    super.key,
    this.controller,
    this.labelText,
    this.hintText,
    this.obscureText = false,
    this.keyboardType = TextInputType.text,
    this.validator,
    this.onChanged,
    this.maxLines = 1,
    this.maxLength,
    this.isReadOnly = false,
    this.prefixIcon,
    this.suffixIcon,
    this.onTap,
    this.inputFormatters,
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      obscureText: obscureText,
      keyboardType: keyboardType,
      validator: validator,
      onChanged: onChanged,
      maxLines: maxLines,
      onTap: onTap,
      maxLength: maxLength,
      readOnly: isReadOnly ?? false,
      autovalidateMode: AutovalidateMode.onUserInteraction,
      inputFormatters: inputFormatters,
      decoration: InputDecoration(
        labelText: labelText,
        hintText: hintText,
        prefixIcon: prefixIcon,
        suffixIcon: suffixIcon,
        counterText: '',
        labelStyle: const TextStyle(color: AppColors.secondary),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: const BorderSide(color: AppColors.secondary, width: 1.5),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: const BorderSide(color: AppColors.secondary, width: 1.5),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: const BorderSide(color: AppColors.secondary, width: 2),
        ),
        errorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: const BorderSide(color: AppColors.error, width: 1.5),
        ),
        focusedErrorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: const BorderSide(color: AppColors.error, width: 2),
        ),
      ),
    );
  }
}
