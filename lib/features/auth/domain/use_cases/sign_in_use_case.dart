import 'package:bar_stock/features/auth/domain/repos/auth_repository.dart';
import '../result.dart';

/// A use case for signing in a user.
///
/// This class handles the interaction with the [AuthRepository] to
/// sign in a user with the provided email and password.
class SignInUseCase {
  /// The authentication repository that handles the actual sign-in process.
  final AuthRepository authRepo;

  /// Creates a [SignInUseCase] with the given [authRepo].
  const SignInUseCase({required this.authRepo});

  /// Attempts to sign in a user using the provided [email] and [pass].
  ///
  /// Returns a [Result] containing a [UserEntity] on success, or an error
  /// message on failure.
  Future<Result<void>> call(String email, String pass) {
    return authRepo.signIn(email, pass);
  }
}
