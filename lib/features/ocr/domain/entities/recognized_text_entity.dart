import 'package:equatable/equatable.dart';
import 'package:google_mlkit_text_recognition/google_mlkit_text_recognition.dart';

class RecognizedTextEntity extends Equatable {
  final RecognizedText recognizedText;
  final String imagePath;

  const RecognizedTextEntity({
    required this.recognizedText,
    required this.imagePath,
  });

  @override
  List<Object> get props => [recognizedText, imagePath];
}
