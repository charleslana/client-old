import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../models/user_character.dart';

final userCharactersProvider = StateProvider<List<UserCharacter>>((ref) {
  return <UserCharacter>[];
});
