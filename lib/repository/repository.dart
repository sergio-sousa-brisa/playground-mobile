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

  return Future.wait(results
      .map((item) async { 
        final film = Film.fromJson(item as Map<String, dynamic>);

        final imageUrl = await _api.getFilmImageUrl(film.title); 

        return film.copyWith(
          image: imageUrl.isNotEmpty? imageUrl : film.image
        );
        
        
        }).toList());
 
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

    if (results == null) return [];
 
    return Future.wait(results
        .map((value) async{
          final planet = Planet.fromJson(value as Map<String, dynamic>);

          final imageUrl = await _api.getPlanetImageUrl(planet.name);

          return planet.copyWith(
            image: imageUrl.isNotEmpty? imageUrl : planet.image
          );
}));
        

}


}