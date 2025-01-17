import 'package:get_it/get_it.dart';
import 'package:unifootball_app/core/network/hive_service.dart';

import '../../features/auth/data/data_source/auth_local_data_souce/auth_local_data_source.dart';
import '../../features/auth/data/repository/auth_local_repository/auth_local_repository.dart';
import '../../features/auth/domain/use_case/login_usecase.dart';
import '../../features/auth/domain/use_case/register_user_usecase.dart';
import '../../features/auth/presentation/view_model/login/login_bloc.dart';
import '../../features/auth/presentation/view_model/signup/register_bloc.dart';
import '../../features/home/presentation/view_model/home_cubit.dart';
import '../../features/splash/presentation/view_model/splash_cubit.dart';
import '../../features/teams/data/data_source/teams_local_datasource/teams_local_datasource.dart';
import '../../features/teams/data/repository/teams_local_repository/teams_local_repository.dart';
import '../../features/teams/domain/use_case/create_teams_usecase.dart';
import '../../features/teams/domain/use_case/delete_teams_usecase.dart';
import '../../features/teams/domain/use_case/get_all_teams_usecase.dart';
import '../../features/teams/presentation/view_model/teams_bloc.dart';

final getIt = GetIt.instance;

Future<void> initDependencies() async {
  // First initialize hive service
  await _initHiveService();

  await _initTeamsDependencies();
  await _initHomeDependencies();
  await _initRegisterDependencies();
  await _initLoginDependencies();

  await _initSplashScreenDependencies();
}

_initHiveService() {
  getIt.registerLazySingleton<HiveService>(() => HiveService());
}

_initRegisterDependencies() {
  // init local data source
  getIt.registerLazySingleton(
    () => AuthLocalDataSource(getIt<HiveService>()),
  );

  // init local repository
  getIt.registerLazySingleton(
    () => AuthLocalRepository(getIt<AuthLocalDataSource>()),
  );

  // register use usecase
  getIt.registerLazySingleton<RegisterUseCase>(
    () => RegisterUseCase(
      getIt<AuthLocalRepository>(),
    ),
  );

  getIt.registerFactory<RegisterBloc>(
    () => RegisterBloc(
      teamsBloc: getIt<TeamsBloc>(),
      registerUseCase: getIt(),
    ),
  );
}

_initTeamsDependencies() async {
  // Data Source
  getIt.registerFactory<TeamsLocalDataSource>(
      () => TeamsLocalDataSource(hiveService: getIt<HiveService>()));

  // Repository
  getIt.registerLazySingleton<TeamsLocalRepository>(() => TeamsLocalRepository(
      teamsLocalDataSource: getIt<TeamsLocalDataSource>()));

  // Usecases
  getIt.registerLazySingleton<CreateTeamsUseCase>(
    () => CreateTeamsUseCase(teamsRepository: getIt<TeamsLocalRepository>()),
  );

  getIt.registerLazySingleton<GetAllTeamsUseCase>(
    () => GetAllTeamsUseCase(repository: getIt<TeamsLocalRepository>()),
  );

  getIt.registerLazySingleton<DeleteTeamsUsecase>(
    () => DeleteTeamsUsecase(teamsRepository: getIt<TeamsLocalRepository>()),
  );

  // Bloc
  getIt.registerFactory<TeamsBloc>(
    () => TeamsBloc(
      createTeamsUseCase: getIt<CreateTeamsUseCase>(),
      getAllTeamsUseCase: getIt<GetAllTeamsUseCase>(),
      deleteTeamsUsecase: getIt<DeleteTeamsUsecase>(),
    ),
  );
}

_initHomeDependencies() async {
  getIt.registerFactory<HomeCubit>(
    () => HomeCubit(),
  );
}

_initLoginDependencies() async {
  getIt.registerLazySingleton<LoginUseCase>(
    () => LoginUseCase(
      getIt<AuthLocalRepository>(),
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
