import 'package:bar_stock/features/auth/domain/repos/auth_repository.dart';
import '../result.dart';

class SignOutUseCase {
  final AuthRepository authRepo;

  const SignOutUseCase({required this.authRepo});

  Future<Result<void>> call() {
    return authRepo.signOut();
  }
}
