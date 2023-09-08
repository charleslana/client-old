import 'dart:convert';

class Character {
  Character({
    required this.id,
    required this.name,
    this.description,
    required this.characterClass,
  });

  factory Character.fromMap(Map<String, dynamic> map) {
    return Character(
      id: map['id'] as int,
      name: map['name'] as String,
      description:
          map['description'] != null ? map['description'] as String : null,
      characterClass: map['characterClass'] as String,
    );
  }

  factory Character.fromJson(String source) =>
      Character.fromMap(json.decode(source) as Map<String, dynamic>);

  final int id;
  final String name;
  final String? description;
  final String characterClass;

  Character copyWith({
    int? id,
    String? name,
    String? description,
    String? characterClass,
  }) {
    return Character(
      id: id ?? this.id,
      name: name ?? this.name,
      description: description ?? this.description,
      characterClass: characterClass ?? this.characterClass,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'name': name,
      'description': description,
      'characterClass': characterClass,
    };
  }

  String toJson() => json.encode(toMap());
}
