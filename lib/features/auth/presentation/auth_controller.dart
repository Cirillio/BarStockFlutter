import 'package:bar_stock/features/auth/domain/use_cases/sign_out_use_case.dart';
import 'package:bar_stock/features/auth/domain/failures/incorrect_email_exception.dart';
import 'package:bar_stock/features/auth/domain/failures/password_length_exception.dart';
import 'package:bar_stock/features/auth/domain/use_cases/sign_in_use_case.dart';
import 'package:bar_stock/features/auth/presentation/login/login_state.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../domain/result.dart';
import '../domain/auth_form_validator.dart';
import 'package:bar_stock/core/constants/state_status.dart';

class AuthController extends StateNotifier<LoginState> {
  final SignInUseCase logIn;
  final SignOutUseCase logOut;

  AuthController(this.logIn, this.logOut) : super(const LoginState());

  Future<void> login(String email, String pass) async {
    state = state.copyWith(status: StateStatus.submitting, errors: {});
    Map<LoginField, String?> loginErrors = {};

    try {
      AuthFormValidator.validateEmail(email);
    } on IncorrectEmailException catch (e) {
      loginErrors[LoginField.email] = e.message;
    }

    try {
      AuthFormValidator.validatePasswordLength(pass);
    } on PasswordLengthException catch (e) {
      loginErrors[LoginField.password] = e.message;
    }

    if (loginErrors.isNotEmpty) {
      state = state.copyWith(status: StateStatus.failure, errors: loginErrors);
      return;
    }

    if (state.errors.isNotEmpty) return;

    final result = await logIn.call(email, pass);

    switch (result) {
      case Success():
        state = state.copyWith(status: StateStatus.success, errors: {});
        break;
      case Failure(:final message):
        state = state.copyWith(
          status: StateStatus.failure,
          errors: {LoginField.general: message},
        );
        break;
    }
  }

  Future<void> logout() async {
    await logOut.call();
    state = state.copyWith(status: StateStatus.initial, errors: {});
  }
}
