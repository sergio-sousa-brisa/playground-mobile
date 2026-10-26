import 'package:flutter/material.dart';
import 'package:playgroundmobile/models/character.dart';
import 'package:playgroundmobile/widgets/grid_characters/grid_characters_item.dart';

class GridCharacters extends StatelessWidget{
  const GridCharacters({
    super.key,
    required this.characters
    });
  final List<Character> characters;
  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      itemCount: characters.length,
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2),
      itemBuilder: (_, index) => GridCharactersItem(charac: characters[index]),);
  }
}