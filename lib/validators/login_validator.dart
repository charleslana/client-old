import 'validator_utils.dart';

class LoginValidator {
  LoginValidator._();

  static String? validateEmail(String? value) {
    if (value == null) {
      return 'Campo de email é obrigatório';
    }
    if (value.isEmpty) {
      return 'Campo de email é obrigatório';
    }
    if (!isValidEmail(value)) {
      return 'Email inválido';
    }
    return null;
  }

  static String? validatePassword(String? value) {
    if (value == null) {
      return 'Campo de senha é obrigatório';
    }
    if (value.isEmpty) {
      return 'Campo de senha é obrigatório';
    }
    return null;
  }
}
