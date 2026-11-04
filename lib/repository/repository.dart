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

  List<Film> films = results
      .map((value) => Film.fromJson(value as Map<String, dynamic>))
      .toList();
  films = await Future.wait(films.map((film) async {
    final imageUrl = await _api.getFilmImageUrl(film.title);
    
    if(imageUrl.isNotEmpty){
      return film.copyWith(image: imageUrl);
    }
    return film;
  }).toList());
  return films;
}
Future<List<Character>> getCharacters() async {
  final data = await _api.getPeoples();
  final results = data?['results'] as List?;

  if (results == null || results.isEmpty) return [];

  return Future.wait(
    results.map((item) async {
      final character = Character.fromJson(item as Map<String, dynamic>);

      final speciesName = await _api.getPrimarySpeciesName(character.species);
      final imageUrl = await _api.getPeopleImageUrl(character.name);

      return character.copyWith(
        species: speciesName.isNotEmpty ? [speciesName] : [],
        image: imageUrl.isNotEmpty ? imageUrl : character.image,
      );
    }),
  );
}
Future<List<Planet>> getPlanets() async {
    final data = await _api.getPlanets();

    final results = data?['results'] as List?;
    if (results == null) {
      return [];
    }

    List<Planet> planets = results
        .map((value) => Planet.fromJson(value as Map<String, dynamic>))
        .toList();

    planets =  await Future.wait(planets.map((planet) async {
      final imageUrl = await _api.getPlanetImageUrl(planet.name);
      
      if (imageUrl.isNotEmpty) {
        return planet.copyWith(image: imageUrl);
      }
      return planet;
    }));

    return planets;
}


}