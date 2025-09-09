import 'package:bar_stock/core/constants/state_status.dart';
import 'package:bar_stock/features/profile/domain/entities/profile.dart';

class ProfileState {
  final Profile? profile;
  final StateStatus status;
  final String? errorMessage;

  ProfileState({
    this.profile,
    this.status = StateStatus.initial,
    this.errorMessage,
  });

  ProfileState copyWith({
    Profile? profile,
    StateStatus? status,
    String? errorMessage,
  }) {
    return ProfileState(
      profile: profile ?? this.profile,
      status: status ?? this.status,
      errorMessage: errorMessage ?? this.errorMessage,
    );
  }
}
