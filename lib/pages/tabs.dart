import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:playgroundmobile/injection.dart';
import 'package:playgroundmobile/stores/character/character.dart';
import 'package:playgroundmobile/stores/film/film.dart';
import 'package:playgroundmobile/stores/planet/planet.dart';
import 'package:playgroundmobile/widgets/grid_characters/grid_characters.dart';
import 'package:playgroundmobile/widgets/grid_films/list_films.dart';
import 'package:playgroundmobile/widgets/grid_planets/grid_planets.dart';

class Tabs extends StatefulWidget {
  const Tabs({super.key});

  @override
  State<Tabs> createState() => _TabsState();
}

class _TabsState extends State<Tabs> {
  int _index = 0;

  final FilmStore filmStore = getIt<FilmStore>();
  final CharacterStore characterStore = getIt<CharacterStore>();
  final PlanetStore planetsStore = getIt<PlanetStore>();

  static const List<String> _titles = ['Films', 'Characters', 'Planets'];

  @override
  void initState() {
    super.initState();
    filmStore.loadFilms();
    characterStore.loadCharacters();
    planetsStore.loadPlanets();
  }

  @override
  Widget build(BuildContext context) {
    const loadingWidget = Center(child: CircularProgressIndicator());

    return Scaffold(
      appBar: AppBar(
        title: Text(_titles[_index]),
      ),
      body: IndexedStack(
        index: _index,
        children: [
          Observer(
            builder: (_) => filmStore.isLoading
                ? loadingWidget
                : ListFilms(films: filmStore.films.toList()),
          ),
          Observer(
            builder: (_) => characterStore.isLoading
                ? loadingWidget
                : GridCharacters(characters: characterStore.characters.toList()),
          ),
          Observer(
            builder: (_) => planetsStore.isLoading
                ? loadingWidget
                : GridPlanets(planets: planetsStore.planets.toList()),
          ),
        ],
      ),
      bottomNavigationBar: NavigationBar(
        selectedIndex: _index,
        onDestinationSelected: (value) {
          setState(() {
            _index = value;
          });
        },
        destinations: const [
          NavigationDestination(
            icon: Icon(Icons.movie_outlined),
            selectedIcon: Icon(Icons.movie),
            label: 'Films',
          ),
          NavigationDestination(
            icon: Icon(Icons.person_outline),
            selectedIcon: Icon(Icons.person),
            label: 'Characters',
          ),
          NavigationDestination(
            icon: Icon(Icons.public),
            label: 'Planets',
          ),
        ],
      ),
    );
  }
}