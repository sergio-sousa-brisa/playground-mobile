import 'package:dio/dio.dart';
import 'package:playgroundmobile/services/dio_factory.dart';

class ApiService {
  final _dio = DioFactory.create(baseUrl: 'https://swapi.dev/api');
  final Map<String, String> _imageUrlCache = {};
  
  Future<String> getPlanetImageUrl(String planetName) async {
    if (_imageUrlCache.containsKey(planetName)) {
      return _imageUrlCache[planetName]!;
      }
      
    try {
      final response = await _dio.get('https://starwars-databank-server.onrender.com/api/v1/locations/name/$planetName');
      final List data = response.data;
      
      if (data.isNotEmpty) {
        final imageUrl = data[0]['image'] ?? '';
        _imageUrlCache[planetName] = imageUrl; 
        return imageUrl;
        }
  } catch (e) {
    return '';
  }

  _imageUrlCache[planetName] = '';
  return '';
}


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