import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../models/user.dart';

final userProvider = StateProvider<User>((ref) {
  return User(email: '', name: '', diamond: 0);
});
