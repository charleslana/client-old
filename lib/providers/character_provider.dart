import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../models/character.dart';

final charactersProvider = StateProvider<List<Character>>((ref) {
  return <Character>[];
});
