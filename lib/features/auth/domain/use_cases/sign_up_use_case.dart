import 'package:bar_stock/features/auth/domain/repos/auth_repository.dart';
import '../../../../core/utils/result.dart';

class SignUpUseCase {
  final AuthRepository authRepo;

  const SignUpUseCase({required this.authRepo});

  Future<Result<void>> call(String name, String email, String pass) {
    return authRepo.signUp(name, email, pass);
  }
}
