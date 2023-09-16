import 'dart:convert';

import '../enums/gender_enum.dart';
import 'character.dart';
import 'user_character_group.dart';

class UserCharacter {
  UserCharacter({
    required this.id,
    required this.name,
    required this.level,
    required this.strength,
    required this.intelligence,
    required this.dexterity,
    required this.point,
    this.spentPoint,
    required this.gold,
    required this.experience,
    required this.gender,
    required this.createdAt,
    required this.character,
    this.groupMember,
  });

  factory UserCharacter.fromMap(Map<String, dynamic> map) {
    return UserCharacter(
      id: map['id'] as int,
      name: map['name'] as String,
      level: map['level'] as int,
      strength: map['strength'] as int,
      intelligence: map['intelligence'] as int,
      dexterity: map['dexterity'] as int,
      point: map['point'] as int,
      spentPoint: map['spentPoint'] != null ? map['spentPoint'] as int : null,
      gold: map['gold'] as int,
      experience: map['experience'] as int,
      gender: GenderEnum.values.byName(map['gender']),
      createdAt: DateTime.parse(map['createdAt']),
      character: Character.fromMap(map['character'] as Map<String, dynamic>),
      groupMember: map['groupMember'] != null
          ? UserCharacterGroup.fromMap(
              map['groupMember'] as Map<String, dynamic>)
          : null,
    );
  }

  factory UserCharacter.fromJson(String source) =>
      UserCharacter.fromMap(json.decode(source) as Map<String, dynamic>);

  static List<UserCharacter> listFromJson(List<dynamic> list) =>
      List<UserCharacter>.from(
          // ignore: unnecessary_lambdas
          list.map((dynamic e) => UserCharacter.fromMap(e)));

  final int id;
  final String name;
  final int level;
  final int strength;
  final int intelligence;
  final int dexterity;
  final int point;
  final int? spentPoint;
  final int gold;
  final int experience;
  final GenderEnum gender;
  final DateTime createdAt;
  final Character character;
  final UserCharacterGroup? groupMember;

  UserCharacter copyWith({
    int? id,
    String? name,
    int? level,
    int? strength,
    int? intelligence,
    int? dexterity,
    int? point,
    int? spentPoint,
    int? gold,
    int? experience,
    GenderEnum? gender,
    DateTime? createdAt,
    Character? character,
    UserCharacterGroup? groupMember,
  }) {
    return UserCharacter(
      id: id ?? this.id,
      name: name ?? this.name,
      level: level ?? this.level,
      strength: strength ?? this.strength,
      intelligence: intelligence ?? this.intelligence,
      dexterity: dexterity ?? this.dexterity,
      point: point ?? this.point,
      spentPoint: spentPoint ?? this.spentPoint,
      gold: gold ?? this.gold,
      experience: experience ?? this.experience,
      gender: gender ?? this.gender,
      createdAt: createdAt ?? this.createdAt,
      character: character ?? this.character,
      groupMember: groupMember ?? this.groupMember,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'name': name,
      'level': level,
      'strength': strength,
      'intelligence': intelligence,
      'dexterity': dexterity,
      'point': point,
      'spentPoint': spentPoint,
      'gold': gold,
      'experience': experience,
      'gender': gender.name,
      'createdAt': createdAt.toIso8601String(),
      'character': character.toMap(),
      'groupMember': groupMember?.toMap(),
    };
  }

  String toJson() => json.encode(toMap());
}
