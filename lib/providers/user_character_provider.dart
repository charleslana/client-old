import 'package:client/models/character.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../enums/character_class_enum.dart';
import '../enums/gender_enum.dart';
import '../models/user_character.dart';

final userCharactersProvider = StateProvider<List<UserCharacter>>((ref) {
  return <UserCharacter>[];
});

final userCharacterProvider = StateProvider<UserCharacter>((ref) {
  return UserCharacter(
    id: 0,
    name: '',
    level: 0,
    strength: 0,
    intelligence: 0,
    dexterity: 0,
    point: 0,
    gold: 0,
    experience: 0,
    gender: GenderEnum.male,
    createdAt: DateTime.now(),
    character: Character(
      id: 0,
      name: '',
      characterClass: CharacterClassEnum.warrior,
    ),
  );
});
