import 'dart:convert';

import 'package:playgroundmobile/models/character.dart';
import 'package:playgroundmobile/models/film.dart';
import 'package:playgroundmobile/models/planet.dart';


class FavoritesModel {
  final List<Film> films;
  final List<Character> characters;
  final List<Planet> planets;

  const FavoritesModel({
    this.films = const [],
    this.characters = const [],
    this.planets = const [],
  });

  Map<String, dynamic> toMap() {
    return {
      'films': films.map((f) => f.toMap()).toList(),
      'characters': characters.map((c) => c.toMap()).toList(),
      'planets': planets.map((p) => p.toMap()).toList(),
    };
  }

  factory FavoritesModel.fromMap(Map<String, dynamic> map) {
    return FavoritesModel(
      films: (map['films'] as List<dynamic>?)
              ?.map((e) => Film.fromJson(e as Map<String, dynamic>))
              .toList() ??
          [],
      characters: (map['characters'] as List<dynamic>?)
              ?.map((e) => Character.fromJson(e as Map<String, dynamic>))
              .toList() ??
          [],
      planets: (map['planets'] as List<dynamic>?)
              ?.map((e) => Planet.fromJson(e as Map<String, dynamic>))
              .toList() ??
          [],
    );
  }

  String toJson() => jsonEncode(toMap());

  factory FavoritesModel.fromJson(String source) =>
      FavoritesModel.fromMap(jsonDecode(source) as Map<String, dynamic>);
}