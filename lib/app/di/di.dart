import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:uni_football_app/features/comments/data/comment_data_source/comments_remote_data_source.dart';
import 'package:uni_football_app/features/comments/data/repository/repository.dart';
import 'package:uni_football_app/features/comments/domain/usecase/cmments_usecases.dart';
import 'package:uni_football_app/features/fixtures/data/fixture_data_source/remote_data_source/fixtures_remote_datasource.dart';
import 'package:uni_football_app/features/fixtures/data/repository/fixture_repository.dart';
import 'package:uni_football_app/features/fixtures/domain/usecase/fixture_usecase.dart';
import 'package:uni_football_app/features/fixtures/presentation/view_model/fixtures_bloc.dart';
import 'package:uni_football_app/features/comments/presentation/view_model/comments_bloc.dart';

import '../../core/network/api_service.dart';
import '../../core/network/hive_service.dart';
import '../shared_preferences/token_shared_preferences.dart';

final getIt = GetIt.instance;

Future<void> initDependencies() async {
  await _initHiveService();
  await _initApiService();
  await _initFixturesDependencies();
  await _initCommentsDependencies();
}

_initApiService() {
  getIt.registerLazySingleton<Dio>(
    () => ApiService(Dio()).dio,
  );
}

_initHiveService() {
  getIt.registerLazySingleton<HiveService>(() => HiveService());
}

// =========================== Fixtures Dependencies ===========================
_initFixturesDependencies() async {
  // Register Data Source
  getIt.registerLazySingleton<FixturesRemoteDataSource>(
    () => FixturesRemoteDataSourceImpl(),
  );

  // Register Repository
  getIt.registerLazySingleton<FixturesRepositoryImpl>(
    () => FixturesRepositoryImpl(getIt<FixturesRemoteDataSource>()),
  );

  // Register UseCases
  getIt.registerLazySingleton<GetFixturesUseCase>(
    () => GetFixturesUseCase(getIt<FixturesRepositoryImpl>()),
  );

  // Register Bloc
  getIt.registerFactory(() => FixturesBloc(
        getFixtures: getIt<GetFixturesUseCase>(),
      ));
}

// =========================== Comments Dependencies ===========================
_initCommentsDependencies() async {
  // Register Data Source
  getIt.registerLazySingleton<CommentsRemoteDataSource>(
    () => CommentsRemoteDataSourceImpl(),
  );

  // Register Repository
  getIt.registerLazySingleton<CommentsRepositoryImpl>(
    () => CommentsRepositoryImpl(getIt<CommentsRemoteDataSource>()),
  );

  // Register UseCases
  getIt.registerLazySingleton<GetCommentsUseCase>(
    () => GetCommentsUseCase(getIt<CommentsRepositoryImpl>()),
  );

  getIt.registerLazySingleton<AddCommentUseCase>(
    () => AddCommentUseCase(getIt<CommentsRepositoryImpl>()),
  );

  // Register Bloc
  getIt.registerFactory(() => CommentsBloc(
        getComments: getIt<GetCommentsUseCase>(),
        addComment: getIt<AddCommentUseCase>(),
      ));
}
