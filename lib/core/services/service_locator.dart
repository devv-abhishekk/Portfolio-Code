import 'package:get_it/get_it.dart';
import '../../data/datasource/portfolio_datasource.dart';
import '../../data/datasource/portfolio_datasource_impl.dart';
import '../../data/repositories/portfolio_repository_impl.dart';
import '../../domain/repositories/portfolio_repository.dart';
import '../../domain/usecases/get_portfolio_data.dart';
import '../../presentation/cubit/portfolio_cubit.dart';
import '../../presentation/cubit/theme_cubit.dart';

final sl = GetIt.instance;

Future<void> init() async {
  // Cubits
  sl.registerFactory(() => ThemeCubit());
  sl.registerFactory(() => PortfolioCubit(sl()));

  // Use cases
  sl.registerLazySingleton(() => GetPortfolioData(sl()));

  // Repository
  sl.registerLazySingleton<PortfolioRepository>(
    () => PortfolioRepositoryImpl(sl()),
  );

  // Data sources
  sl.registerLazySingleton<PortfolioDataSource>(
    () => PortfolioDataSourceImpl(),
  );
}
