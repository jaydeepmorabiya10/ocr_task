import '../../../../core/network/dio_client.dart';
import '../../../../core/network/api_constants.dart';
import 'package:dio/dio.dart';
import '../models/login_response_model.dart';

abstract class AuthRemoteDataSource {
  Future<LoginResponseModel> login(String email, String password);
}

class AuthRemoteDataSourceImpl implements AuthRemoteDataSource {
  final DioClient dioClient;

  AuthRemoteDataSourceImpl({required this.dioClient});

  @override
  Future<LoginResponseModel> login(String email, String password) async {
    try {
      final formData = FormData.fromMap({'email': email, 'password': password});

      final response = await dioClient.post(
        ApiConstants.authLogin,
        data: formData,
      );

      if (response.statusCode == 200 || response.statusCode == 201) {
        return LoginResponseModel.fromJson(response.data);
      } else {
        final errorMessage = response.data['message'] ?? 'Login failed';
        throw errorMessage;
      }
    } catch (e) {
      if (e is DioException) {
        if (e.response != null) {
          final errorMessage = e.response?.data['message'] ?? 'Login failed';
          throw errorMessage;
        } else {
          throw 'Network error: ${e.message}';
        }
      } else {
        throw 'Login failed: $e';
      }
    }
  }
}
