import 'package:bar_stock/features/auth/domain/repos/auth_repository.dart';
import '../result.dart';
import '../entities/user_entity.dart';

class GetCurrentUserUseCase {
  final AuthRepository authRepo;

  const GetCurrentUserUseCase({required this.authRepo});

  Future<Result<UserEntity?>> call() {
    return authRepo.getCurrentUser();
  }
}
