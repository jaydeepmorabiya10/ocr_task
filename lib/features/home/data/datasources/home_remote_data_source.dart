import 'package:dio/dio.dart';
import '../../../../core/network/dio_client.dart';
import '../../../../core/services/shared_preferences_service.dart';
import '../models/lead_response_model.dart';

abstract class HomeRemoteDataSource {
  Future<LeadResponseModel> getLeads({int page = 1, int limit = 50});
}

class HomeRemoteDataSourceImpl implements HomeRemoteDataSource {
  final DioClient dioClient;
  final SharedPreferencesService sharedPreferencesService;

  HomeRemoteDataSourceImpl({
    required this.dioClient,
    required this.sharedPreferencesService,
  });

  @override
  Future<LeadResponseModel> getLeads({int page = 1, int limit = 50}) async {
    final token = await sharedPreferencesService.authToken;
    final response = await dioClient.get<Map<String, dynamic>>(
      '/api/leads?per_page=$limit&page=$page&sortBy=lead_source_id&sortDirection=desc',
      queryParameters: {},
      options: Options(headers: {'Authorization': 'Bearer $token'}),
    );
    return LeadResponseModel.fromJson(response.data ?? {});
  }
}
