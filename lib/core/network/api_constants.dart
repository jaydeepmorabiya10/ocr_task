class ApiConstants {
  const ApiConstants._();

  // Base URLs
  static const String baseUrl =
      'https://api-invesqcrm.rundfunkbeitragservice.com'; // Replace with actual API URL
  

  // Endpoints
  static const String authLogin = '$baseUrl/api/login';
  static const String leadlistApi = '$baseUrl/api/leads';
    // Timeouts
  static const Duration connectionTimeout = Duration(seconds: 30);
  static const Duration receiveTimeout = Duration(seconds: 30);
  static const Duration sendTimeout = Duration(seconds: 30);
}
