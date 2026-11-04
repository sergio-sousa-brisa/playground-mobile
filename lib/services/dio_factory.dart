import 'package:dio/dio.dart';

class DioFactory {
  static Dio create({required String baseUrl, Map<String, dynamic>? headers}) {
    return Dio(
      BaseOptions(
        baseUrl: baseUrl,
        connectTimeout: const Duration(seconds: 10),
        receiveTimeout: const Duration(seconds: 10),
        headers: headers ?? {'Content-Type': 'application/json'},
      ),
    );
  }
}