import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../config/api.dart';
import '../models/attribute.dart';
import '../models/create_character.dart';
import '../models/user_character.dart';
import '../providers/user_character_provider.dart';
import 'shared_local_storage_service.dart';

class UserCharacterService {
  final _baseUrl = '/v1/user/character';
  final _apiService = ApiService();
  final _sharedLocalStorageService = SharedLocalStorageService();

  Future<List<UserCharacter>> getAll(WidgetRef ref) async {
    final response = await _apiService.fetchData<List<dynamic>>(_baseUrl);
    final userCharacters = UserCharacter.listFromJson(response.data!);
    saveUserCharacters(ref, userCharacters);
    return userCharacters;
  }

  Future<UserCharacter> create(CreateCharacter create) async {
    final response = await _apiService.postData<Map<String, dynamic>>(
        _baseUrl, create.toJson());
    return UserCharacter.fromMap(response.data!);
  }

  Future<void> delete(int id) async {
    await _apiService.deleteData<void>('$_baseUrl/$id');
  }

  Future<void> select(WidgetRef ref, UserCharacter userCharacter) async {
    final response = await _apiService
        .fetchData<void>('$_baseUrl/select/${userCharacter.id}');
    final cookie = _apiService.getSetCookieFromHeader(response);
    await _saveCookie(cookie);
    ref.read(userCharacterProvider.notifier).state = userCharacter;
  }

  Future<void> logout() async {
    await _apiService.fetchData<void>('$_baseUrl/logout');
  }

  Future<void> updateAttribute(Attribute attribute) async {
    await _apiService.putData<void>('$_baseUrl/attribute', attribute.toJson());
  }

  Future<UserCharacter> getProfile() async {
    final response =
        await _apiService.fetchData<Map<String, dynamic>>('$_baseUrl/profile');
    return UserCharacter.fromMap(response.data!);
  }

  void saveUserCharacters(WidgetRef ref, List<UserCharacter> userCharacters) {
    ref.read(userCharactersProvider.notifier).state = userCharacters;
  }

  void saveUserCharacter(WidgetRef ref, UserCharacter userCharacter) {
    ref.read(userCharacterProvider.notifier).state = userCharacter;
  }

  Future<void> _saveCookie(String cookie) async {
    await _sharedLocalStorageService.put(
        _sharedLocalStorageService.cookie, cookie);
  }
}
