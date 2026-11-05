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

  Character copyWith({
    String? name,
    String? image,
    String? birthYear,
    String? eyeColor,
    String? gender,
    String? hairColor,
    String? height,
    String? homeworld,
    String? mass,
    String? skinColor,
    List<String>? films,
    List<String>? species,
    List<String>? starships,
    List<String>? vehicles,
  }) {
    return Character(
      name: name ?? this.name,
      image: image ?? this.image,
      birthYear: birthYear ?? this.birthYear,
      eyeColor: eyeColor ?? this.eyeColor,
      gender: gender ?? this.gender,
      hairColor: hairColor ?? this.hairColor,
      height: height ?? this.height,
      homeworld: homeworld ?? this.homeworld,
      mass: mass ?? this.mass,
      skinColor: skinColor ?? this.skinColor,
      films: films ?? this.films,
      species: species ?? this.species,
      starships: starships ?? this.starships,
      vehicles: vehicles ?? this.vehicles,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'image': image,
      'birth_year': birthYear,
      'eye_color': eyeColor,
      'gender': gender,
      'hair_color': hairColor,
      'height': height,
      'homeworld': homeworld,
      'mass': mass,
      'skin_color': skinColor,
      'films': films,
      'species': species,
      'starships': starships,
      'vehicles': vehicles,
    };
  }
}
