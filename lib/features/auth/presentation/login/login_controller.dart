import 'package:bar_stock/features/auth/domain/use_cases/sign_in_use_case.dart';
import './login_state.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../domain/result.dart';
import '../../domain/auth_form_validator.dart';

class LoginController extends StateNotifier<LoginState> {
  final SignInUseCase signInUseCase;

  LoginController(this.signInUseCase) : super(const LoginState());

  Future<void> login(String email, String pass) async {
    try {
      AuthFormValidator.validateEmail(email);
      AuthFormValidator.validatePasswordLength(pass);
    } catch (e) {
      state = state.copyWith(isLoading: false, error: e.toString());
      return;
    }

    state = state.copyWith(isLoading: true, error: null);

    final result = await signInUseCase.call(email, pass);

    switch (result) {
      case Success(:final data):
        state = state.copyWith(isLoading: false, user: data);
        break;
      case Failure(:final message):
        state = state.copyWith(isLoading: false, error: message);
        break;
    }
  }
}
