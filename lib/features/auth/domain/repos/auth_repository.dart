import '../entities/user_entity.dart';
import '../result.dart';

abstract class AuthRepository {
  Future<Result<UserEntity>> signIn(String email, String password);
  Future<Result<UserEntity>> signUp(String name, String email, String password);
  Future<Result<void>> signOut();
  Future<Result<UserEntity?>> getCurrentUser();
}
