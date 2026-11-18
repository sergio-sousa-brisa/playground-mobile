import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:playgroundmobile/models/film.dart';
import 'package:playgroundmobile/widgets/list_films/list_films.dart';

void main() {
  group('ListFilms', () {
    late List<Film> films;

    setUp(() {
      films = [
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
      ];
    });

    testWidgets('Deve exibir estado vazio quando não houver filmes', (
      tester,
    ) async {
      // Arrange
      const widget = ListFilms(films: []);

      // Act
      await tester.pumpWidget(const MaterialApp(home: Scaffold(body: widget)));

      // Assert
      expect(find.text('Nothing here!'), findsOneWidget);
    });

    testWidgets('Deve exibir os filmes quando a lista não estiver vazia', (
      tester,
    ) async {
      // Arrange
      final widget = ListFilms(films: films);

      // Act
      await tester.pumpWidget(MaterialApp(home: Scaffold(body: widget)));

      // Assert
      expect(find.text('A New Hope'), findsOneWidget);
    });
  });
}
