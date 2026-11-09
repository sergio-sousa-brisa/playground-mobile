import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:playgroundmobile/models/planet.dart';
import 'package:playgroundmobile/stores/favorites/favorites_store.dart';
import 'package:playgroundmobile/widgets/grid_planets/grid_planets_item.dart';

class GridPlanets extends StatelessWidget {
  const GridPlanets({
    super.key,
    required this.planets,
    this.favStore,
  });

  final List<Planet> planets;
  final FavoritesStore? favStore;

  @override
  Widget build(BuildContext context) {
    return planets.isNotEmpty
        ? GridView.builder(
            itemCount: planets.length,
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2),
            itemBuilder: (_, index) => Observer(
              builder: (_) => GridPlanetsItem(
                planet: planets[index],
                isFavorite: favStore != null
                    ? favStore!.isPlanetFavorite(planets[index])
                    : false,
                onToggleFavorite: favStore != null
                    ? () {
                        favStore!.togglePlanet(planets[index]);
                      }
                    : null,
              ),
            ),
          )
        : const Center(
            child: Text('Nothing here!'),
          );
  }
}