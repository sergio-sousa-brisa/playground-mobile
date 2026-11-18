import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:playgroundmobile/models/planet.dart';
import 'package:playgroundmobile/widgets/grid_planets/grid_planets.dart';

void main() {
  group('GridPlanets', () {
    late List<Planet> planets;

    setUp(() {
      planets = [
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
      ];
    });

    testWidgets('Deve exibir estado vazio quando não houver planetas', (
      tester,
    ) async {
      // Arrange
      const widget = GridPlanets(planets: []);

      // Act
      await tester.pumpWidget(const MaterialApp(home: Scaffold(body: widget)));

      // Assert
      expect(find.text('Nothing here!'), findsOneWidget);
    });

    testWidgets('Deve exibir os planetas quando a lista não estiver vazia', (
      tester,
    ) async {
      // Arrange
      final widget = GridPlanets(planets: planets);

      // Act
      await tester.pumpWidget(MaterialApp(home: Scaffold(body: widget)));

      // Assert
      expect(find.text('Tatooine'), findsOneWidget);
    });
  });
}
