import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:playgroundmobile/models/character.dart';
import 'package:playgroundmobile/widgets/grid_characters/grid_characters_item.dart';

void main() {
  group('GridCharactersItem', () {
    late Character character;

    setUp(() {
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
        species: ['Human'],
        starships: [],
        vehicles: [],
      );
    });

    testWidgets('Deve exibir nome, espécie e gênero do personagem', (
      tester,
    ) async {
      // Arrange
      final widget = GridCharactersItem(charac: character);

      // Act
      await tester.pumpWidget(MaterialApp(home: Scaffold(body: widget)));

      // Assert
      expect(find.text('Luke Skywalker'), findsOneWidget);
      expect(find.text('HUMAN'), findsOneWidget);
      expect(find.byIcon(Icons.male_rounded), findsOneWidget);
    });

    testWidgets('Deve chamar callback ao tocar no botão de favorito', (
      tester,
    ) async {
      // Arrange
      var callbackCalled = false;
      final widget = GridCharactersItem(
        charac: character,
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
