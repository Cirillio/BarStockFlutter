import 'package:bar_stock/features/auth/domain/use_cases/sign_in_use_case.dart';
import './login_state.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../domain/result.dart';

class LoginController extends StateNotifier<LoginState> {
  final SignInUseCase signInUseCase;

  LoginController(this.signInUseCase) : super(const LoginState());

  Future<void> login(String email, String pass) async {
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
