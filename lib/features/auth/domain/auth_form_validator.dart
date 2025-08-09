import 'failures/incorrect_email_exception.dart';
import 'failures/incorrect_name_exception.dart';
import 'failures/password_length_exception.dart';
import 'failures/passwords_dont_match_exception.dart';

/// A utility class for validating authentication form inputs.
///
/// This class provides static methods to validate user input fields such as
/// email, password, name, and password confirmation. Each validation method
/// throws a specific exception from the `failures` package if the input
/// does not meet the required rules.
class AuthFormValidator {
  // Simple but effective email pattern (not RFC-compliant, filters obvious garbage)
  static final RegExp _emailRx = RegExp(r'^[^\s@]+@[^\s@]+\.[^\s@]+$');

  // Allows Latin letters, digits, and spaces (extend for other alphabets if needed)
  static final RegExp _nameRx = RegExp(r'^[a-zA-Z0-9 ]+$');

  static const int _minPasswordLength = 6;
  static const int _minNameLength = 2;
  static const int _maxNameLength = 20;

  /// Validates the given [email].
  ///
  /// Trims whitespace before validation and checks against a simple regex pattern.
  /// Throws an [IncorrectEmailException] if the email is invalid.
  static void validateEmail(String email) {
    final v = email.trim();
    if (!_emailRx.hasMatch(v)) {
      throw IncorrectEmailException();
    }
  }

  /// Validates the length of the given [password].
  ///
  /// Trims whitespace before validation and ensures the password length is at
  /// least [_minPasswordLength] characters.
  /// Throws a [PasswordLengthException] if the password is too short.
  static void validatePasswordLength(String password) {
    final v = password.trim();
    if (v.length < _minPasswordLength) {
      throw PasswordLengthException();
    }
  }

  /// Validates the given [name].
  ///
  /// Trims whitespace before validation and ensures the name:
  /// - is not empty
  /// - is between [_minNameLength] and [_maxNameLength] characters
  /// - contains only Latin letters, digits, and spaces
  /// Throws an [IncorrectNameException] if the name is invalid.
  static void validateName(String name) {
    final v = name.trim();
    final bool nameValid =
        v.isNotEmpty &&
        v.length >= _minNameLength &&
        v.length <= _maxNameLength &&
        _nameRx.hasMatch(v);

    if (!nameValid) {
      throw IncorrectNameException();
    }
  }

  /// Checks if the given [password] and [confirmPassword] match.
  ///
  /// Trims whitespace before comparison.
  /// Throws a [PasswordsDontMatchException] if they do not match.
  static void passwordsMatch(String password, String confirmPassword) {
    if (password.trim() != confirmPassword.trim()) {
      throw PasswordsDontMatchException();
    }
  }
}
