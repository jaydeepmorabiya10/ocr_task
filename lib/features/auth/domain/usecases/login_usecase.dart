import 'package:dartz/dartz.dart';
import '../../../../core/error/failure.dart';
import '../../../../core/usecases/base_usecase.dart';
import '../../data/models/login_response_model.dart';
import '../repositories/auth_repository.dart';

class LoginUseCase implements UseCase<LoginResponseModel, LoginParams> {
  final AuthRepository repository;

  LoginUseCase(this.repository);

  @override
  Future<Either<Failure, LoginResponseModel>> call(LoginParams params) async {
    return await repository.login(params.email, params.password);
  }
}

class LoginParams {
  final String email;
  final String password;

  LoginParams({required this.email, required this.password});
}
