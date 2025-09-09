import 'package:bar_stock/core/utils/result.dart';
import 'package:bar_stock/features/profile/domain/entities/profile.dart';

abstract class ProfileRepository {
  Future<Result<Profile>> getCurrentUser();
}
