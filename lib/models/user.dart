import 'dart:convert';

class User {
  User({
    required this.email,
    required this.password,
    required this.passwordConfirmation,
    required this.name,
  });

  factory User.fromMap(Map<String, dynamic> map) {
    return User(
      email: map['email'] as String,
      password: map['password'] as String,
      passwordConfirmation: map['passwordConfirmation'] as String,
      name: map['name'] as String,
    );
  }

  factory User.fromJson(String source) =>
      User.fromMap(json.decode(source) as Map<String, dynamic>);

  final String email;
  final String password;
  final String passwordConfirmation;
  final String name;

  User copyWith({
    String? email,
    String? password,
    String? passwordConfirmation,
    String? name,
  }) {
    return User(
      email: email ?? this.email,
      password: password ?? this.password,
      passwordConfirmation: passwordConfirmation ?? this.passwordConfirmation,
      name: name ?? this.name,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'email': email,
      'password': password,
      'passwordConfirmation': passwordConfirmation,
      'name': name,
    };
  }

  String toJson() => json.encode(toMap());
}
