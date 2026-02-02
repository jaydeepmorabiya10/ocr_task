import 'dart:io';

// import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

import '../navigation/custom_navigator.dart';
import '../services/app_dimens.dart';
import '../theme/app_colors.dart';
import '../utils/app_constants.dart';
import 'custom_image_view.dart';
import 'custom_text.dart';

class CustomFilePicker extends StatelessWidget {
  final String label;
  final String hint;
  final File? selectedFile;
  final Function(File?) onFileSelected;

  const CustomFilePicker({
    super.key,
    required this.label,
    required this.hint,
    this.selectedFile,
    required this.onFileSelected,
  });

  Future<void> _showPickerOptions(BuildContext context) async {
    showModalBottomSheet(
      context: context,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
      ),
      builder: (BuildContext context) {
        return SafeArea(
          child: Wrap(
            children: <Widget>[
              ListTile(
                leading: const Icon(Icons.photo_library),
                title: const Text('Photo Library'),
                onTap: () {
                  _pickImage(ImageSource.gallery, context);
                },
              ),
              ListTile(
                leading: const Icon(Icons.photo_camera),
                title: const Text('Camera'),
                onTap: () {
                  _pickImage(ImageSource.camera, context);
                },
              ),
              // ListTile(
              //   leading: const Icon(Icons.attach_file),
              //   title: const Text('Document'),
              //   onTap: () {
              //     _pickDocument(context);
              //   },
              // ),
            ],
          ),
        );
      },
    );
  }

  Future<void> _pickImage(ImageSource source, BuildContext context) async {
    CustomNavigator.pop(context);
    try {
      final ImagePicker picker = ImagePicker();
      final XFile? image = await picker.pickImage(source: source);
      if (image != null) {
        onFileSelected(File(image.path));
      }
    } catch (e) {
      debugPrint('Error picking image: $e');
    }
  }

  // Future<void> _pickDocument(BuildContext context) async {
  //   CustomNavigator.pop(context);
  //   try {
  //     final result = await FilePicker.platform.pickFiles();
  //     if (result != null && result.files.single.path != null) {
  //       onFileSelected(File(result.files.single.path!));
  //     }
  //   } catch (e) {
  //     debugPrint('Error picking document: $e');
  //   }
  // }

  bool get _isImage {
    if (selectedFile == null) return false;
    final extension = selectedFile!.path
        .split(Platform.pathSeparator)
        .last
        .split('.')
        .last
        .toLowerCase();
    return ['jpg', 'jpeg', 'png', 'gif', 'webp', 'heic'].contains(extension);
  }

  @override
  Widget build(BuildContext context) {
    final theme = AppConstants.theme(context);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (label.isNotEmpty) ...[
          Text(
            label,
            style: const TextStyle(color: AppColors.secondary, fontSize: 16),
          ),
          const SizedBox(height: AppDimens.s8),
        ],
        InkWell(
          onTap: () => _showPickerOptions(context),
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 16),
            decoration: BoxDecoration(
              border: Border.all(color: AppColors.secondary, width: 1.5),
              borderRadius: BorderRadius.circular(8),
            ),
            child: Row(
              children: [
                Icon(
                  Icons.upload_file,
                  color: selectedFile != null
                      ? AppColors.primary
                      : AppColors.secondary,
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: CustomText(
                    selectedFile != null
                        ? selectedFile!.path.split('/').last
                        : hint,
                    style: TextStyle(
                      color: selectedFile != null
                          ? theme.textTheme.bodyMedium?.color
                          : AppColors.secondary,
                      fontSize: 16,
                    ),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
                if (selectedFile != null)
                  const Icon(Icons.check_circle, color: AppColors.success)
                else
                  const Icon(Icons.arrow_drop_down, color: AppColors.secondary),
              ],
            ),
          ),
        ),
        if (selectedFile != null) ...[
          const SizedBox(height: AppDimens.s12),
          _isImage
              ? ClipRRect(
                  borderRadius: BorderRadius.circular(8),
                  child: LayoutBuilder(
                    builder: (context, constraints) {
                      return CustomImageView(
                        imagePath: selectedFile!.path,
                        imageType: ImageType.file,
                        height: 220,
                        width: constraints.maxWidth,
                        fit: BoxFit.cover,
                      );
                    },
                  ),
                )
              : Container(
                  width: double.infinity,
                  padding: const .all(AppDimens.s16),
                  decoration: BoxDecoration(
                    color: AppColors.secondary.withValues(alpha: 0.1),
                    borderRadius: BorderRadius.circular(8),
                    border: Border.all(color: AppColors.secondary),
                  ),
                  child: Column(
                    children: [
                      const Icon(
                        Icons.description,
                        size: 48,
                        color: AppColors.primary,
                      ),
                      const SizedBox(height: AppDimens.s8),
                      CustomText(
                        selectedFile!.path.split('/').last,
                        textAlign: TextAlign.center,
                      ),
                    ],
                  ),
                ),
        ],
      ],
    );
  }
}
