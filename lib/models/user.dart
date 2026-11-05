class User {
  final String name;
  final String password;

  const User({
    required this.name,
    required this.password,
  });

  factory User.fromMap(Map map) {
    return User(
      name: map['name'] ?? '',
      password: map['password'] ?? '',
    );
  }

  Map<String, dynamic> toMap() => {'name': name, 'password': password};
}