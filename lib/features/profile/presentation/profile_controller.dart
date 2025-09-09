import 'package:bar_stock/core/constants/state_status.dart';
import 'package:bar_stock/core/utils/logger.dart';
import 'package:bar_stock/core/utils/result.dart';
import 'package:bar_stock/features/profile/domain/use_cases/get_profile_use_case.dart';
import 'package:bar_stock/features/profile/presentation/profile_state.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class ProfileController extends StateNotifier<ProfileState> {
  final GetProfileUseCase getProfileUseCase;

  ProfileController({required this.getProfileUseCase}) : super(ProfileState());

  Future<void> getProfile() async {
    log.i("ProfileController | Getting profile");
    state = state.copyWith(status: StateStatus.submitting);
    final profile = await getProfileUseCase();

    switch (profile) {
      case Success():
        state = state.copyWith(
          profile: profile.data,
          status: StateStatus.success,
        );
      case Failure(:final message):
        state = state.copyWith(
          status: StateStatus.failure,
          errorMessage: message,
        );
        log.e("ProfileController | Error: $message");
        break;
    }
  }

  void clearProfile() {
    log.i("ProfileController | Clearing profile");
    state = ProfileState();
  }
}
