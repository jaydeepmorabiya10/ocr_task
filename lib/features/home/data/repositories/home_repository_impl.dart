import 'package:dartz/dartz.dart';
import '../../../../core/error/failure.dart';
import '../../domain/entities/lead.dart';
import '../../domain/repositories/home_repository.dart';
import '../datasources/home_remote_data_source.dart';
import '../models/lead_response_model.dart';

class HomeRepositoryImpl implements HomeRepository {
  final HomeRemoteDataSource remoteDataSource;

  HomeRepositoryImpl({required this.remoteDataSource});

  @override
  Future<Either<Failure, LeadResponse>> getLeads({
    int page = 1,
    int limit = 10,
  }) async {
    try {
      final response = await remoteDataSource.getLeads(
        page: page,
        limit: limit,
      );
      final leads =
          response.data
              ?.map(
                (e) => Lead(
                  id: e.id,
                  assigned: e.assigned,
                  name: e.name,
                  company: e.company,
                  email: e.email,
                  phone: e.phone,
                  leadSourceName: e.leadSourceName,
                  leadStatusName: e.leadStatusName,
                  leadStatusColor: e.leadStatusColor,
                  createdAt: e.createdAt,
                  lastcontact: e.lastcontact,
                ),
              )
              .toList() ??
          [];
      final leadResponse = LeadResponse(
        leads: leads,
        currentPage: response.pagination?.currentPage,
        lastPage: response.pagination?.lastPage,
        total: response.pagination?.total,
      );
      return Right(leadResponse);
    } catch (e) {
      return Left(ServerFailure(e.toString()));
    }
  }
}
