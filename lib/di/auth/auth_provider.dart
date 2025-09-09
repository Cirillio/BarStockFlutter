import 'package:bar_stock/features/auth/data/auth_data_source.dart';
import 'package:bar_stock/features/auth/data/auth_repository_impl.dart';
import 'package:bar_stock/features/auth/domain/repos/auth_repository.dart';
import 'package:bar_stock/features/auth/domain/use_cases/sign_in_use_case.dart';
import 'package:bar_stock/features/auth/domain/use_cases/sign_out_use_case.dart';
import 'package:bar_stock/features/auth/domain/use_cases/sign_up_use_case.dart';
import 'package:bar_stock/features/auth/presentation/auth_controller.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:bar_stock/di/supabase.dart';

import 'package:bar_stock/features/auth/presentation/login/login_state.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

final authDataSourceProvider = Provider<AuthDataSource>(
  (ref) => AuthDataSource(ref.read(supabaseClientProvider)),
);

final authRepositoryProvider = Provider<AuthRepository>(
  (ref) => AuthRepositoryImpl(ref.read(authDataSourceProvider)),
);

final signInUseCaseProvider = Provider<SignInUseCase>(
  (ref) => SignInUseCase(authRepo: ref.read(authRepositoryProvider)),
);

final signUpUseCaseProvider = Provider<SignUpUseCase>(
  (ref) => SignUpUseCase(authRepo: ref.read(authRepositoryProvider)),
);

final signOutUseCaseProvider = Provider<SignOutUseCase>(
  (ref) => SignOutUseCase(authRepo: ref.read(authRepositoryProvider)),
);

final authControllerProvider =
    StateNotifierProvider<AuthController, LoginState>(
      (ref) => AuthController(
        ref.read(signInUseCaseProvider),
        ref.read(signOutUseCaseProvider),
      ),
    );

final authStateProvider = StreamProvider<AuthState>((ref) {
  return Supabase.instance.client.auth.onAuthStateChange;
});
