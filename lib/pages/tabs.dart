import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:playgroundmobile/injection.dart';
import 'package:playgroundmobile/pages/favorites.dart';
import 'package:playgroundmobile/pages/search.dart';
import 'package:playgroundmobile/stores/auth/auth_store.dart';
import 'package:playgroundmobile/stores/character/character.dart';
import 'package:playgroundmobile/stores/favorites/favorites_store.dart';
import 'package:playgroundmobile/stores/film/film.dart';
import 'package:playgroundmobile/stores/planet/planet.dart';
import 'package:playgroundmobile/widgets/grid_characters/grid_characters.dart';
import 'package:playgroundmobile/widgets/list_films/list_films.dart';
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
  final AuthStore authStore = getIt<AuthStore>();
  final FavoritesStore favStore = getIt<FavoritesStore>();

  static const List<String> _titles = [
    'Films',
    'Characters',
    'Search',
    'Planets',
    'Favorites',
  ];

  @override
  void initState() {
    super.initState();
    filmStore.loadFilms();
    characterStore.loadCharacters();
    planetsStore.loadPlanets();
    authStore.checkSession();
    favStore.initFavorites();
  }

  void logout() {
    authStore.logout();
    Navigator.pushNamedAndRemoveUntil(
      context,
      '/login',
      (_) => false,
    );
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
                : ListFilms(
                    films: filmStore.films.toList(),
                    favStore: favStore,
                  ),
          ),
          Observer(
            builder: (_) => characterStore.isLoading
                ? loadingWidget
                : GridCharacters(
                    characters: characterStore.characters.toList(),
                    favStore: favStore,
                  ),
          ),
          SearchPage(
            filmStore: filmStore,
            characterStore: characterStore,
            planetStore: planetsStore,
            favStore: favStore,
          ),
          Observer(
            builder: (_) => planetsStore.isLoading
                ? loadingWidget
                : GridPlanets(
                    planets: planetsStore.planets.toList(),
                    favStore: favStore,
                  ),
          ),
          Observer(
            builder: (_) => FavoritesPage(
              favorites: favStore,
              userName: authStore.currentUser ?? '',
              onLogout: logout,
            ),
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
            icon: Icon(Icons.search),
            selectedIcon: Icon(Icons.search_rounded),
            label: 'Search',
          ),
          NavigationDestination(
            icon: Icon(Icons.public_outlined),
            selectedIcon: Icon(Icons.public),
            label: 'Planets',
          ),
          NavigationDestination(
            icon: Icon(Icons.favorite_border_outlined),
            selectedIcon: Icon(Icons.favorite),
            label: 'Favorites',
          ),
        ],
      ),
    );
  }
}