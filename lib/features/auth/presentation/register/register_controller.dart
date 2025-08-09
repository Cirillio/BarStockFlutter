import './register_state.dart';
import 'package:bar_stock/features/auth/domain/use_cases/sign_up_use_case.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../domain/result.dart';
import '../../domain/auth_form_validator.dart';
import 'package:bar_stock/core/constants/state_status.dart';

class RegisterController extends StateNotifier<RegisterState> {
  SignUpUseCase signUpUseCase;

  RegisterController(this.signUpUseCase) : super(const RegisterState());

  Future<void> register(
    String name,
    String email,
    String pass,
    String pass2,
  ) async {
    try {
      AuthFormValidator.validateName(name);
      AuthFormValidator.validateEmail(email);
      AuthFormValidator.validatePasswordLength(pass);
      AuthFormValidator.passwordsMatch(pass, pass2);
    } catch (e) {
      state = state.copyWith(status: StateStatus.error, error: e.toString());
      return;
    }

    state = state.copyWith(status: StateStatus.submitting, error: null);

    final result = await signUpUseCase.call(name, email, pass);

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
