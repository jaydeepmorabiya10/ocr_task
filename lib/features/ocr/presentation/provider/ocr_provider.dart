import 'dart:io';
import 'package:flutter/material.dart';
import '../../domain/usecases/process_image_usecase.dart';

class OcrProvider extends ChangeNotifier {
  final ProcessImageUseCase processImageUseCase;

  OcrProvider({required this.processImageUseCase});

  bool _isLoading = false;
  String? _recognizedText;
  String? _errorMessage;

  bool get isLoading => _isLoading;
  String? get recognizedText => _recognizedText;
  String? get errorMessage => _errorMessage;

  Future<void> processImage(File imageFile) async {
    _isLoading = true;
    _errorMessage = null;
    _recognizedText = null;
    notifyListeners();

    final result = await processImageUseCase(
      ProcessImageParams(imagePath: imageFile.path),
    );
    result.fold(
      (failure) {
        _errorMessage = failure.message;
      },
      (recognizedTextEntity) {
        _recognizedText = recognizedTextEntity.text;
      },
    );

    _isLoading = false;
    notifyListeners();
  }

  void clearResults() {
    _recognizedText = null;
    _errorMessage = null;
    notifyListeners();
  }
}
