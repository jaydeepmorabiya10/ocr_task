import 'package:equatable/equatable.dart';

class RecognizedTextEntity extends Equatable {
  final String text;
  final double confidence;
  final String imagePath;

  const RecognizedTextEntity({
    required this.text,
    required this.confidence,
    required this.imagePath,
  });

  @override
  List<Object> get props => [text, confidence, imagePath];
}
