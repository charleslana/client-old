bool isValidEmail(String email) {
  final emailRegex = RegExp(
    r'^[\w-]+(\.[\w-]+)*@([\w-]+\.)+[a-zA-Z]{2,7}$',
  );
  return emailRegex.hasMatch(email);
}

bool isValidName(String name) {
  final nameRegex = RegExp(
    r'^[a-zA-ZÀ-ú0-9_ ]*$',
  );
  return nameRegex.hasMatch(name);
}
