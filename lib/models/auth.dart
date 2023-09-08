import 'dart:convert';

class Auth {
  Auth({
    required this.email,
    required this.password,
  });

  factory Auth.fromMap(Map<String, dynamic> map) {
    return Auth(
      email: map['email'] as String,
      password: map['password'] as String,
    );
  }

  factory Auth.fromJson(String source) =>
      Auth.fromMap(json.decode(source) as Map<String, dynamic>);

  final String email;
  final String password;

  Auth copyWith({
    String? email,
    String? password,
  }) {
    return Auth(
      email: email ?? this.email,
      password: password ?? this.password,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'email': email,
      'password': password,
    };
  }

  String toJson() => json.encode(toMap());
}
