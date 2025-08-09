import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import '../../features/auth/domain/use_cases/get_current_user_use_case.dart';
import '../../features/auth/domain/use_cases/sign_in_use_case.dart';
import '../../features/auth/domain/use_cases/sign_out_use_case.dart';
import '../../features/auth/domain/use_cases/sign_up_use_case.dart';
import '../../features/auth/domain/repos/auth_repository.dart';
import '../../features/auth/data/auth_data_source.dart';
import '../../features/auth/data/auth_repository_impl.dart';
import '../../features/auth/presentation/login/login_controller.dart';
import '../../features/auth/presentation/login/login_state.dart';

final supabaseClientProvider = Provider<SupabaseClient>(
  (ref) => Supabase.instance.client,
);

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

final getCurrentUserUseCaseProvider = Provider<GetCurrentUserUseCase>(
  (ref) => GetCurrentUserUseCase(authRepo: ref.read(authRepositoryProvider)),
);

final loginControllerProvider =
    StateNotifierProvider<LoginController, LoginState>(
      (ref) => LoginController(ref.read(signInUseCaseProvider)),
    );
