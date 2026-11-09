import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:playgroundmobile/stores/favorites/favorites_store.dart';
import 'package:playgroundmobile/widgets/list_films/list_films.dart';
import 'package:playgroundmobile/widgets/grid_characters/grid_characters.dart';
import 'package:playgroundmobile/widgets/grid_planets/grid_planets.dart';

class FavoritesPage extends StatefulWidget {
  final FavoritesStore favorites;
  final String userName;
  final VoidCallback onLogout;

  const FavoritesPage({
    super.key,
    required this.favorites,
    required this.userName,
    required this.onLogout,
  });

  @override
  State<FavoritesPage> createState() => _FavoritesPageState();
}

class _FavoritesPageState extends State<FavoritesPage> {
  Future<void> _showLogoutConfirmation(BuildContext context) async {
    final theme = Theme.of(context);
    
    final bool? confirm = await showDialog<bool>(
      context: context,
      builder: (BuildContext dialogContext) {
        return AlertDialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
          ),
          title: Row(
            children: [
              Icon(Icons.logout_rounded, color: theme.colorScheme.error),
              const SizedBox(width: 10),
              const Text('Sair da conta'),
            ],
          ),
          content: const Text('Tem certeza que deseja sair do aplicativo?'),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(dialogContext).pop(false),
              child: const Text('Cancelar'),
            ),
            FilledButton(
              style: FilledButton.styleFrom(
                backgroundColor: theme.colorScheme.error,
                foregroundColor: theme.colorScheme.onError,
              ),
              onPressed: () => Navigator.of(dialogContext).pop(true),
              child: const Text('Sair'),
            ),
          ],
        );
      },
    );

    if (confirm == true) {
      widget.onLogout();
    }
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Hi, ${widget.userName}',
                      style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
                    ),
                    Text(
                      'My Favorites',
                      style: Theme.of(context).textTheme.bodySmall,
                    ),
                  ],
                ),
                IconButton(
                  icon: const Icon(Icons.logout_rounded),
                  tooltip: 'Exit',
                  onPressed: () => _showLogoutConfirmation(context),
                ),
              ],
            ),
          ),
          const TabBar(
            dividerColor: Colors.transparent,
            tabs: [
              Tab(text: 'Films'),
              Tab(text: 'Characters'),
              Tab(text: 'Planets'),
            ],
          ),
          Expanded(
            child: TabBarView(
              children: [
                Observer(builder:(_) =>   ListFilms(
                  favStore: widget.favorites,
                  films: widget.favorites.films.toList()
                  )),
                Observer(builder: (_) => GridCharacters(
                  favStore: widget.favorites ,
                  characters: widget.favorites.characters.toList()
                  )),
                Observer(builder: (_) => GridPlanets(
                  favStore: widget.favorites,
                  planets: widget.favorites.planets.toList()
                  )),
              ],
            ),
          ),
        ],
      ),
    );
  }
}