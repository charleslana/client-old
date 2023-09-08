import 'package:dio/dio.dart';

import 'shared_local_storage_service.dart';

class AuthService {
  final _sharedLocalStorageService = SharedLocalStorageService();

  Future<Options> getAuthOptions() async {
    final cookie = await _getCookie();
    final token = await _getToken();
    return Options(
      headers: {
        'Authorization': 'Bearer $token',
        'cookie': cookie,
      },
    );
  }

  Future<String> _getCookie() async {
    final cookie = await _sharedLocalStorageService
        .get<String>(_sharedLocalStorageService.cookie);
    return cookie ?? '';
  }

  Future<String> _getToken() async {
    final token = await _sharedLocalStorageService
        .get<String>(_sharedLocalStorageService.token);
    return token ?? '';
  }
}
