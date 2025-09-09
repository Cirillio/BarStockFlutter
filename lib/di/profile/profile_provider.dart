import 'package:bar_stock/di/supabase.dart';
import 'package:bar_stock/features/profile/data/profile_data_source.dart';
import 'package:bar_stock/features/profile/data/profile_repository_impl.dart';
import 'package:bar_stock/features/profile/domain/use_cases/get_profile_use_case.dart';
import 'package:bar_stock/features/profile/presentation/profile_controller.dart';
import 'package:bar_stock/features/profile/presentation/profile_state.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

// DATA LAYER
final profileDataSourceProvider = Provider<ProfileDataSource>(
  (ref) => ProfileDataSource(ref.read(supabaseClientProvider)),
);

final profileRepositoryProvider = Provider<ProfileRepositoryImpl>(
  (ref) => ProfileRepositoryImpl(ref.read(profileDataSourceProvider)),
);

// DOMAIN LAYER
final getProfileUseCaseProvider = Provider<GetProfileUseCase>(
  (ref) => GetProfileUseCase(ref.read(profileRepositoryProvider)),
);

// PRESENTATION LAYER
final profileControllerProvider =
    StateNotifierProvider<ProfileController, ProfileState>(
      (ref) => ProfileController(
        getProfileUseCase: ref.read(getProfileUseCaseProvider),
      ),
    );
