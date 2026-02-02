import 'dart:io';

import 'package:flutter/material.dart';
import 'package:ocr_task/core/widgets/custom_appbar.dart';
import 'package:ocr_task/core/widgets/custom_date_picker.dart';
import 'package:provider/provider.dart';

import '../../../../core/utils/app_strings.dart';
import '../../../../core/widgets/custom_button.dart';
import '../../../../core/widgets/custom_file_picker.dart';
import '../../../../core/widgets/custom_snackbar.dart';
import '../../../../core/widgets/custom_textformfield.dart';
import '../provider/ocr_provider.dart';

class OcrPage extends StatefulWidget {
  const OcrPage({super.key});

  @override
  State<OcrPage> createState() => _OcrPageState();
}

class _OcrPageState extends State<OcrPage> {
  final _formKey = GlobalKey<FormState>();
  final _titleController = TextEditingController();
  final _amountController = TextEditingController();
  final _dateController = TextEditingController();
  final _categoryController = TextEditingController();
  final _notesController = TextEditingController();

  File? _selectedFile;

  @override
  void dispose() {
    _titleController.dispose();
    _amountController.dispose();
    _dateController.dispose();
    _categoryController.dispose();
    _notesController.dispose();
    super.dispose();
  }

  Future<void> _onFileSelected(File? file) async {
    if (file == null) return;

    setState(() {
      _selectedFile = file;
    });

    final ocrProvider = context.read<OcrProvider>();
    await ocrProvider.processImage(file);

    if (!mounted) return;

    if (ocrProvider.errorMessage != null) {
      CustomSnackbar.showError(
        context: context,
        message: ocrProvider.errorMessage!,
      );
    } else if (ocrProvider.recognizedText != null) {
      _autoFillForm(ocrProvider.recognizedText!);
      CustomSnackbar.showSuccess(
        context: context,
        message: "Receipt scanned successfully",
      );
    }
  }

  void _autoFillForm(String text) {
    // Simple heuristic parsing
    final lines = text.split('\n');

    // 1. Title/Merchant (Assume first non-empty line)
    if (_titleController.text.isEmpty && lines.isNotEmpty) {
      for (final line in lines) {
        if (line.trim().isNotEmpty) {
          _titleController.text = line.trim();
          break;
        }
      }
    }

    // 2. Amount (Look for currency patterns)
    if (_amountController.text.isEmpty) {
      final amountRegex = RegExp(r'(?:[\$€£₹]\s*)?(\d+[.,]\d{2})');
      final matches = amountRegex.allMatches(text);
      if (matches.isNotEmpty) {
        // Take the last one found which is often the total at bottom
        final match = matches.last;
        _amountController.text = match.group(1)?.replaceAll(',', '.') ?? '';
      }
    }

    // 3. Date
    if (_dateController.text.isEmpty) {
      // MM/DD/YYYY or DD/MM/YYYY or YYYY-MM-DD
      final dateRegex = RegExp(
        r'\b(\d{1,2}[/-]\d{1,2}[/-]\d{2,4}|\d{4}[/-]\d{1,2}[/-]\d{1,2})\b',
      );
      final match = dateRegex.firstMatch(text);
      if (match != null) {
        _dateController.text = match.group(0) ?? '';
      }
    }
  }

  void _clearForm() {
    setState(() {
      _selectedFile = null;
      _titleController.clear();
      _amountController.clear();
      _dateController.clear();
      _categoryController.clear();
      _notesController.clear();
    });
    context.read<OcrProvider>().clearResults();
  }

  @override
  Widget build(BuildContext context) {
    final ocrProvider = context.watch<OcrProvider>();

    return Scaffold(
      appBar: CustomAppBar(
        title: 'Add Expense',
        actions: [
          if (_selectedFile != null ||
              _titleController.text.isNotEmpty ||
              _amountController.text.isNotEmpty)
            IconButton(icon: const Icon(Icons.refresh), onPressed: _clearForm),
        ],
      ),
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              Theme.of(context).primaryColor.withValues(alpha: 0.05),
              Colors.white,
            ],
          ),
        ),
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(16.0),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                // Receipt Upload Section
                Card(
                  elevation: 4,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(16),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            const Icon(Icons.receipt_long, color: Colors.blue),
                            const SizedBox(width: 8),
                            const Text(
                              'Receipt Scan',
                              style: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 16),
                        CustomFilePicker(
                          label: 'Upload Receipt',
                          hint: 'Tap to upload or capture receipt image',
                          selectedFile: _selectedFile,
                          onFileSelected: _onFileSelected,
                        ),
                        if (ocrProvider.isLoading) ...[
                          const SizedBox(height: 16),
                          Container(
                            padding: const EdgeInsets.all(16),
                            decoration: BoxDecoration(
                              color: Colors.blue.shade50,
                              borderRadius: BorderRadius.circular(8),
                            ),
                            child: Column(
                              children: [
                                const LinearProgressIndicator(),
                                const SizedBox(height: 8),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    const Icon(
                                      Icons.scanner,
                                      color: Colors.blue,
                                    ),
                                    const SizedBox(width: 8),
                                    const Text(
                                      'Scanning receipt...',
                                      style: TextStyle(color: Colors.blue),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ],
                      ],
                    ),
                  ),
                ),
                const SizedBox(height: 24),

                // Expense Details Section
                Card(
                  elevation: 4,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(16),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            const Icon(Icons.description, color: Colors.green),
                            const SizedBox(width: 8),
                            const Text(
                              'Expense Details',
                              style: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 16),
                        CustomTextFormField(
                          controller: _titleController,
                          labelText: 'Title / Merchant',
                          prefixIcon: const Icon(Icons.store),
                          validator: (v) =>
                              v?.isEmpty == true ? 'Required' : null,
                        ),
                        const SizedBox(height: 16),
                        Row(
                          children: [
                            Expanded(
                              child: CustomTextFormField(
                                controller: _amountController,
                                labelText: 'Amount',
                                prefixIcon: const Icon(Icons.attach_money),
                                keyboardType:
                                    const TextInputType.numberWithOptions(
                                      decimal: true,
                                    ),
                                validator: (v) =>
                                    v?.isEmpty == true ? 'Required' : null,
                              ),
                            ),
                            const SizedBox(width: 16),
                            Expanded(
                              child: CustomDatePicker(
                                controller: _dateController,
                                labelText: AppStrings.date,
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 16),
                        CustomTextFormField(
                          controller: _categoryController,
                          labelText: 'Category',
                          prefixIcon: const Icon(Icons.category),
                        ),
                      ],
                    ),
                  ),
                ),
                const SizedBox(height: 24),

                // Additional Notes Section
                Card(
                  elevation: 4,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(16),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            const Icon(Icons.note_alt, color: Colors.orange),
                            const SizedBox(width: 8),
                            const Text(
                              'Additional Notes',
                              style: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 16),
                        CustomTextFormField(
                          controller: _notesController,
                          labelText: 'Notes (Optional)',
                          prefixIcon: const Icon(Icons.note),
                          maxLines: 3,
                        ),
                      ],
                    ),
                  ),
                ),
                const SizedBox(height: 32),

                // Save Button
                CustomButton(
                  text: 'Save Expense',
                  onPressed: () {
                    if (_formKey.currentState!.validate()) {
                      CustomSnackbar.showSuccess(
                        context: context,
                        message: "Expense saved successfully!",
                      );
                      // Handle save logic
                    }
                  },
                ),
                const SizedBox(height: 16),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
