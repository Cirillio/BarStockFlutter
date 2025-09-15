import 'package:bar_stock/features/analytics/data/analytics_data_source.dart';
import 'package:bar_stock/features/analytics/data/analytics_repository_impl.dart';
import 'package:bar_stock/features/analytics/domain/use_cases/get_category_stock_analytics_use_case.dart';
import 'package:bar_stock/features/analytics/presentation/stock_analytics_controller.dart';
import 'package:bar_stock/features/analytics/presentation/stock_analytics_state.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:bar_stock/di/supabase.dart';

final analyticsDataSourceProvider = Provider<AnalyticsRemoteDataSource>(
  (ref) => AnalyticsRemoteDataSourceImpl(
    supabaseClient: ref.read(supabaseClientProvider),
  ),
);

final analyticsRepositoryProvider = Provider<AnalyticsRepositoryImpl>(
  (ref) => AnalyticsRepositoryImpl(
    remoteDataSource: ref.read(analyticsDataSourceProvider),
  ),
);

final getCategoryStockAnalyticsUseCaseProviderr =
    Provider<GetCategoryStockAnalyticsUseCase>(
      (ref) => GetCategoryStockAnalyticsUseCase(
        repository: ref.read(analyticsRepositoryProvider),
      ),
    );

final stockAnalyticsController =
    StateNotifierProvider<StockAnalyticsController, StockAnalyticsState>(
      (ref) => StockAnalyticsController(
        getCategoryStockUseCase: ref.read(
          getCategoryStockAnalyticsUseCaseProviderr,
        ),
      ),
    );
