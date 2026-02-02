import 'package:dartz/dartz.dart';
import '../../../../core/error/failure.dart';
import '../../data/models/login_response_model.dart';

abstract class AuthRepository {
  Future<Either<Failure, LoginResponseModel>> login(
    String email,
    String password,
  );
}
