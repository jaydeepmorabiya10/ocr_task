import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';

import 'dio_client.dart';


/// Advanced API service for complex operations
/// Extends DioClient with additional business logic
@Injectable()
class ApiService {
  final DioClient dioClient;

  ApiService(this.dioClient);

  /// Generic GET request with type-safe response handling
  Future<T?> getTyped<T>(
    String path, {
    Map<String, dynamic>? queryParameters,
    required T Function(dynamic) fromJson,
  }) async {
    try {
      final response = await dioClient.get<Map<String, dynamic>>(
        path,
        queryParameters: queryParameters,
      );

      if (response.statusCode == 200 && response.data != null) {
        final data = response.data!['data'];
        return fromJson(data);
      }
      return null;
    } on DioException catch (e) {
      rethrow;
    }
  }

  /// Generic GET request for list response
  Future<List<T>> getList<T>(
    String path, {
    Map<String, dynamic>? queryParameters,
    required T Function(dynamic) fromJson,
  }) async {
    try {
      final response = await dioClient.get<Map<String, dynamic>>(
        path,
        queryParameters: queryParameters,
      );

      if (response.statusCode == 200 && response.data != null) {
        final dataList = response.data!['data'] as List<dynamic>;
        return dataList.map((item) => fromJson(item)).toList();
      }
      return [];
    } on DioException catch (e) {
      rethrow;
    }
  }

  /// Generic POST request with type-safe response
  Future<T?> postTyped<T>(
    String path, {
    dynamic data,
    Map<String, dynamic>? queryParameters,
    required T Function(dynamic) fromJson,
  }) async {
    try {
      final response = await dioClient.post<Map<String, dynamic>>(
        path,
        data: data,
        queryParameters: queryParameters,
      );

      if (response.statusCode == 201 && response.data != null) {
        final responseData = response.data!['data'];
        return fromJson(responseData);
      }
      return null;
    } on DioException catch (e) {
      rethrow;
    }
  }

  /// Generic PUT request with type-safe response
  Future<T?> putTyped<T>(
    String path, {
    dynamic data,
    required T Function(dynamic) fromJson,
  }) async {
    try {
      final response = await dioClient.put<Map<String, dynamic>>(
        path,
        data: data,
      );

      if (response.statusCode == 200 && response.data != null) {
        final responseData = response.data!['data'];
        return fromJson(responseData);
      }
      return null;
    } on DioException catch (e) {
      rethrow;
    }
  }

  /// Generic DELETE request
  Future<bool> delete(String path) async {
    try {
      final response = await dioClient.delete(path);
      return response.statusCode == 200 || response.statusCode == 204;
    } on DioException catch (e) {
      rethrow;
    }
  }

  /// Paginated list request
  Future<Map<String, dynamic>> getPaginatedList(
    String path, {
    required int page,
    required int pageSize,
    Map<String, dynamic>? additionalParams,
  }) async {
    try {
      final queryParams = {
        'page': page,
        'page_size': pageSize,
        ...?additionalParams,
      };

      final response = await dioClient.get<Map<String, dynamic>>(
        path,
        queryParameters: queryParams,
      );

      if (response.statusCode == 200 && response.data != null) {
        return {
          'data': response.data!['data'] ?? [],
          'total': response.data!['total'] ?? 0,
          'page': response.data!['page'] ?? page,
          'pageSize': response.data!['page_size'] ?? pageSize,
        };
      }
      return {'data': [], 'total': 0, 'page': page, 'pageSize': pageSize};
    } on DioException catch (e) {
      rethrow;
    }
  }

  /// Upload file with progress
  Future<T?> uploadFile<T>(
    String path, {
    required String filePath,
    required T Function(dynamic) fromJson,
    ProgressCallback? onSendProgress,
  }) async {
    try {
      final formData = FormData.fromMap({
        'file': await MultipartFile.fromFile(filePath),
      });

      final response = await dioClient.post<Map<String, dynamic>>(
        path,
        data: formData,
        onSendProgress: onSendProgress,
      );

      if (response.statusCode == 201 && response.data != null) {
        final data = response.data!['data'];
        return fromJson(data);
      }
      return null;
    } on DioException catch (e) {
      rethrow;
    }
  }

  /// Download file with progress
  Future<String?> downloadFile(
    String path, {
    required String savePath,
    ProgressCallback? onReceiveProgress,
  }) async {
    try {
      await dioClient.getDio().download(
        path,
        savePath,
        onReceiveProgress: onReceiveProgress,
      );
      return savePath;
    } on DioException catch (e) {
      rethrow;
    }
  }

  /// Batch requests
  Future<List<Response>> batchRequests(List<RequestOptions> requests) async {
    try {
      final responses = <Response>[];
      for (var request in requests) {
        final response = await dioClient.getDio().request(
          request.path,
          options: Options(method: request.method, headers: request.headers),
          data: request.data,
          queryParameters: request.queryParameters,
        );
        responses.add(response);
      }
      return responses;
    } on DioException catch (e) {
      rethrow;
    }
  }
}
