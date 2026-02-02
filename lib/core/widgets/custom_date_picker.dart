import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import 'custom_textformfield.dart';

class CustomDatePicker extends StatelessWidget {
  final TextEditingController controller;
  final String labelText;
  final String? hintText;
  final DateTime? initialDate;
  final DateTime? firstDate;
  final DateTime? lastDate;
  final String dateFormat;
  final Widget? suffixIcon;
  final String? Function(String?)? validator;

  const CustomDatePicker({
    super.key,
    required this.controller,
    required this.labelText,
    this.hintText,
    this.initialDate,
    this.firstDate,
    this.lastDate,
    this.dateFormat = 'dd-MM-yyyy',
    this.suffixIcon,
    this.validator,
  });

  @override
  Widget build(BuildContext context) {
    return CustomTextFormField(
      controller: controller,
      labelText: labelText,
      hintText: hintText,
      isReadOnly: true,
      validator: validator,
      suffixIcon: suffixIcon ?? const Icon(Icons.calendar_month_outlined),
      onTap: () async {
        final DateTime? picked = await showDatePicker(
          context: context,
          initialDate: initialDate ?? DateTime.now(),
          firstDate: firstDate ?? DateTime(1900),
          lastDate: lastDate ?? DateTime.now(),
        );
        if (picked != null) {
          controller.text = DateFormat(dateFormat).format(picked);
        }
      },
    );
  }
}
