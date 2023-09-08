import '../config/api.dart';
import '../models/user.dart';

class UserService {
  final _baseUrl = '/v1/user';
  final _apiService = ApiService();

  Future<void> create(User user) async {
    await _apiService.postData<Object>(_baseUrl, user.toJson());
  }
}
