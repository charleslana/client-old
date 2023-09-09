import 'dart:convert';

class User {
  User({
    required this.email,
    required this.name,
    required this.diamond,
  });

  factory User.fromMap(Map<String, dynamic> map) {
    return User(
      email: map['email'] as String,
      name: map['name'] as String,
      diamond: map['diamond'] as int,
    );
  }

  factory User.fromJson(String source) =>
      User.fromMap(json.decode(source) as Map<String, dynamic>);

  final String email;
  final String name;
  final int diamond;

  User copyWith({
    String? email,
    String? name,
    int? diamond,
  }) {
    return User(
      email: email ?? this.email,
      name: name ?? this.name,
      diamond: diamond ?? this.diamond,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'email': email,
      'name': name,
      'diamond': diamond,
    };
  }

  String toJson() => json.encode(toMap());
}
