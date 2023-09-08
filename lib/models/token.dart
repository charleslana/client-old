import 'dart:convert';

class Token {
  Token({
    required this.token,
    this.cookie,
  });

  factory Token.fromMap(Map<String, dynamic> map) {
    return Token(
      token: map['token'] as String,
      cookie: map['cookie'] != null ? map['cookie'] as String : null,
    );
  }

  factory Token.fromJson(String source) =>
      Token.fromMap(json.decode(source) as Map<String, dynamic>);

  final String token;
  String? cookie;

  Token copyWith({
    String? token,
    String? cookie,
  }) {
    return Token(
      token: token ?? this.token,
      cookie: cookie ?? this.cookie,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'token': token,
      'cookie': cookie,
    };
  }

  String toJson() => json.encode(toMap());
}
