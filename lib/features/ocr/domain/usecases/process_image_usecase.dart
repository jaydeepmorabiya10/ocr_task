import 'package:dartz/dartz.dart';
import '../../../../core/error/failure.dart';
import '../../../../core/usecases/base_usecase.dart';
import '../entities/recognized_text_entity.dart';
import '../repositories/ocr_repository.dart';

class ProcessImageUseCase
    implements UseCase<RecognizedTextEntity, ProcessImageParams> {
  final OcrRepository repository;

  ProcessImageUseCase(this.repository);

  @override
  Future<Either<Failure, RecognizedTextEntity>> call(
    ProcessImageParams params,
  ) async {
    return await repository.processImage(params.imagePath);
  }
}

class ProcessImageParams {
  final String imagePath;

  ProcessImageParams({required this.imagePath});
}
