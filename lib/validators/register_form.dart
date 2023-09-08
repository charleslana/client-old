import 'validator_utils.dart';

class RegisterValidator {
  RegisterValidator._();

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
    if (value.length < 6) {
      return 'A senha deve ter pelo menos 6 caracteres';
    }
    return null;
  }

  static String? validatePasswordConfirmation(
      String password, String? confirmation) {
    if (confirmation != null && confirmation.isEmpty) {
      return 'Campo de confirmação de senha é obrigatório';
    }
    if (confirmation != password) {
      return 'A senha e a confirmação não coincidem';
    }
    return null;
  }

  static String? validateName(String? value) {
    if (value == null) {
      return 'Campo de nome é obrigatório';
    }
    if (value.trim().isEmpty) {
      return 'Campo de nome é obrigatório';
    }
    if (value.trim().length < 3 || value.trim().length > 30) {
      return 'O nome deve conter entre 3 e 30 caracteres';
    }
    if (!isValidName(value.trim())) {
      return 'O nome deve conter apenas letras, números, espaços e underscores';
    }
    return null;
  }
}
