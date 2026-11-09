import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:playgroundmobile/models/character.dart';
import 'package:playgroundmobile/stores/favorites/favorites_store.dart';
import 'package:playgroundmobile/widgets/grid_characters/grid_characters_item.dart';

class GridCharacters extends StatelessWidget{
  const GridCharacters({
    super.key,
    required this.characters,
    this.favStore
    });
  final List<Character> characters;
  final FavoritesStore? favStore;
  @override
  Widget build(BuildContext context) {
    return characters.isNotEmpty? GridView.builder(
      itemCount: characters.length,
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2),
      itemBuilder: (_, index) => Observer(
        builder: (_) => GridCharactersItem(
          charac: characters[index],
          isFavorite: favStore != null
          ? favStore!.isCharacterFavorite(characters[index])
          : false,
          onToggleFavorite: favStore != null
          ? (){ favStore!.toggleCharacter(characters[index]);}
          : null,
          ),
      ),)
      : const Center(child: Text('Nothing here!'),);
  }
}