import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:uni_football_app/features/news/data/data_source/news_remote_datasource/news_remote_datasource.dart';
import 'package:uni_football_app/features/news/data/repository/news_remote_repository.dart';
import 'package:uni_football_app/features/news/domain/usecase/news_usecases.dart';
import 'package:uni_football_app/features/news/presentation/view_model/news_bloc.dart';
import 'package:uni_football_app/features/splash/presentation%20/view_model/splash_cubit.dart';

import '../../core/network/api_service.dart';
import '../../core/network/hive_service.dart';
import '../../features/auth/data/data_source/local_data_source/auth_local_datasource.dart';
import '../../features/auth/data/data_source/remote_data_source/auth_remote_datasource.dart';
import '../../features/auth/data/repository/auth_local_repository/auth_local_repository.dart';
import '../../features/auth/data/repository/auth_remote_repository/auth_remote_repository.dart';
import '../../features/auth/domain/usecase/login_usecase.dart';
import '../../features/auth/domain/usecase/register_user_usecase.dart';
import '../../features/auth/domain/usecase/upload_image_usecase.dart';
import '../../features/auth/presentation/view_model/login/login_bloc.dart';
import '../../features/auth/presentation/view_model/register/register_bloc.dart';
import '../../features/home/presentation/view_model/home_cubit.dart';
import '../shared_preferences/token_shared_preferences.dart';

final getIt = GetIt.instance;

Future<void> initDependencies() async {
  // First initialize hive service
  await _initHiveService();
  await _initHomeDependencies();
  await _initRegisterDependencies();
  await _initLoginDependencies();
  await _initApiService();
  await _initSplashScreenDependencies();
  await _initNewsDependencies(); // Added news dependencies initialization
}

_initApiService() {
  // Remote Data Source
  getIt.registerLazySingleton<Dio>(
    () => ApiService(Dio()).dio,
  );
}

_initHiveService() {
  getIt.registerLazySingleton<HiveService>(() => HiveService());
}

_initRegisterDependencies() {
  // =========================== Data Source ===========================
  getIt.registerLazySingleton<AuthLocalDataSource>(
    () => AuthLocalDataSource(getIt<HiveService>()),
  );

  getIt.registerLazySingleton<AuthRemoteDataSource>(
    () => AuthRemoteDataSource(getIt<Dio>()),
  );

  // =========================== Repository ===========================
  getIt.registerLazySingleton(
    () => AuthLocalRepository(getIt<AuthLocalDataSource>()),
  );
  getIt.registerLazySingleton<AuthRemoteRepository>(
    () => AuthRemoteRepository(getIt<AuthRemoteDataSource>()),
  );

  // =========================== Usecases ===========================
  getIt.registerLazySingleton<RegisterUseCase>(
    () => RegisterUseCase(
      getIt<AuthRemoteRepository>(),
    ),
  );

  getIt.registerLazySingleton<UploadImageUsecase>(
    () => UploadImageUsecase(
      getIt<AuthRemoteRepository>(),
    ),
  );

  getIt.registerFactory<RegisterBloc>(
    () => RegisterBloc(
      registerUseCase: getIt(),
      uploadImageUsecase: getIt(),
    ),
  );
}

_initHomeDependencies() async {
  getIt.registerFactory<HomeCubit>(
    () => HomeCubit(),
  );
}

_initLoginDependencies() async {
  // =========================== Token Shared Preferences ===========================
  getIt.registerLazySingleton<TokenSharedPrefs>(
    () => TokenSharedPrefs(getIt<SharedPreferences>()),
  );

  // =========================== Usecases ===========================
  getIt.registerLazySingleton<LoginUseCase>(
    () => LoginUseCase(
      getIt<AuthRemoteRepository>(),
      // getIt<TokenSharedPrefs>(),
    ),
  );

  getIt.registerFactory<LoginBloc>(
    () => LoginBloc(
      registerBloc: getIt<RegisterBloc>(),
      homeCubit: getIt<HomeCubit>(),
      loginUseCase: getIt<LoginUseCase>(),
    ),
  );
}

_initSplashScreenDependencies() async {
  getIt.registerFactory<SplashCubit>(
    () => SplashCubit(getIt<LoginBloc>()),
  );
}

// =========================== News Dependencies ===========================
_initNewsDependencies() async {
  // Register Data Source
  getIt.registerLazySingleton<NewsRemoteDataSource>(
    () => NewsRemoteDataSource(getIt<Dio>()),
  );

  // Register Repository
  getIt.registerLazySingleton<NewsRemoteRepository>(
    () => NewsRemoteRepository(getIt<NewsRemoteDataSource>()),
  );

  // Register UseCases
  getIt.registerLazySingleton<GetNewsOverviewUseCase>(
    () => GetNewsOverviewUseCase(getIt<NewsRemoteRepository>()),
  );

  getIt.registerLazySingleton<GetNewsDetailsUseCase>(
    () => GetNewsDetailsUseCase(getIt<NewsRemoteRepository>()),
  );

  // Register Bloc
  getIt.registerFactory(() => NewsBloc(
        getNewsOverview: getIt<GetNewsOverviewUseCase>(),
        getNewsDetails: getIt<GetNewsDetailsUseCase>(),
      ));
}
