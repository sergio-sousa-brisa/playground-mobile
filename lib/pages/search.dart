import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:playgroundmobile/models/character.dart';
import 'package:playgroundmobile/models/film.dart';
import 'package:playgroundmobile/models/planet.dart';
import 'package:playgroundmobile/stores/character/character.dart';
import 'package:playgroundmobile/stores/favorites/favorites_store.dart';
import 'package:playgroundmobile/stores/film/film.dart';
import 'package:playgroundmobile/stores/planet/planet.dart';

class SearchPage extends StatefulWidget {
  final FilmStore filmStore;
  final CharacterStore characterStore;
  final PlanetStore planetStore;
  final FavoritesStore favStore;

  const SearchPage({
    super.key,
    required this.filmStore,
    required this.characterStore,
    required this.planetStore,
    required this.favStore,
  });

  @override
  State<SearchPage> createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  final TextEditingController _controller = TextEditingController();
  String _query = '';

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  Widget _buildFavoriteButton({
    required bool Function() isFavorite,
    required VoidCallback onToggle,
  }) {
    return Observer(
      builder: (_) {
        final isFav = isFavorite();
        return IconButton(
          icon: Icon(
            isFav ? Icons.favorite : Icons.favorite_border,
            color: isFav ? Colors.red : null,
          ),
          onPressed: onToggle,
        );
      },
    );
  }

  List<Widget> _buildSection<T>({
    required String title,
    required List<T> items,
    required IconData icon,
    required String Function(T) getName,
    required Widget Function(T) buildTrailing,
  }) {
    if (items.isEmpty) return [];

    return [
      Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
        child: Text(
          '$title (${items.length})',
          style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
        ),
      ),
      ...items.map((item) => ListTile(
            leading: Icon(icon),
            title: Text(getName(item)),
            trailing: buildTrailing(item),
          )),
    ];
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.all(16.0),
          child: SearchBar(
            controller: _controller,
            hintText: 'Search films, characters, planets...',
            leading: const Icon(Icons.search),
            trailing: [
              if (_query.isNotEmpty)
                IconButton(
                  icon: const Icon(Icons.clear),
                  onPressed: () {
                    _controller.clear();
                    setState(() => _query = '');
                  },
                ),
            ],
            onChanged: (value) {
              setState(() => _query = value.trim().toLowerCase());
            },
          ),
        ),
        Expanded(
          child: Observer(
            builder: (_) {
              if (_query.isEmpty) {
                return const Center(
                  child: Text('Type a term to search the entire catalog.'),
                );
              }

              final filteredFilms = widget.filmStore.films
                  .where((f) => f.title.toLowerCase().contains(_query))
                  .toList();

              final filteredCharacters = widget.characterStore.characters
                  .where((c) => c.name.toLowerCase().contains(_query))
                  .toList();

              final filteredPlanets = widget.planetStore.planets
                  .where((p) => p.name.toLowerCase().contains(_query))
                  .toList();

              if (filteredFilms.isEmpty && filteredCharacters.isEmpty && filteredPlanets.isEmpty) {
                return const Center(child: Text('No results found.'));
              }

              return ListView(
                children: [
                  ..._buildSection<Film>(
                    title: 'Films',
                    items: filteredFilms,
                    icon: Icons.movie_outlined,
                    getName: (film) => film.title,
                    buildTrailing: (film) => _buildFavoriteButton(
                      isFavorite: () => widget.favStore.isFilmFavorite(film),
                      onToggle: () => widget.favStore.toggleFilm(film),
                    ),
                  ),
                  ..._buildSection<Character>(
                    title: 'Characters',
                    items: filteredCharacters,
                    icon: Icons.person_outline,
                    getName: (char) => char.name,
                    buildTrailing: (char) => _buildFavoriteButton(
                      isFavorite: () => widget.favStore.isCharacterFavorite(char),
                      onToggle: () => widget.favStore.toggleCharacter(char),
                    ),
                  ),
                  ..._buildSection<Planet>(
                    title: 'Planets',
                    items: filteredPlanets,
                    icon: Icons.public,
                    getName: (planet) => planet.name,
                    buildTrailing: (planet) => _buildFavoriteButton(
                      isFavorite: () => widget.favStore.isPlanetFavorite(planet),
                      onToggle: () => widget.favStore.togglePlanet(planet),
                    ),
                  ),
                ],
              );
            },
          ),
        ),
      ],
    );
  }
}