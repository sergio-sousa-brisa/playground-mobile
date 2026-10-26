class Character {
  final String name;
  final String image;
  final String birthYear;
  final String eyeColor;
  final String gender;
  final String hairColor;
  final String height;
  final String homeworld;
  final String mass;
  final String skinColor;
  final List<String> films;
  final List<String> species;
  final List<String> starships;
  final List<String> vehicles;

  factory Character.fromJson(Map<String, dynamic> json) {
    return Character(
      name: json['name'] as String,
      image: json['image'] as String? ?? '',
      birthYear: json['birth_year'] as String,
      eyeColor: json['eye_color'] as String,
      gender: json['gender'] as String,
      hairColor: json['hair_color'] as String,
      height: json['height'] as String,
      homeworld: json['homeworld'] as String,
      mass: json['mass'] as String,
      skinColor: json['skin_color'] as String,
      films: List<String>.from(json['films'] as List),
      species: List<String>.from(json['species'] as List),
      starships: List<String>.from(json['starships'] as List),
      vehicles: List<String>.from(json['vehicles'] as List),
    );
  }

  const Character({
    required this.name,
    required this.image,
    required this.birthYear,
    required this.eyeColor,
    required this.gender,
    required this.hairColor,
    required this.height,
    required this.homeworld,
    required this.mass,
    required this.skinColor,
    required this.films,
    required this.species,
    required this.starships,
    required this.vehicles,
  });
}