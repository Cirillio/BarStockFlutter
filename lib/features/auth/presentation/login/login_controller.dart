import 'package:bar_stock/features/auth/domain/failures/incorrect_email_exception.dart';
import 'package:bar_stock/features/auth/domain/failures/password_length_exception.dart';
import 'package:bar_stock/features/auth/domain/use_cases/sign_in_use_case.dart';
import './login_state.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../domain/result.dart';
import '../../domain/auth_form_validator.dart';
import 'package:bar_stock/core/constants/state_status.dart';

class LoginController extends StateNotifier<LoginState> {
  final SignInUseCase signInUseCase;

  LoginController(this.signInUseCase) : super(const LoginState());

  Future<void> login(String email, String pass) async {
    try {
      AuthFormValidator.validateEmail(email);
      AuthFormValidator.validatePasswordLength(pass);
    } on IncorrectEmailException catch (e) {
      state = state.copyWith(status: StateStatus.error, error: e.message);
      return;
    } on PasswordLengthException catch (e) {
      state = state.copyWith(status: StateStatus.error, error: e.message);
      return;
    } catch (e) {
      state = state.copyWith(status: StateStatus.error, error: e.toString());
      return;
    }

    state = state.copyWith(status: StateStatus.submitting, error: null);

    final result = await signInUseCase.call(email, pass);

    switch (result) {
      case Success():
        state = state.copyWith(status: StateStatus.success, error: null);
        break;
      case Failure(:final message):
        state = state.copyWith(status: StateStatus.error, error: message);
        break;
    }
  }
}
