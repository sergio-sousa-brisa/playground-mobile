import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:playgroundmobile/models/character.dart';
import 'package:playgroundmobile/widgets/grid_characters/grid_characters.dart';

void main() {
  group('GridCharacters', () {
    late List<Character> characters;

    setUp(() {
      characters = [
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
      ];
    });

    testWidgets('Deve exibir estado vazio quando não houver personagens', (
      tester,
    ) async {
      // Arrange
      const widget = GridCharacters(characters: []);

      // Act
      await tester.pumpWidget(const MaterialApp(home: Scaffold(body: widget)));

      // Assert
      expect(find.text('Nothing here!'), findsOneWidget);
    });

    testWidgets('Deve exibir os personagens quando a lista não estiver vazia', (
      tester,
    ) async {
      // Arrange
      final widget = GridCharacters(characters: characters);

      // Act
      await tester.pumpWidget(MaterialApp(home: Scaffold(body: widget)));

      // Assert
      expect(find.text('Luke Skywalker'), findsOneWidget);
    });
  });
}
