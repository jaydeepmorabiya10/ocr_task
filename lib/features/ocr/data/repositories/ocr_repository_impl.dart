import 'dart:io';
import 'package:dartz/dartz.dart';
import '../../../../core/error/failure.dart';
import '../../domain/entities/recognized_text_entity.dart';
import '../../domain/repositories/ocr_repository.dart';
import '../datasources/ocr_mlkit_datasource.dart';

class OcrRepositoryImpl implements OcrRepository {
  final OcrMlkitDatasource ocrMlkitDatasource;

  OcrRepositoryImpl({required this.ocrMlkitDatasource});

  @override
  Future<Either<Failure, RecognizedTextEntity>> processImage(
    String imagePath,
  ) async {
    try {
      final imageFile = File(imagePath);
      final recognizedText = await ocrMlkitDatasource.recognizeText(imageFile);
      final entity = RecognizedTextEntity(
        recognizedText: recognizedText,
        imagePath: imagePath,
      );
      return Right(entity);
    } catch (e) {
      return Left(ServerFailure('Failed to process image: $e'));
    }
  }
}
