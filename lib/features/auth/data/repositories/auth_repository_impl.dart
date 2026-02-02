import 'package:dartz/dartz.dart';
import '../../../../core/error/failure.dart';
import '../../domain/repositories/auth_repository.dart';
import '../datasources/auth_remote_data_source.dart';
import '../models/login_response_model.dart';

class AuthRepositoryImpl implements AuthRepository {
  final AuthRemoteDataSource remoteDataSource;

  AuthRepositoryImpl({required this.remoteDataSource});

  @override
  Future<Either<Failure, LoginResponseModel>> login(
    String email,
    String password,
  ) async {
    try {
      final result = await remoteDataSource.login(email, password);
      return Right(result);
    } catch (e) {
      return Left(ServerFailure(e.toString()));
    }
  }
}
