import 'package:dartz/dartz.dart';
import '../../../../core/error/failure.dart';
import '../entities/recognized_text_entity.dart';

abstract class OcrRepository {
  Future<Either<Failure, RecognizedTextEntity>> processImage(String imagePath);
}
