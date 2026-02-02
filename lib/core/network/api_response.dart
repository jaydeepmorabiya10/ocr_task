class ApiResponse<T> {
  final bool success;
  final T? data;
  final String? message;
  final int? statusCode;

  ApiResponse({
    required this.success,
    this.data,
    this.message,
    this.statusCode,
  });

  factory ApiResponse.fromJson(
    Map<String, dynamic> json,
    T Function(dynamic)? fromJsonT,
  ) {
    return ApiResponse<T>(
      success: json['success'] == true || json['status'] == 'success',
      data: json['data'] != null ? fromJsonT?.call(json['data']) : null,
      message: json['message'] as String?,
      statusCode: json['statusCode'] as int?,
    );
  }
}
