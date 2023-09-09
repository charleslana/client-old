import 'dart:io';

import 'package:dio/dio.dart';

import '../services/auth_service.dart';

class ApiService {
  ApiService()
      : _dio = Dio(BaseOptions(
          baseUrl: 'http://192.168.0.102:3000',
          connectTimeout: const Duration(seconds: 5),
          receiveTimeout: const Duration(seconds: 5),
          headers: {
            HttpHeaders.userAgentHeader: 'dio',
            'api': '1.0.0',
          },
          contentType: Headers.jsonContentType,
        )) {
    _setupInterceptors();
  }

  final Dio _dio;

  void _setupInterceptors() {
    _dio.interceptors.add(AppInterceptors());
  }

  Future<Response<T>> fetchData<T>(String endpoint) async {
    return _dio.get<T>(endpoint);
  }

  Future<Response<T>> postData<T>(String endpoint, dynamic data) async {
    return _dio.post<T>(endpoint, data: data);
  }

  Future<Response<T>> putData<T>(String endpoint, dynamic data) async {
    return _dio.put<T>(endpoint, data: data);
  }

  Future<Response<T>> deleteData<T>(String endpoint) async {
    return _dio.delete<T>(endpoint);
  }

  String getSetCookieFromHeader(Response<dynamic> response) {
    final rawCookie = response.headers['set-cookie'];
    final cookie = rawCookie?.first;
    if (cookie != null) {
      final int index = cookie.indexOf(';');
      return (index == -1) ? cookie : cookie.substring(0, index);
    }
    return '';
  }
}

class AppInterceptors extends Interceptor {
  @override
  Future<void> onRequest(
      RequestOptions options, RequestInterceptorHandler handler) async {
    final authService = AuthService();
    final authOptions = await authService.getAuthOptions();
    final newOptions = options.copyWith(
      headers: {...options.headers, ...authOptions.headers!},
    );
    super.onRequest(newOptions, handler);
  }
}
