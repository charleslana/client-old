import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../config/api.dart';
import '../models/character.dart';
import '../providers/character_provider.dart';

class CharacterService {
  final _baseUrl = '/v1/character';
  final _apiService = ApiService();

  Future<List<Character>> getAll() async {
    final response = await _apiService.fetchData<List<dynamic>>(_baseUrl);
    return Character.listFromJson(response.data!);
  }

  void saveCharacters(WidgetRef ref, List<Character> characters) {
    ref.read(charactersProvider.notifier).state = characters;
  }
}
