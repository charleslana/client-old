import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../config/api.dart';
import '../models/auth.dart';
import '../models/token.dart';
import '../models/user.dart';
import '../providers/auth_provider.dart';
import 'shared_local_storage_service.dart';

class UserService {
  final _baseUrl = '/v1/user';
  final _apiService = ApiService();
  final _sharedLocalStorageService = SharedLocalStorageService();

  Future<void> create(User user) async {
    await _apiService.postData<Object>(_baseUrl, user.toJson());
  }

  Future<Token> auth(Auth auth) async {
    final response = await _apiService.postData<Map<String, dynamic>>(
        '$_baseUrl/auth', auth.toJson());
    final getAuth = Token.fromMap(response.data!)
      ..cookie = _apiService.getSetCookieFromHeader(response);
    return getAuth;
  }

  Future<void> saveAuth(Auth auth, Token token, WidgetRef ref) async {
    await _sharedLocalStorageService.put(
        _sharedLocalStorageService.email, auth.email);
    await _sharedLocalStorageService.put(
        _sharedLocalStorageService.password, auth.password);
    await _sharedLocalStorageService.put(
        _sharedLocalStorageService.token, token.token);
    await _sharedLocalStorageService.put(
        _sharedLocalStorageService.cookie, token.cookie);
    ref.read(authProvider.notifier).state = true;
  }

  Future<void> logout(WidgetRef ref) async {
    await _sharedLocalStorageService.delete(_sharedLocalStorageService.email);
    await _sharedLocalStorageService
        .delete(_sharedLocalStorageService.password);
    await _sharedLocalStorageService.delete(_sharedLocalStorageService.cookie);
    await _sharedLocalStorageService.delete(_sharedLocalStorageService.token);
    ref.read(authProvider.notifier).state = false;
  }

  Future<Auth> getAuth() async {
    final email = await _sharedLocalStorageService
        .get<String>(_sharedLocalStorageService.email);
    final password = await _sharedLocalStorageService
        .get<String>(_sharedLocalStorageService.password);
    if (email != null && password != null) {
      return Auth(email: email, password: password);
    }
    return Future.error('Falha na autenticação');
  }
}
