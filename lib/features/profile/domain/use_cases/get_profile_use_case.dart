import 'package:bar_stock/core/utils/result.dart';
import 'package:bar_stock/features/profile/domain/entities/profile.dart';
import 'package:bar_stock/features/profile/domain/repos/profile_repository.dart';

class GetProfileUseCase {
  ProfileRepository profileRepository;

  GetProfileUseCase(this.profileRepository);

  Future<Result<Profile>> call() async {
    try {
      return await profileRepository.getCurrentUser();
    } catch (e) {
      return Failure('Failed to get profile: $e');
    }
  }
}
