import 'package:dartz/dartz.dart';
import 'package:uni_football_app/features/fixtures/data/fixture_data_source/remote_data_source/fixtures_remote_datasource.dart';
import 'package:uni_football_app/features/fixtures/data/repository/fixture_repository.dart';
import 'package:uni_football_app/features/fixtures/domain/entity/fixture_entity.dart';

import '../../../../core/error/failure.dart';

class FixtureRemoteRepository implements FixturesRepositoryImpl {
  final FixturesRemoteDataSourceImpl _fixturesRemoteDataSource;

  FixtureRemoteRepository(this._fixturesRemoteDataSource);

  @override
  Future<Either<Failure, List<FixtureEntity>>> getFixtures() async {
    try {
      final remoteFixtures = await _fixturesRemoteDataSource.getFixtures();
      return Right(remoteFixtures);
    } catch (e) {
      return Left(LocalDatabaseFailure(
          message: "Error fetching remote news overview: $e"));
    }
  }

  @override
  Future<Either<Failure, FixtureEntity>> getFixtureDetails(
      String newsId) async {
    try {
      final remoteNews = await _fixturesRemoteDataSource.getFixtureDetails();
      return Right(remoteNews);
    } catch (e) {
      return Left(LocalDatabaseFailure(
          message: "Error fetching remote news details: $e"));
    }
  }
}
