import 'dart:convert';

import '../enums/gender_enum.dart';

class CreateCharacter {
  CreateCharacter({
    required this.characterId,
    required this.name,
    required this.gender,
  });

  factory CreateCharacter.fromMap(Map<String, dynamic> map) {
    return CreateCharacter(
      characterId: map['characterId'] as int,
      name: map['name'] as String,
      gender: GenderEnum.values.byName(map['gender']),
    );
  }

  factory CreateCharacter.fromJson(String source) =>
      CreateCharacter.fromMap(json.decode(source) as Map<String, dynamic>);

  final int characterId;
  final String name;
  final GenderEnum gender;

  CreateCharacter copyWith({
    int? characterId,
    String? name,
    GenderEnum? gender,
  }) {
    return CreateCharacter(
      characterId: characterId ?? this.characterId,
      name: name ?? this.name,
      gender: gender ?? this.gender,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'characterId': characterId,
      'name': name,
      'gender': gender.name,
    };
  }

  String toJson() => json.encode(toMap());
}
