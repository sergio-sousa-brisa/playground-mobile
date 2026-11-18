import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:playgroundmobile/models/character.dart';
import 'package:playgroundmobile/models/film.dart';
import 'package:playgroundmobile/models/planet.dart';
import 'package:playgroundmobile/pages/search.dart';
import 'package:playgroundmobile/repository/auth_repository.dart';
import 'package:playgroundmobile/repository/favorites_repository.dart';
import 'package:playgroundmobile/repository/repository.dart';
import 'package:playgroundmobile/services/api_service.dart';
import 'package:playgroundmobile/stores/auth/auth_store.dart';
import 'package:playgroundmobile/stores/character/character.dart';
import 'package:playgroundmobile/stores/favorites/favorites_store.dart';
import 'package:playgroundmobile/stores/film/film.dart';
import 'package:playgroundmobile/stores/planet/planet.dart';

import '../support/in_memory_secure_store.dart';

void main() {
  group('SearchPage', () {
    late FilmStore filmStore;
    late CharacterStore characterStore;
    late PlanetStore planetStore;
    late FavoritesStore favoritesStore;

    setUp(() {
      final storage = InMemorySecureStore();
      final authStore = AuthStore(AuthRepository(storage))..currentUser = 'ana';
      final repository = Repository(ApiService());

      filmStore = FilmStore(repository)
        ..films.add(
          Film(
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
          ),
        );
      characterStore = CharacterStore(repository)
        ..characters.add(
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
        );
      planetStore = PlanetStore(repository)
        ..planets.add(
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
        );
      favoritesStore = FavoritesStore(FavoritesRepository(storage), authStore);
    });

    Future<void> pumpSearchPage(WidgetTester tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: SearchPage(
              filmStore: filmStore,
              characterStore: characterStore,
              planetStore: planetStore,
              favStore: favoritesStore,
            ),
          ),
        ),
      );
    }

    testWidgets('Deve exibir instrução antes de pesquisar', (tester) async {
      // Arrange

      // Act
      await pumpSearchPage(tester);

      // Assert
      expect(find.text('Explore o Catálogo'), findsOneWidget);
    });

    testWidgets('Deve filtrar resultados sem diferenciar maiúsculas', (
      tester,
    ) async {
      // Arrange
      await pumpSearchPage(tester);

      // Act
      await tester.enterText(find.byType(TextField), 'lUkE');
      await tester.pump();

      // Assert
      expect(find.text('Luke Skywalker'), findsOneWidget);
      expect(find.text('A New Hope'), findsNothing);
      expect(find.text('Tatooine'), findsNothing);
    });

    testWidgets('Deve exibir estado vazio quando não houver correspondências', (
      tester,
    ) async {
      // Arrange
      await pumpSearchPage(tester);

      // Act
      await tester.enterText(find.byType(TextField), 'inexistente');
      await tester.pump();

      // Assert
      expect(find.text('Nenhum resultado'), findsOneWidget);
    });

    testWidgets('Deve limpar a busca e voltar à instrução inicial', (
      tester,
    ) async {
      // Arrange
      await pumpSearchPage(tester);
      await tester.enterText(find.byType(TextField), 'luke');
      await tester.pump();

      // Act
      await tester.tap(find.byIcon(Icons.clear_rounded));
      await tester.pump();

      // Assert
      expect(find.text('Explore o Catálogo'), findsOneWidget);
      expect(find.text('Luke Skywalker'), findsNothing);
    });
  });
}
