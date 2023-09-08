import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../config/api.dart';
import '../models/user_character.dart';
import '../providers/user_character_provider.dart';

class UserCharacterService {
  final _baseUrl = '/v1/user/character';
  final _apiService = ApiService();

  Future<List<UserCharacter>> getAll() async {
    final response = await _apiService.fetchData<List<dynamic>>(_baseUrl);
    return UserCharacter.listFromJson(response.data!);
  }

  void saveAuthCharacter(WidgetRef ref, List<UserCharacter> userCharacters) {
    ref.read(userCharactersProvider.notifier).state = userCharacters;
  }
}
