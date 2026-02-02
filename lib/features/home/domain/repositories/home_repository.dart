import 'package:dartz/dartz.dart';
import '../../../../core/error/failure.dart';
import '../entities/lead.dart';

abstract class HomeRepository {
  Future<Either<Failure, LeadResponse>> getLeads({
    int page = 1,
    int limit = 10,
  });
}

class LeadResponse {
  final List<Lead> leads;
  final int? currentPage;
  final int? lastPage;
  final int? total;

  LeadResponse({
    required this.leads,
    this.currentPage,
    this.lastPage,
    this.total,
  });
}
