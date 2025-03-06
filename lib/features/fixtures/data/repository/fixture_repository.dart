import 'package:dartz/dartz.dart';
import 'package:uni_football_app/core/error/failure.dart';
import 'package:uni_football_app/features/fixtures/data/fixture_data_source/local_data_source/fixtures_local_datasource.dart';
import 'package:uni_football_app/features/fixtures/data/fixture_data_source/remote_data_source/fixtures_remote_datasource.dart';
import 'package:uni_football_app/features/fixtures/domain/entity/fixture_entity.dart';
import 'package:uni_football_app/features/fixtures/domain/repository/fixtures_repository.dart';

class FixturesRepositoryImpl implements FixturesRepository {
  final FixturesRemoteDataSource remoteDataSource;
  final FixturesLocalDataSource localDataSource;

  FixturesRepositoryImpl({
    required this.remoteDataSource,
    required this.localDataSource,
  });

  @override
  Future<Either<Failure, List<FixtureEntity>>> getFixtures() async {
    try {
      final fixtures = await remoteDataSource.fetchFixtures();
      await localDataSource.cacheFixtures(fixtures);
      return Right(fixtures);
    } catch (e) {
      final cachedFixtures = await localDataSource.getCachedFixtures();
      if (cachedFixtures.isNotEmpty) {
        return Right(cachedFixtures);
      }
      return Left(Failure(message: "error"));
    }
  }
}
