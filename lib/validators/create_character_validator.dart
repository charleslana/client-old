import 'validator_utils.dart';

class CreateCharacterValidator {
  CreateCharacterValidator._();

  static String? validateName(String? value) {
    if (value == null) {
      return 'Campo de nome é obrigatório';
    }
    if (value.trim().isEmpty) {
      return 'Campo de nome é obrigatório';
    }
    if (value.trim().length < 3 || value.trim().length > 20) {
      return 'O nome deve conter entre 3 e 20 caracteres';
    }
    if (!isValidName(value.trim())) {
      return 'O nome deve conter apenas letras, números, espaços e underscores';
    }
    return null;
  }
}
