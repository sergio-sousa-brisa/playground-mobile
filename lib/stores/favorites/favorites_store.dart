import 'package:mobx/mobx.dart';
import 'package:playgroundmobile/models/character.dart';
import 'package:playgroundmobile/models/favorites.dart';
import 'package:playgroundmobile/models/film.dart';
import 'package:playgroundmobile/models/planet.dart';
import 'package:playgroundmobile/repository/favorites_repository.dart';
import 'package:playgroundmobile/stores/auth/auth_store.dart';
part 'favorites_store.g.dart';

class FavoritesStore = _FavoritesStoreBase with _$FavoritesStore;

abstract class _FavoritesStoreBase with Store {
  final FavoritesRepository _repository;
  final AuthStore _authStore;

  _FavoritesStoreBase(this._repository, this._authStore);

  @observable
  ObservableList<Film> films = ObservableList<Film>();

  @observable
  ObservableList<Character> characters = ObservableList<Character>();

  @observable
  ObservableList<Planet> planets = ObservableList<Planet>();

  @action
  Future<void> initFavorites() async {
    final user = _authStore.currentUser;
    if (user == null) return;

    final data = await _repository.loadFavorites(user);
    films = ObservableList.of(data.films);
    characters = ObservableList.of(data.characters);
    planets = ObservableList.of(data.planets);
  }

  bool isFilmFavorite(Film film) {
    return films.any((f) => f.title == film.title);
  }

  @action
  Future<void> toggleFilm(Film film) async {
    final index = films.indexWhere((f) => f.title == film.title);
    if (index >= 0) {
      films.removeAt(index);
    } else {
      films.add(film);
    }
    await _persist();
  }

  bool isCharacterFavorite(Character character) {
    return characters.any((c) => c.name == character.name);
  }

  @action
  Future<void> toggleCharacter(Character character) async {
    final index = characters.indexWhere((c) => c.name == character.name);
    if (index >= 0) {
      characters.removeAt(index);
    } else {
      characters.add(character);
    }
    await _persist();
  }

  bool isPlanetFavorite(Planet planet) {
    return planets.any((p) => p.name == planet.name);
  }

  @action
  Future<void> togglePlanet(Planet planet) async {
    final index = planets.indexWhere((p) => p.name == planet.name);
    if (index >= 0) {
      planets.removeAt(index);
    } else {
      planets.add(planet);
    }
    await _persist();
  }

  Future<void> _persist() async {
    final user = _authStore.currentUser;
    if (user == null) return;

    final model = FavoritesModel(
      films: films.toList(),
      characters: characters.toList(),
      planets: planets.toList(),
    );

    await _repository.saveFavorites(user, model);
  }
}