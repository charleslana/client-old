import '../config/api.dart';

class PublicService {
  final _baseUrl = '/v1/public';
  final _apiService = ApiService();

  Future<String?> getVersion() async {
    final response = await _apiService.fetchData<String>('$_baseUrl/version');
    return response.data;
  }
}
