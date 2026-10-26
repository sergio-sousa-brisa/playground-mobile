import 'package:dio/dio.dart';
import 'package:playgroundmobile/services/dio_factory.dart';

class ApiService {
  final _dio = DioFactory.create(baseUrl: 'https://swapi.dev/api');

  Future<Map<String, dynamic>?> getFilms() async {
    try {
      final response = await _dio.get('/films');
      return response.data as Map<String, dynamic>;
    } on DioException catch (_) {
      return null;
    }
  }
  Future<Map<String, dynamic>?> getPeoples() async {
    try {
      final response = await _dio.get('/people');
      return response.data as Map<String, dynamic>;
    } on DioException catch (_) {
      return null;
    }
  }
   Future<Map<String, dynamic>?> getPlanets() async {
    try {
      final response = await _dio.get('/planets');
      return response.data as Map<String, dynamic>;
    } on DioException catch (_) {
      return null;
    }
  }
}