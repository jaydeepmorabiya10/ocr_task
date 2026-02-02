import '../../core/network/network_client.dart';
import '../../core/network/api_constants.dart';

abstract class AuthRemoteDataSource {
  Future<bool> login(String email, String password);
}

class AuthRemoteDataSourceImpl implements AuthRemoteDataSource {
  final NetworkClient networkClient;

  AuthRemoteDataSourceImpl({required this.networkClient});

  @override
  Future<bool> login(String email, String password) async {
    try {
      // Example API call - replace with your actual API endpoint
      final response = await networkClient.post(
        ApiConstants.authLogin,
        headers: {'Content-Type': 'application/json'},
        body: {'email': email, 'password': password},
      );
      // Assuming the response has a 'success' field
      return response['success'] ?? false;
    } catch (e) {
      throw Exception('Login failed: $e');
    }
  }
}
