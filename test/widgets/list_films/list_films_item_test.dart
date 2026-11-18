import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:playgroundmobile/models/film.dart';
import 'package:playgroundmobile/widgets/list_films/list_films_item.dart';

void main() {
  group('ListFilmsItem', () {
    late Film film;

    setUp(() {
      film = Film(
        title: 'A New Hope',
        openingCrawl: 'A long time ago...\nIn a galaxy far, far away.',
        director: 'George Lucas',
        producer: 'Gary Kurtz',
        releaseDate: DateTime(1977, 5, 25),
        species: const [],
        starships: const [],
        vehicles: const [],
        characters: const [],
        planets: const [],
      );
    });

    testWidgets('Deve mostrar os dados principais do filme', (tester) async {
      // Arrange
      final widget = ListFilmsItem(film: film);

      // Act
      await tester.pumpWidget(MaterialApp(home: Scaffold(body: widget)));

      // Assert
      expect(find.text('A New Hope'), findsOneWidget);
      expect(find.text('1977'), findsOneWidget);
      expect(find.text('Dir. George Lucas'), findsOneWidget);
      expect(
        find.text('A long time ago... In a galaxy far, far away.'),
        findsOneWidget,
      );
    });

    testWidgets('Deve indicar favorito e chamar callback ao tocar no botão', (
      tester,
    ) async {
      // Arrange
      var callbackCalled = false;
      final widget = ListFilmsItem(
        film: film,
        isFavorite: true,
        onToggleFavorite: () => callbackCalled = true,
      );
      await tester.pumpWidget(MaterialApp(home: Scaffold(body: widget)));

      // Act
      await tester.tap(find.byIcon(Icons.favorite_rounded));

      // Assert
      expect(callbackCalled, isTrue);
    });
  });
}
