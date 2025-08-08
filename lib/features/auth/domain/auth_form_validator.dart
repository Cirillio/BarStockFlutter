import 'failures/incorrect_email_exception.dart';
import 'failures/incorrect_name_exception.dart';
import 'failures/password_length_exception.dart';
import 'failures/passwords_dont_match_exception.dart';

class AuthFormValidator {
  static void validateEmail(String email) {
    if (!RegExp(r'^.+@.+\..+$').hasMatch(email)) {
      throw IncorrectEmailException();
    }
  }

  static void validatePasswordLength(String password) {
    if (password.length < 6) {
      throw PasswordLengthException();
    }
  }

  static void validateName(String name) {
    final bool nameValid =
        name.isNotEmpty ||
        name.length >= 2 ||
        name.length <= 20 ||
        RegExp(r'^[a-zA-Z0-9 ]+$').hasMatch(name);
    if (!nameValid) {
      throw IncorrectNameException();
    }
  }

  static void passwordsMatch(String password, String confirmPassword) {
    if (password != confirmPassword) {
      throw PasswordsDontMatchException();
    }
  }
}
