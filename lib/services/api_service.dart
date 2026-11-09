import 'package:dio/dio.dart';
import 'package:playgroundmobile/services/dio_factory.dart';

class ApiService {
  final _dio = DioFactory.create(baseUrl: 'https://swapi.dev/api');
  final Map<String, String> _urlCache = {};
  
  Future<String> getPlanetImageUrl(String planetName) async {
    if (_urlCache.containsKey(planetName)) {
      return _urlCache[planetName]!;
      }
      
    try {
      final response = await _dio.get('https://starwars-databank-server.onrender.com/api/v1/locations/name/$planetName');
      final List data = response.data;
      
      if (data.isNotEmpty) {
        final imageUrl = data[0]['image'] ?? '';
        _urlCache[planetName] = imageUrl; 
        return imageUrl;
        }
  } catch (e) {
    return '';
  }

  _urlCache[planetName] = '';
  return '';
}

Future<String> getFilmImageUrl(String filmName) async {
    if (_urlCache.containsKey(filmName)) {
      return _urlCache[filmName]!;
      }
      try {
      final response = await _dio.get('https://v3.sg.media-imdb.com/suggestion/r/$filmName.json');
      final Map<String, dynamic> data = response.data;
      if(data.isNotEmpty){
        final imageUrl = data['d'][0]['i']['imageUrl'] ?? '';
        _urlCache[filmName] = imageUrl; 
      return imageUrl;
      }
      } catch (e){
        return '';      
      }
  _urlCache[filmName] = '';
  return '';
}

Future<String> getPeopleImageUrl(String peopleName) async {
  if (_urlCache.containsKey(peopleName)) {
    return _urlCache[peopleName]!;
  }

  final endpoints = [
    'https://starwars-databank-server.onrender.com/api/v1/characters/name/$peopleName',
    'https://starwars-databank-server.onrender.com/api/v1/creatures/name/$peopleName',
    'https://starwars-databank-server.onrender.com/api/v1/droids/name/$peopleName',
  ];

  for (final url in endpoints) {
    try {
      final response = await _dio.get(url);
      final List data = response.data;

      if (data.isNotEmpty) {
        final String imageUrl = data[0]['image'] ?? '';
        if (imageUrl.isNotEmpty) {
          _urlCache[peopleName] = imageUrl;
          return imageUrl;
        }
      }
    } catch (_) {
      continue;
    }
  }

  _urlCache[peopleName] = '';
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
   Future<String> getPrimarySpeciesName(List<String> speciesUrls) async {
    if (speciesUrls.isEmpty) return '';
    final url = speciesUrls.first;
   
    if (_urlCache.containsKey(url)){
      return _urlCache[url]?? '';
    }
    try {
      final response = await _dio.get(url);
      final Map data = response.data;
      if (data.isNotEmpty){
      final species = data['name'] ?? '';
      _urlCache[url]= species;
      return species;
      }       
    } on DioException catch (_) {
      return '';
    }
    _urlCache[url] = '';
    return '';
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