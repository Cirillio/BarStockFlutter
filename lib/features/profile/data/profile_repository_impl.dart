import 'package:bar_stock/core/utils/result.dart';
import 'package:bar_stock/features/profile/data/profile_data_source.dart';
import 'package:bar_stock/features/profile/domain/entities/profile.dart';
import 'package:bar_stock/features/profile/domain/repos/profile_repository.dart';

import 'package:bar_stock/core/utils/logger.dart';

class ProfileRepositoryImpl implements ProfileRepository {
  final ProfileDataSource ds;
  ProfileRepositoryImpl(this.ds);

  @override
  Future<Result<Profile>> getCurrentUser() async {
    try {
      log.i('ProfileRepositoryImpl | Getting current user profile');
      final res = await ds.getCurrentAuthEmployer();

      if (res != null) {
        log.i('ProfileRepositoryImpl | Got profile: $res');
        return Success(Profile.fromJson(res));
      } else {
        log.i('ProfileRepositoryImpl | No current user profile found');
        return const Failure('No current user profile found');
      }
    } catch (e) {
      log.e('ProfileRepositoryImpl | Error getting current user profile: $e');
      return const Failure('Error getting current user profile');
    }
  }
}
