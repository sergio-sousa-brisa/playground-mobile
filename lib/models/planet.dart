class Planet {
  final String name;
  final String image;
  final String climate;
  final String diameter;
  final String gravity;
  final String orbitalPeriod;
  final String population;
  final String rotationPeriod;
  final String surfaceWater;
  final String terrain;
  final List<String> films;
  final List<String> residents;

  factory Planet.fromJson(Map<String, dynamic> json) {
    return Planet(
      name: json['name'] as String,
      image: json['image'] as String? ?? '',
      climate: json['climate'] as String,
      diameter: json['diameter'] as String,
      gravity: json['gravity'] as String,
      orbitalPeriod: json['orbital_period'] as String,
      population: json['population'] as String,
      rotationPeriod: json['rotation_period'] as String,
      surfaceWater: json['surface_water'] as String,
      terrain: json['terrain'] as String,
      films: List<String>.from(json['films'] as List),
      residents: List<String>.from(json['residents'] as List),
    );
  }

  const Planet({
    required this.name,
    required this.image,
    required this.climate,
    required this.diameter,
    required this.gravity,
    required this.orbitalPeriod,
    required this.population,
    required this.rotationPeriod,
    required this.surfaceWater,
    required this.terrain,
    required this.films,
    required this.residents,
  });

  Planet copyWith({
    String? name,
    String? image,
    String? climate,
    String? diameter,
    String? gravity,
    String? orbitalPeriod,
    String? population,
    String? rotationPeriod,
    String? surfaceWater,
    String? terrain,
    List<String>? films,
    List<String>? residents,
  }) {
    return Planet(
      name: name ?? this.name,
      image: image ?? this.image,
      climate: climate ?? this.climate,
      diameter: diameter ?? this.diameter,
      gravity: gravity ?? this.gravity,
      orbitalPeriod: orbitalPeriod ?? this.orbitalPeriod,
      population: population ?? this.population,
      rotationPeriod: rotationPeriod ?? this.rotationPeriod,
      surfaceWater: surfaceWater ?? this.surfaceWater,
      terrain: terrain ?? this.terrain,
      films: films ?? this.films,
      residents: residents ?? this.residents,
    );
  }
}
