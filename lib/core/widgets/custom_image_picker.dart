import 'dart:io';

import 'package:flutter/material.dart';

import '../services/app_dimens.dart';
import '../theme/app_colors.dart';
import 'custom_text.dart';

class CustomImagePicker extends StatelessWidget {
  final String label;
  final VoidCallback onTap;
  final File? selectedFile;
  final IconData icon;
  final double height;
  final double width;
  final bool isImage;

  const CustomImagePicker({
    super.key,
    required this.label,
    required this.onTap,
    this.selectedFile,
    this.icon = Icons.add_a_photo_outlined,
    this.height = 150,
    this.width = double.infinity,
    this.isImage = true,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        height: height,
        width: width,
        decoration: BoxDecoration(
          color: AppColors.background,
          borderRadius: .circular(AppDimens.s12),
          border: .all(color: AppColors.grey.withValues(alpha: 0.5), width: 1),
        ),
        child: selectedFile != null
            ? _buildPreview()
            : Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(icon, size: 40, color: AppColors.primary),
                  const SizedBox(height: AppDimens.s8),
                  CustomText(
                    label,
                    style: const TextStyle(
                      color: AppColors.grey,
                      fontSize: AppDimens.f14,
                    ),
                  ),
                ],
              ),
      ),
    );
  }

  Widget _buildPreview() {
    if (isImage) {
      return ClipRRect(
        borderRadius: .circular(AppDimens.s12),
        child: Image.file(
          selectedFile!,
          fit: BoxFit.cover,
          width: width,
          height: height,
        ),
      );
    } else {
      return Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Icon(
            Icons.insert_drive_file,
            size: 40,
            color: AppColors.primary,
          ),
          const SizedBox(height: AppDimens.s8),
          Padding(
            padding: const .symmetric(horizontal: AppDimens.s8),
            child: CustomText(
              selectedFile!.path.split('/').last,
              style: const TextStyle(
                color: AppColors.text,
                fontSize: AppDimens.f14,
              ),
              textAlign: TextAlign.center,
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
            ),
          ),
        ],
      );
    }
  }
}
