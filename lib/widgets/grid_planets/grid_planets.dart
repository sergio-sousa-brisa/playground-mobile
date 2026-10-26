import 'package:flutter/material.dart';
import 'package:playgroundmobile/models/planet.dart';
import 'package:playgroundmobile/widgets/grid_planets/grid_planets_item.dart';

class GridPlanets extends StatelessWidget{
  const GridPlanets({
    super.key,
    required this.planets
    });
  final List<Planet> planets;
  @override
  Widget build(BuildContext context) {
    return planets.isNotEmpty? GridView.builder(
      itemCount: planets.length,
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2),
      itemBuilder: (_, index) => GridPlanetsItem(planet: planets[index]),)
      : Center(child: Text('Nothing here!'),);
  }
}