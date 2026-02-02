import 'dart:io';
import 'package:google_mlkit_text_recognition/google_mlkit_text_recognition.dart';

abstract class OcrMlkitDatasource {
  Future<String> recognizeText(File imageFile);
}

class OcrMlkitDatasourceImpl implements OcrMlkitDatasource {
  final TextRecognizer textRecognizer = TextRecognizer();

  @override
  Future<String> recognizeText(File imageFile) async {
    final inputImage = InputImage.fromFile(imageFile);
    final recognizedText = await textRecognizer.processImage(inputImage);
    return recognizedText.text;
  }

  void dispose() {
    textRecognizer.close();
  }
}
