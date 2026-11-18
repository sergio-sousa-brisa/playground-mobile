import 'package:flutter_test/flutter_test.dart';
import 'package:playgroundmobile/models/character.dart';
import 'package:playgroundmobile/models/film.dart';
import 'package:playgroundmobile/models/planet.dart';
import 'package:playgroundmobile/repository/auth_repository.dart';
import 'package:playgroundmobile/repository/favorites_repository.dart';
import 'package:playgroundmobile/stores/auth/auth_store.dart';
import 'package:playgroundmobile/stores/favorites/favorites_store.dart';

import '../../support/in_memory_secure_store.dart';

void main() {
  group('FavoritesStore', () {
    late InMemorySecureStore storage;
    late AuthStore authStore;
    late FavoritesStore store;
    late Film film;
    late Character character;
    late Planet planet;

    setUp(() async {
      storage = InMemorySecureStore();
      authStore = AuthStore(AuthRepository(storage));
      await authStore.register('ana', 'pass123');
      store = FavoritesStore(FavoritesRepository(storage), authStore);

      film = Film(
        title: 'A New Hope',
        openingCrawl: 'A long time ago...',
        director: 'George Lucas',
        producer: 'Gary Kurtz',
        releaseDate: DateTime(1977, 5, 25),
        species: const [],
        starships: const [],
        vehicles: const [],
        characters: const [],
        planets: const [],
      );
      character = const Character(
        name: 'Luke Skywalker',
        image: '',
        birthYear: '19BBY',
        eyeColor: 'blue',
        gender: 'male',
        hairColor: 'blond',
        height: '172',
        homeworld: 'Tatooine',
        mass: '77',
        skinColor: 'fair',
        films: [],
        species: [],
        starships: [],
        vehicles: [],
      );
      planet = const Planet(
        name: 'Tatooine',
        image: '',
        climate: 'arid',
        diameter: '10465',
        gravity: '1 standard',
        orbitalPeriod: '304',
        population: '200000',
        rotationPeriod: '23',
        surfaceWater: '1',
        terrain: 'desert',
        films: [],
        residents: [],
      );
    });

    test('Deve adicionar e persistir favoritos de cada categoria', () async {
      // Arrange
      await store.toggleFilm(film);
      await store.toggleCharacter(character);
      await store.togglePlanet(planet);

      // Act
      final restored = FavoritesStore(FavoritesRepository(storage), authStore);
      await restored.initFavorites();

      // Assert
      expect(restored.isFilmFavorite(film), isTrue);
      expect(restored.isCharacterFavorite(character), isTrue);
      expect(restored.isPlanetFavorite(planet), isTrue);
      expect(restored.films, hasLength(1));
      expect(restored.characters, hasLength(1));
      expect(restored.planets, hasLength(1));
    });

    test('Deve remover um favorito já existente', () async {
      // Arrange
      await store.toggleFilm(film);
      expect(store.isFilmFavorite(film), isTrue);

      // Act
      await store.toggleFilm(film);

      // Assert
      expect(store.isFilmFavorite(film), isFalse);
      expect(store.films, isEmpty);
    });

    test(
      'Deve ignorar carregamento quando não houver utilizador ativo',
      () async {
        // Arrange
        await authStore.logout();

        // Act
        await store.initFavorites();

        // Assert
        expect(store.films, isEmpty);
        expect(store.characters, isEmpty);
        expect(store.planets, isEmpty);
      },
    );
  });
}
