import 'dart:convert';
import 'package:http/http.dart' as http;
import 'api_constants.dart';

abstract class NetworkClient {
  Future<dynamic> get(String url, {Map<String, String>? headers});
  Future<dynamic> post(
    String url, {
    Map<String, String>? headers,
    dynamic body,
  });
  Future<dynamic> put(String url, {Map<String, String>? headers, dynamic body});
  Future<dynamic> delete(String url, {Map<String, String>? headers});
}

class HttpNetworkClient implements NetworkClient {
  final http.Client client;

  HttpNetworkClient(this.client);

  @override
  Future get(String url, {Map<String, String>? headers}) async {
    final response = await client
        .get(Uri.parse(url), headers: headers)
        .timeout(ApiConstants.connectionTimeout);
    return _processResponse(response);
  }

  @override
  Future post(String url, {Map<String, String>? headers, body}) async {
    final response = await client
        .post(Uri.parse(url), headers: headers, body: jsonEncode(body))
        .timeout(ApiConstants.connectionTimeout);
    return _processResponse(response);
  }

  @override
  Future put(String url, {Map<String, String>? headers, body}) async {
    final response = await client
        .put(Uri.parse(url), headers: headers, body: jsonEncode(body))
        .timeout(ApiConstants.connectionTimeout);
    return _processResponse(response);
  }

  @override
  Future delete(String url, {Map<String, String>? headers}) async {
    final response = await client
        .delete(Uri.parse(url), headers: headers)
        .timeout(ApiConstants.connectionTimeout);
    return _processResponse(response);
  }

  dynamic _processResponse(http.Response response) {
    if (response.statusCode >= 200 && response.statusCode < 300) {
      return jsonDecode(response.body);
    } else {
      throw Exception('HTTP ${response.statusCode}: ${response.body}');
    }
  }
}
