import '../config/api.dart';

class PublicService {
  final _baseUrl = '/v1/public';

  Future<String?> getVersion() async {
    final response = await dio.get<String>('$_baseUrl/version');
    return response.data;
  }
}
