import '../../domain/entities/user_entity.dart';

class LoginState {
  final String? error;
  final bool isLoading;
  final UserEntity? user;

  const LoginState({this.error, this.isLoading = false, this.user});
  LoginState copyWith({String? error, bool? isLoading, UserEntity? user}) {
    return LoginState(
      error: error == _sentinel ? this.error : error,
      isLoading: isLoading ?? this.isLoading,
      user: user == _sentinelUser ? this.user : user,
    );
  }
}

const _sentinel = Object();
const _sentinelUser = Object();
