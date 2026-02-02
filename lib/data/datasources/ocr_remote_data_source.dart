import '../../core/network/network_client.dart';

abstract class OcrRemoteDataSource {
  Future<Map<String, dynamic>> processImage(String imagePath);
}

class OcrRemoteDataSourceImpl implements OcrRemoteDataSource {
  final NetworkClient networkClient;

  OcrRemoteDataSourceImpl({required this.networkClient});

  @override
  Future<Map<String, dynamic>> processImage(String imagePath) async {
    try {
      // Example API call - replace with your actual OCR API endpoint
      final response = await networkClient.post(
        'https://your-ocr-api.com/process',
        headers: {'Content-Type': 'application/json'},
        body: {'image_path': imagePath},
      );
      return response;
    } catch (e) {
      throw Exception('OCR processing failed: $e');
    }
  }
}
