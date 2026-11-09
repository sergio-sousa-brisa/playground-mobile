// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'favorites_store.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic, no_leading_underscores_for_local_identifiers

mixin _$FavoritesStore on _FavoritesStoreBase, Store {
  late final _$filmsAtom = Atom(
    name: '_FavoritesStoreBase.films',
    context: context,
  );

  @override
  ObservableList<Film> get films {
    _$filmsAtom.reportRead();
    return super.films;
  }

  @override
  set films(ObservableList<Film> value) {
    _$filmsAtom.reportWrite(value, super.films, () {
      super.films = value;
    });
  }

  late final _$charactersAtom = Atom(
    name: '_FavoritesStoreBase.characters',
    context: context,
  );

  @override
  ObservableList<Character> get characters {
    _$charactersAtom.reportRead();
    return super.characters;
  }

  @override
  set characters(ObservableList<Character> value) {
    _$charactersAtom.reportWrite(value, super.characters, () {
      super.characters = value;
    });
  }

  late final _$planetsAtom = Atom(
    name: '_FavoritesStoreBase.planets',
    context: context,
  );

  @override
  ObservableList<Planet> get planets {
    _$planetsAtom.reportRead();
    return super.planets;
  }

  @override
  set planets(ObservableList<Planet> value) {
    _$planetsAtom.reportWrite(value, super.planets, () {
      super.planets = value;
    });
  }

  late final _$initFavoritesAsyncAction = AsyncAction(
    '_FavoritesStoreBase.initFavorites',
    context: context,
  );

  @override
  Future<void> initFavorites() {
    return _$initFavoritesAsyncAction.run(() => super.initFavorites());
  }

  late final _$toggleFilmAsyncAction = AsyncAction(
    '_FavoritesStoreBase.toggleFilm',
    context: context,
  );

  @override
  Future<void> toggleFilm(Film film) {
    return _$toggleFilmAsyncAction.run(() => super.toggleFilm(film));
  }

  late final _$toggleCharacterAsyncAction = AsyncAction(
    '_FavoritesStoreBase.toggleCharacter',
    context: context,
  );

  @override
  Future<void> toggleCharacter(Character character) {
    return _$toggleCharacterAsyncAction.run(
      () => super.toggleCharacter(character),
    );
  }

  late final _$togglePlanetAsyncAction = AsyncAction(
    '_FavoritesStoreBase.togglePlanet',
    context: context,
  );

  @override
  Future<void> togglePlanet(Planet planet) {
    return _$togglePlanetAsyncAction.run(() => super.togglePlanet(planet));
  }

  @override
  String toString() {
    return '''
films: ${films},
characters: ${characters},
planets: ${planets}
    ''';
  }
}
