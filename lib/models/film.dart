class Film {
  final String title;
  final String openingCrawl;
  final String director;
  final String producer;
  final String image;
  final DateTime releaseDate;
  final List<String> species;
  final List<String> starships;
  final List<String> vehicles;
  final List<String> characters;
  final List<String> planets;

  factory Film.fromJson(Map<String, dynamic> json) {
    return Film(
      title: json['title'] as String,
      openingCrawl: json['opening_crawl'] as String,
      director: json['director'] as String,
      producer: json['producer'] as String,
      releaseDate: DateTime.parse(json['release_date'] as String),
      species: List<String>.from(json['species'] as List),
      starships: List<String>.from(json['starships'] as List),
      vehicles: List<String>.from(json['vehicles'] as List),
      characters: List<String>.from(json['characters'] as List),
      planets: List<String>.from(json['planets'] as List),
    );
  }

  const Film({
    required this.title,
    required this.openingCrawl,
    required this.director,
    required this.producer,
    required this.releaseDate,
    required this.species,
    required this.starships,
    required this.vehicles,
    required this.characters,
    required this.planets,
    this.image='',
  });
}
