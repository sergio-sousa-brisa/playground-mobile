import 'package:flutter/material.dart';
import 'package:playgroundmobile/models/film.dart';
import 'package:playgroundmobile/widgets/grid_films/list_films_item.dart';

class ListFilms extends StatelessWidget {
  const ListFilms({
    super.key,
    required this.films
    });
  final List<Film> films;

  @override
  Widget build(BuildContext context) {
    return films.isNotEmpty? ListView.builder(
      itemCount: films.length,
      itemBuilder: (_, index) => ListFilmsItem(film: films[index])
      ,)
      : Center(child: Text('Nothing here!'),);
  }
}