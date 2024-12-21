// Method to validate email format
bool isEmailValid(String email) {
  final emailRegex =
      RegExp(r'^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$');
  return emailRegex.hasMatch(email);
}

// Method to check if passwords match
bool doPasswordsMatch(String password, String confirmPassword) {
  return password == confirmPassword;
}
