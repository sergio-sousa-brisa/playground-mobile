import 'package:playgroundmobile/models/character.dart';
import 'package:playgroundmobile/models/favorites.dart';
import 'package:playgroundmobile/models/film.dart';
import 'package:playgroundmobile/models/planet.dart';

final List<Film> films = [
  Film(
    title: 'A New Hope',
    image: 'https://m.media-amazon.com/images/M/MV5BOGUwMDk0Y2MtNjBlNi00NmRiLTk2MWYtMGMyMDlhYmI4ZDBjXkEyXkFqcGc@._V1_.jpg',
    openingCrawl: '''It is a period of civil war.
Rebel spaceships, striking
from a hidden base, have won
their first victory against
the evil Galactic Empire.

During the battle, Rebel
spies managed to steal secret
plans to the Empire's
ultimate weapon, the DEATH
STAR, an armored space
station with enough power
to destroy an entire planet.

Pursued by the Empire's
sinister agents, Princess
Leia races home aboard her
starship, custodian of the
stolen plans that can save her
people and restore
freedom to the galaxy....''',
    director: 'George Lucas',
    producer: 'Gary Kurtz, Rick McCallum',
    releaseDate: DateTime.parse('1977-05-25'),
    characters: const [
      'https://swapi.dev/api/people/1/',
      'https://swapi.dev/api/people/2/',
      'https://swapi.dev/api/people/3/',
      'https://swapi.dev/api/people/4/',
      'https://swapi.dev/api/people/5/',
      'https://swapi.dev/api/people/6/',
      'https://swapi.dev/api/people/7/',
      'https://swapi.dev/api/people/8/',
      'https://swapi.dev/api/people/9/',
      'https://swapi.dev/api/people/10/',
      'https://swapi.dev/api/people/12/',
      'https://swapi.dev/api/people/13/',
      'https://swapi.dev/api/people/14/',
      'https://swapi.dev/api/people/15/',
      'https://swapi.dev/api/people/16/',
      'https://swapi.dev/api/people/18/',
      'https://swapi.dev/api/people/19/',
      'https://swapi.dev/api/people/81/',
    ],
    planets: const [
      'https://swapi.dev/api/planets/1/',
      'https://swapi.dev/api/planets/2/',
      'https://swapi.dev/api/planets/3/',
    ],
    starships: const [
      'https://swapi.dev/api/starships/2/',
      'https://swapi.dev/api/starships/3/',
      'https://swapi.dev/api/starships/5/',
      'https://swapi.dev/api/starships/9/',
      'https://swapi.dev/api/starships/10/',
      'https://swapi.dev/api/starships/11/',
      'https://swapi.dev/api/starships/12/',
      'https://swapi.dev/api/starships/13/',
    ],
    vehicles: const [
      'https://swapi.dev/api/vehicles/4/',
      'https://swapi.dev/api/vehicles/6/',
      'https://swapi.dev/api/vehicles/7/',
      'https://swapi.dev/api/vehicles/8/',
    ],
    species: const [
      'https://swapi.dev/api/species/1/',
      'https://swapi.dev/api/species/2/',
      'https://swapi.dev/api/species/3/',
      'https://swapi.dev/api/species/4/',
      'https://swapi.dev/api/species/5/',
    ],
  ),
  Film(
    title: 'The Empire Strikes Back',
    image: 'https://m.media-amazon.com/images/M/MV5BMTkxNGFlNDktZmJkNC00MDdhLTg0MTEtZjZiYWI3MGE5NWIwXkEyXkFqcGc@._V1_.jpg',
    openingCrawl: '''It is a dark time for the
Rebellion. Although the Death
Star has been destroyed,
Imperial troops have driven the
Rebel forces from their hidden
base and pursued them across
the galaxy.

Evading the dreaded Imperial
Starfleet, a group of freedom
fighters led by Luke Skywalker
has established a new secret
base on the remote ice world
of Hoth.

The evil lord Darth Vader,
obsessed with finding young
Skywalker, has dispatched
thousands of remote probes into
the far reaches of space....''',
    director: 'Irvin Kershner',
    producer: 'Gary Kurtz, Rick McCallum',
    releaseDate: DateTime.parse('1980-05-17'),
    characters: const [
      'https://swapi.dev/api/people/1/',
      'https://swapi.dev/api/people/2/',
      'https://swapi.dev/api/people/3/',
      'https://swapi.dev/api/people/4/',
      'https://swapi.dev/api/people/5/',
      'https://swapi.dev/api/people/10/',
      'https://swapi.dev/api/people/13/',
      'https://swapi.dev/api/people/14/',
      'https://swapi.dev/api/people/18/',
      'https://swapi.dev/api/people/20/',
      'https://swapi.dev/api/people/21/',
      'https://swapi.dev/api/people/22/',
      'https://swapi.dev/api/people/23/',
      'https://swapi.dev/api/people/24/',
      'https://swapi.dev/api/people/25/',
      'https://swapi.dev/api/people/26/',
    ],
    planets: const [
      'https://swapi.dev/api/planets/4/',
      'https://swapi.dev/api/planets/5/',
      'https://swapi.dev/api/planets/6/',
      'https://swapi.dev/api/planets/27/',
    ],
    starships: const [
      'https://swapi.dev/api/starships/3/',
      'https://swapi.dev/api/starships/10/',
      'https://swapi.dev/api/starships/11/',
      'https://swapi.dev/api/starships/12/',
      'https://swapi.dev/api/starships/15/',
      'https://swapi.dev/api/starships/17/',
      'https://swapi.dev/api/starships/21/',
      'https://swapi.dev/api/starships/22/',
      'https://swapi.dev/api/starships/23/',
    ],
    vehicles: const [
      'https://swapi.dev/api/vehicles/8/',
      'https://swapi.dev/api/vehicles/14/',
      'https://swapi.dev/api/vehicles/16/',
      'https://swapi.dev/api/vehicles/18/',
      'https://swapi.dev/api/vehicles/19/',
      'https://swapi.dev/api/vehicles/20/',
    ],
    species: const [
      'https://swapi.dev/api/species/1/',
      'https://swapi.dev/api/species/2/',
      'https://swapi.dev/api/species/3/',
      'https://swapi.dev/api/species/6/',
      'https://swapi.dev/api/species/7/',
    ],
  ),
];

