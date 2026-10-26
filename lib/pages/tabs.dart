import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:playgroundmobile/injection.dart';
import 'package:playgroundmobile/stores/character/character.dart';
import 'package:playgroundmobile/stores/film/film.dart';
import 'package:playgroundmobile/stores/planet/planet.dart';
import 'package:playgroundmobile/widgets/grid_characters/grid_characters.dart';
import 'package:playgroundmobile/widgets/grid_films/list_films.dart';
import 'package:playgroundmobile/widgets/grid_planets/grid_planets.dart';

class TabConfig {
  final String title;
  final IconData icon;
  final Widget content;

  TabConfig({
    required this.title,
    required this.icon,
    required this.content,
  });
}

class Tabs extends StatefulWidget{
  const Tabs({super.key});

  @override
  State<Tabs> createState() => _TabsState();
}

class _TabsState extends State<Tabs> {
  int _index = 0;
  final FilmStore filmStore = getIt<FilmStore>();
  final CharacterStore characterStore = getIt<CharacterStore>();
  final PlanetStore planetsStore = getIt<PlanetStore>();
  final loading = Center(child: CircularProgressIndicator());
  @override
  void initState() {
    super.initState();
    filmStore.loadFilms();
    characterStore.loadCharacters();
    planetsStore.loadPlanets();
  }

  @override
  Widget build(BuildContext context) {

    List<TabConfig> tabs =  [
    TabConfig(
      title: 'Films', 
      icon: Icons.movie, 
      content: Observer(builder: (_) {
        if (filmStore.isLoading){
          return loading;
        }
        return ListFilms(films: filmStore.films.toList());
      },)
      ),
    TabConfig(
      title: 'Characters', 
      icon: Icons.person, 
      content: Observer(builder: (_) {
        if (characterStore.isLoading){
          return loading;
        }
        return GridCharacters(characters: characterStore.characters.toList());
        })
      ),
    TabConfig(
      title: 'Planets', 
      icon: Icons.public, 
      content: Observer(builder: (_) { 
        if (planetsStore.isLoading){
          return loading;
        }
        return GridPlanets(planets: planetsStore.planets.toList());
        })
      )
    ];
    final currentTab = tabs[_index];
    return Scaffold(
      appBar: AppBar(title: Text(currentTab.title)),
      body:  currentTab.content,
      bottomNavigationBar: BottomNavigationBar(
      currentIndex: _index,
      items: tabs.map(
        (tab) =>  BottomNavigationBarItem(icon: Icon(tab.icon), label: tab.title )
        ).toList(),
      onTap: (value) {
        setState(() {
          _index = value;
        });
      },
      ),
    );
  }
}