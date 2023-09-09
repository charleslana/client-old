import 'dart:convert';

class Register {
  Register({
    required this.email,
    required this.password,
    required this.passwordConfirmation,
    required this.name,
  });

  factory Register.fromMap(Map<String, dynamic> map) {
    return Register(
      email: map['email'] as String,
      password: map['password'] as String,
      passwordConfirmation: map['passwordConfirmation'] as String,
      name: map['name'] as String,
    );
  }

  factory Register.fromJson(String source) =>
      Register.fromMap(json.decode(source) as Map<String, dynamic>);

  final String email;
  final String password;
  final String passwordConfirmation;
  final String name;

  Register copyWith({
    String? email,
    String? password,
    String? passwordConfirmation,
    String? name,
  }) {
    return Register(
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
