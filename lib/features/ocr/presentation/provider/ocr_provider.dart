import 'dart:io';
import 'package:flutter/material.dart';
import '../../domain/entities/recognized_text_entity.dart';
import '../../domain/usecases/process_image_usecase.dart';

class OcrProvider extends ChangeNotifier {
  final ProcessImageUseCase processImageUseCase;

  OcrProvider({required this.processImageUseCase});

  bool _isLoading = false;
  RecognizedTextEntity? _recognizedTextEntity;
  String? _errorMessage;

  bool get isLoading => _isLoading;
  RecognizedTextEntity? get recognizedTextEntity => _recognizedTextEntity;
  String? get errorMessage => _errorMessage;

  Future<void> processImage(File imageFile) async {
    _isLoading = true;
    _errorMessage = null;
    _recognizedTextEntity = null;
    notifyListeners();

    final result = await processImageUseCase(
      ProcessImageParams(imagePath: imageFile.path),
    );
    result.fold(
      (failure) {
        _errorMessage = failure.message;
      },
      (recognizedTextEntity) {
        _recognizedTextEntity = recognizedTextEntity;
      },
    );

    _isLoading = false;
    notifyListeners();
  }

  void clearResults() {
    _recognizedTextEntity = null;
    _errorMessage = null;
    notifyListeners();
  }
}
