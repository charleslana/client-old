import 'dart:convert';

import '../enums/character_class_enum.dart';

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
      characterClass: CharacterClassEnum.values.byName(map['characterClass']),
    );
  }

  factory Character.fromJson(String source) =>
      Character.fromMap(json.decode(source) as Map<String, dynamic>);

  static List<Character> listFromJson(List<dynamic> list) =>
      List<Character>.from(
          // ignore: unnecessary_lambdas
          list.map((dynamic e) => Character.fromMap(e)));

  final int id;
  final String name;
  final String? description;
  final CharacterClassEnum characterClass;

  Character copyWith({
    int? id,
    String? name,
    String? description,
    CharacterClassEnum? characterClass,
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
      'characterClass': characterClass.name,
    };
  }

  String toJson() => json.encode(toMap());
}
