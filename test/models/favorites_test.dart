import 'package:flutter_test/flutter_test.dart';
import 'package:playgroundmobile/models/character.dart';
import 'package:playgroundmobile/models/favorites.dart';
import 'package:playgroundmobile/models/film.dart';
import 'package:playgroundmobile/models/planet.dart';

void main() {
  group('FavoritesModel', () {
    test('Deve restaurar filmes, personagens e planetas do JSON', () {
      // Arrange
      final favorites = FavoritesModel(
        films: [
          Film(
            title: 'A New Hope',
            openingCrawl: 'A long time ago...',
            director: 'George Lucas',
            producer: 'Gary Kurtz',
            releaseDate: DateTime(1977, 5, 25),
            species: [],
            starships: [],
            vehicles: [],
            characters: [],
            planets: [],
          ),
        ],
        characters: [
          const Character(
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
          ),
        ],
        planets: [
          const Planet(
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
          ),
        ],
      );

      // Act
      final restored = FavoritesModel.fromJson(favorites.toJson());

      // Assert
      expect(restored.films.single.title, 'A New Hope');
      expect(restored.characters.single.name, 'Luke Skywalker');
      expect(restored.planets.single.name, 'Tatooine');
    });

    test(
      'Deve usar listas vazias quando as categorias não estiverem no JSON',
      () {
        // Arrange
        const json = '{}';

        // Act
        final restored = FavoritesModel.fromJson(json);

        // Assert
        expect(restored.films, isEmpty);
        expect(restored.characters, isEmpty);
        expect(restored.planets, isEmpty);
      },
    );
  });
}
