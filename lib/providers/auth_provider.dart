import 'package:flutter_riverpod/flutter_riverpod.dart';

final authProvider = StateProvider<bool>((ref) {
  // Verifique aqui se o usuário está autenticado e retorne true ou false.
  // Você pode usar SharedPreferences, Firebase Auth, ou qualquer outro método de autenticação.
  return false; // Por padrão, não autenticado.
});
