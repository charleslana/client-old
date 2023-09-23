import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../config/api.dart';
import '../models/user_character_item.dart';
import '../providers/user_character_item_provider.dart';

class UserCharacterItemService {
  final _baseUrl = '/v1/user/character/item';
  final _apiService = ApiService();

  Future<List<UserCharacterItem>> getAll(WidgetRef ref) async {
    final response = await _apiService.fetchData<List<dynamic>>(_baseUrl);
    final userCharacterItems = UserCharacterItem.listFromJson(response.data!);
    saveUserCharacterItems(ref, userCharacterItems);
    return userCharacterItems;
  }

  void saveUserCharacterItems(
      WidgetRef ref, List<UserCharacterItem> userCharacterItems) {
    ref.read(userCharacterItemsProvider.notifier).state = userCharacterItems;
  }
}
