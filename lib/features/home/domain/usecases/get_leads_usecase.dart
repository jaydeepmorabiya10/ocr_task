import 'package:dartz/dartz.dart';
import '../../../../core/error/failure.dart';
import '../../../../core/usecases/base_usecase.dart';
import '../entities/lead.dart';
import '../repositories/home_repository.dart';

class GetLeadsUseCase implements UseCase<LeadResponse, GetLeadsParams> {
  final HomeRepository repository;

  GetLeadsUseCase(this.repository);

  @override
  Future<Either<Failure, LeadResponse>> call(GetLeadsParams params) async {
    return await repository.getLeads(page: params.page, limit: params.limit);
  }
}

class GetLeadsParams {
  final int page;
  final int limit;

  GetLeadsParams({required this.page, required this.limit});
}
