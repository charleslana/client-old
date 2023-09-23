import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../models/user_character_item.dart';

final userCharacterItemsProvider =
    StateProvider<List<UserCharacterItem>>((ref) {
  return <UserCharacterItem>[];
});
