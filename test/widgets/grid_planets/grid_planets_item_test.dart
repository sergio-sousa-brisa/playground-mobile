import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:playgroundmobile/models/planet.dart';
import 'package:playgroundmobile/widgets/grid_planets/grid_planets_item.dart';

void main() {
  group('GridPlanetsItem', () {
    late Planet planet;

    setUp(() {
      planet = const Planet(
        name: 'Tatooine',
        image: '',
        climate: 'arid',
        diameter: '10465',
        gravity: '1 standard',
        orbitalPeriod: '304',
        population: '1200000',
        rotationPeriod: '23',
        surfaceWater: '1',
        terrain: 'desert, mountains',
        films: [],
        residents: [],
      );
    });

    testWidgets('Deve formatar terreno e população do planeta', (tester) async {
      // Arrange
      final widget = GridPlanetsItem(planet: planet);

      // Act
      await tester.pumpWidget(MaterialApp(home: Scaffold(body: widget)));

      // Assert
      expect(find.text('Tatooine'), findsOneWidget);
      expect(find.text('desert'), findsOneWidget);
      expect(find.text('1.2M'), findsOneWidget);
    });

    testWidgets('Deve manter população não numérica sem formatação', (
      tester,
    ) async {
      // Arrange
      final widget = GridPlanetsItem(
        planet: planet.copyWith(population: 'unknown'),
      );

      // Act
      await tester.pumpWidget(MaterialApp(home: Scaffold(body: widget)));

      // Assert
      expect(find.text('unknown'), findsOneWidget);
    });

    testWidgets('Deve chamar callback ao tocar no botão de favorito', (
      tester,
    ) async {
      // Arrange
      var callbackCalled = false;
      final widget = GridPlanetsItem(
        planet: planet,
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
