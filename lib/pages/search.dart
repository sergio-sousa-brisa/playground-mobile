import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:playgroundmobile/models/character.dart';
import 'package:playgroundmobile/models/film.dart';
import 'package:playgroundmobile/models/planet.dart';
import 'package:playgroundmobile/stores/character/character.dart';
import 'package:playgroundmobile/stores/favorites/favorites_store.dart';
import 'package:playgroundmobile/stores/film/film.dart';
import 'package:playgroundmobile/stores/planet/planet.dart';
import 'package:transparent_image/transparent_image.dart';

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
        final theme = Theme.of(context);
        
        return IconButton(
          icon: Icon(
            isFav ? Icons.favorite_rounded : Icons.favorite_border_rounded,
            color: isFav ? Colors.red : theme.colorScheme.onSurfaceVariant,
          ),
          onPressed: onToggle,
        );
      },
    );
  }

  Widget _buildEmptyState(String title, String subtitle, IconData icon) {
    final theme = Theme.of(context);
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                color: theme.colorScheme.surfaceContainerHighest.withValues(alpha: 0.5),
                shape: BoxShape.circle,
              ),
              child: Icon(
                icon,
                size: 48,
                color: theme.colorScheme.onSurfaceVariant,
              ),
            ),
            const SizedBox(height: 16),
            Text(
              title,
              style: theme.textTheme.titleMedium?.copyWith(
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              subtitle,
              textAlign: TextAlign.center,
              style: theme.textTheme.bodyMedium?.copyWith(
                color: theme.colorScheme.onSurfaceVariant,
              ),
            ),
          ],
        ),
      ),
    );
  }

  List<Widget> _buildSection<T>({
    required String title,
    required List<T> items,
    required IconData fallbackIcon,
    required String Function(T) getName,
    required String Function(T) getImageUrl,
    required Widget Function(T) buildTrailing,
  }) {
    if (items.isEmpty) return [];

    final theme = Theme.of(context);

    return [
      Padding(
        padding: const EdgeInsets.only(left: 16, right: 16, top: 24, bottom: 8),
        child: Row(
          children: [
            Text(
              title,
              style: theme.textTheme.titleMedium?.copyWith(
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(width: 8),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
              decoration: BoxDecoration(
                color: theme.colorScheme.primaryContainer,
                borderRadius: BorderRadius.circular(12),
              ),
              child: Text(
                '${items.length}',
                style: TextStyle(
                  color: theme.colorScheme.onPrimaryContainer,
                  fontSize: 12,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ],
        ),
      ),
      ...items.map((item) => Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 4.0),
            child: Card(
              elevation: 0,
              color: theme.colorScheme.surface,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
                side: BorderSide(
                  color: theme.colorScheme.outlineVariant.withValues(alpha: 0.4),
                ),
              ),
              child: ListTile(
                contentPadding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
                leading: ClipRRect(
                  borderRadius: BorderRadius.circular(8),
                  child: SizedBox(
                    width: 48,
                    height: 48,
                    child: FadeInImage.memoryNetwork(
                      placeholder: kTransparentImage,
                      image: getImageUrl(item),
                      fit: BoxFit.cover,
                      imageErrorBuilder: (context, error, stackTrace) => Container(
                        color: theme.colorScheme.surfaceContainerHighest,
                        child: Icon(fallbackIcon, color: theme.colorScheme.onSurfaceVariant),
                      ),
                    ),
                  ),
                ),
                title: Text(
                  getName(item),
                  style: const TextStyle(fontWeight: FontWeight.w600),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
                trailing: buildTrailing(item),
              ),
            ),
          )),
    ];
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.fromLTRB(16, 16, 16, 8),
          child: SearchBar(
            controller: _controller,
            hintText: 'Buscar filmes, personagens, planetas...',
            elevation: const WidgetStatePropertyAll(0),
            backgroundColor: WidgetStatePropertyAll(
              theme.colorScheme.surfaceContainerHighest.withValues(alpha: 0.3),
            ),
            padding: const WidgetStatePropertyAll(EdgeInsets.symmetric(horizontal: 16)),
            leading: Icon(Icons.search_rounded, color: theme.colorScheme.primary),
            trailing: [
              if (_query.isNotEmpty)
                IconButton(
                  icon: const Icon(Icons.clear_rounded),
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
                return _buildEmptyState(
                  'Explore o Catálogo',
                  'Digite um termo para pesquisar filmes, personagens ou planetas.',
                  Icons.manage_search_rounded,
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

              if (filteredFilms.isEmpty &&
                  filteredCharacters.isEmpty &&
                  filteredPlanets.isEmpty) {
                return _buildEmptyState(
                  'Nenhum resultado',
                  'Não encontramos nada correspondente a "$_query".\nTente usar palavras diferentes.',
                  Icons.search_off_rounded,
                );
              }

              return ListView(
                padding: const EdgeInsets.only(bottom: 24),
                children: [
                  ..._buildSection<Film>(
                    title: 'Filmes',
                    items: filteredFilms,
                    fallbackIcon: Icons.movie_outlined,
                    getName: (film) => film.title,
                    getImageUrl: (film) => film.image,
                    buildTrailing: (film) => _buildFavoriteButton(
                      isFavorite: () => widget.favStore.isFilmFavorite(film),
                      onToggle: () => widget.favStore.toggleFilm(film),
                    ),
                  ),
                  ..._buildSection<Character>(
                    title: 'Personagens',
                    items: filteredCharacters,
                    fallbackIcon: Icons.person_outline,
                    getName: (char) => char.name,
                    getImageUrl: (char) => char.image,
                    buildTrailing: (char) => _buildFavoriteButton(
                      isFavorite: () => widget.favStore.isCharacterFavorite(char),
                      onToggle: () => widget.favStore.toggleCharacter(char),
                    ),
                  ),
                  ..._buildSection<Planet>(
                    title: 'Planetas',
                    items: filteredPlanets,
                    fallbackIcon: Icons.public,
                    getName: (planet) => planet.name,
                    getImageUrl: (planet) => planet.image,
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