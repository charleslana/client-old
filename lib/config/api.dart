import 'dart:io';

import 'package:dio/dio.dart';

class ApiService {
  ApiService()
      : dio = Dio(BaseOptions(
          baseUrl: 'http://localhost:3000',
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

  final Dio dio;

  void _setupInterceptors() {
    dio.interceptors.add(AppInterceptors());
  }

  Future<Response<T>> fetchData<T>(String endpoint) async {
    return dio.get<T>(endpoint);
  }

  Future<Response<T>> postData<T>(String endpoint, dynamic data) async {
    return dio.post<T>(endpoint, data: data);
  }

  Future<Response<T>> putData<T>(String endpoint, dynamic data) async {
    return dio.put<T>(endpoint, data: data);
  }

  Future<Response<T>> deleteData<T>(String endpoint) async {
    return dio.delete<T>(endpoint);
  }
}

class AppInterceptors extends Interceptor {
  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) {
    const bearerToken = '';
    options.headers['Authorization'] = 'Bearer $bearerToken';
    super.onRequest(options, handler);
  }
}
