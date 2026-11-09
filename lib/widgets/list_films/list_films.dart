import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:playgroundmobile/models/film.dart';
import 'package:playgroundmobile/stores/favorites/favorites_store.dart';
import 'package:playgroundmobile/widgets/list_films/list_films_item.dart';

class ListFilms extends StatelessWidget {
  const ListFilms({
    super.key,
    required this.films,
    this.favStore,
  });
  
  final List<Film> films;
  final FavoritesStore? favStore;

  @override
  Widget build(BuildContext context) {
    return films.isNotEmpty ? ListView.builder(
      itemCount: films.length,
      itemBuilder: (_, index) => Observer(
        builder: (_) => ListFilmsItem(
          film: films[index],
          isFavorite: favStore != null
              ? favStore!.isFilmFavorite(films[index])
              : false,
          onToggleFavorite: favStore != null
              ? () { favStore!.toggleFilm(films[index]); }
              : null,
        ),
      ),
    ) : const Center(child: Text('Nothing here!'));
  }
}