import 'package:bar_stock/core/constants/state_status.dart';

class RegisterState {
  final String? error;
  final StateStatus status;

  const RegisterState({this.error, this.status = StateStatus.initial});

  RegisterState copyWith({String? error, StateStatus? status}) {
    return RegisterState(
      error: error ?? this.error,
      status: status ?? this.status,
    );
  }
}
