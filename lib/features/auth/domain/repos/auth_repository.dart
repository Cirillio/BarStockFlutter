import '../result.dart';

abstract class AuthRepository {
  Future<Result<void>> signIn(String email, String password);
  Future<Result<void>> signUp(String name, String email, String password);
  Future<Result<void>> signOut();
}
