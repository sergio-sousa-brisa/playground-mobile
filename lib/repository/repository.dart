import 'package:playgroundmobile/models/character.dart';
import 'package:playgroundmobile/models/film.dart';
import 'package:playgroundmobile/models/planet.dart';
import 'package:playgroundmobile/services/api_service.dart';

class Repository {
  const Repository(this._api);

  final ApiService _api;

 Future<List<Film>> getFilms() async {
  final data = await _api.getFilms();

  final results = data?['results'] as List?;
  if (results == null) {
    return [];
  }

  return results
      .map((value) => Film.fromJson(value as Map<String, dynamic>))
      .toList();
}
Future<List<Character>> getPeoples() async {
  final data = await _api.getPeoples();

  final results = data?['results'] as List?;
  if (results == null) {
    return [];
  }

  return results
      .map((value) => Character.fromJson(value as Map<String, dynamic>))
      .toList();
}
Future<List<Planet>> getPlanets() async {
  final data = await _api.getPlanets();

  final results = data?['results'] as List?;
  if (results == null) {
    return [];
  }

  return results
      .map((value) => Planet.fromJson(value as Map<String, dynamic>))
      .toList();
}
}