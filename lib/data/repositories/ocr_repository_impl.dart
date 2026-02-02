import 'package:dartz/dartz.dart';
import '../../core/error/failure.dart';
import '../../domain/entities/ocr_result.dart';
import '../../domain/repositories/ocr_repository.dart';
import '../datasources/ocr_remote_data_source.dart';

class OcrRepositoryImpl implements OcrRepository {
  final OcrRemoteDataSource remoteDataSource;

  OcrRepositoryImpl({required this.remoteDataSource});

  @override
  Future<Either<Failure, OcrResult>> processImage(String imagePath) async {
    try {
      final result = await remoteDataSource.processImage(imagePath);
      final ocrResult = OcrResult(
        text: result['text'] ?? '',
        confidence: (result['confidence'] ?? 0.0).toDouble(),
        imagePath: imagePath,
      );
      return Right(ocrResult);
    } catch (e) {
      return Left(ServerFailure(e.toString()));
    }
  }
}
