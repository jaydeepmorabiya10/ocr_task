import 'package:equatable/equatable.dart';

class OcrResult extends Equatable {
  final String text;
  final double confidence;
  final String imagePath;

  const OcrResult({
    required this.text,
    required this.confidence,
    required this.imagePath,
  });

  @override
  List<Object> get props => [text, confidence, imagePath];
}