final List<Character> characters = [
  Character(
    name: 'Luke Skywalker',
    image: 'https://lumiere-a.akamaihd.net/v1/images/luke-skywalker-main_fb34a1ff.jpeg',
    birthYear: '19BBY',
    eyeColor: 'blue',
    gender: 'male',
    hairColor: 'blond',
    height: '172',
    homeworld: 'https://swapi.dev/api/planets/1/',
    mass: '77',
    skinColor: 'fair',
    films: const [
      'https://swapi.dev/api/films/1/',
      'https://swapi.dev/api/films/2/',
      'https://swapi.dev/api/films/3/',
      'https://swapi.dev/api/films/6/',
    ],
    species: const [],
    vehicles: const [
      'https://swapi.dev/api/vehicles/14/',
      'https://swapi.dev/api/vehicles/30/',
    ],
    starships: const [
      'https://swapi.dev/api/starships/12/',
      'https://swapi.dev/api/starships/22/',
    ],
  ),
  Character(
    name: 'C-3PO',
    image: '',
    birthYear: '112BBY',
    eyeColor: 'yellow',
    gender: 'n/a',
    hairColor: 'n/a',
    height: '167',
    homeworld: 'https://swapi.dev/api/planets/1/',
    mass: '75',
    skinColor: 'gold',
    films: const [
      'https://swapi.dev/api/films/1/',
      'https://swapi.dev/api/films/2/',
      'https://swapi.dev/api/films/3/',
      'https://swapi.dev/api/films/4/',
      'https://swapi.dev/api/films/5/',
      'https://swapi.dev/api/films/6/',
    ],
    species: const [
      'https://swapi.dev/api/species/2/',
    ],
    vehicles: const [],
    starships: const [],
  ),
];


final List<Planet> planets = [
  Planet(
    name: 'Tatooine',
    image: 'https://lumiere-a.akamaihd.net/v1/images/tatooine-main_9542b896.jpeg',
    rotationPeriod: '23',
    orbitalPeriod: '304',
    diameter: '10465',
    climate: 'arid',
    gravity: '1 standard',
    terrain: 'desert',
    surfaceWater: '1',
    population: '200000',
    residents: const [
      'https://swapi.dev/api/people/1/',
      'https://swapi.dev/api/people/2/',
      'https://swapi.dev/api/people/4/',
      'https://swapi.dev/api/people/6/',
      'https://swapi.dev/api/people/7/',
      'https://swapi.dev/api/people/8/',
      'https://swapi.dev/api/people/9/',
      'https://swapi.dev/api/people/11/',
      'https://swapi.dev/api/people/43/',
      'https://swapi.dev/api/people/62/',
    ],
    films: const [
      'https://swapi.dev/api/films/1/',
      'https://swapi.dev/api/films/3/',
      'https://swapi.dev/api/films/4/',
      'https://swapi.dev/api/films/5/',
      'https://swapi.dev/api/films/6/',
    ],
  ),
  Planet(
    name: 'Alderaan',
    image: 'https://lumiere-a.akamaihd.net/v1/images/alderaan-main_f5b676cf.jpeg',
    rotationPeriod: '24',
    orbitalPeriod: '364',
    diameter: '12500',
    climate: 'temperate',
    gravity: '1 standard',
    terrain: 'grasslands, mountains',
    surfaceWater: '40',
    population: '2000000000',
    residents: const [
      'https://swapi.dev/api/people/5/',
      'https://swapi.dev/api/people/68/',
      'https://swapi.dev/api/people/81/',
    ],
    films: const [
      'https://swapi.dev/api/films/1/',
      'https://swapi.dev/api/films/6/',
    ],
  ),
];

final mockFavorites = FavoritesModel(
  films: films,
  characters: characters,
  planets: planets,
);