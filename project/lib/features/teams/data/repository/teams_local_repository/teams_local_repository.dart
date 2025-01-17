import 'package:dartz/dartz.dart';

import '../../../../../core/error/failure.dart';
import '../../../domain/entity/teams_entity.dart';
import '../../../domain/repository/teams_repository.dart';
import '../../data_source/teams_local_datasource/teams_local_datasource.dart';

class TeamsLocalRepository implements ITeamsRepository {
  final TeamsLocalDataSource _teamsLocalDataSource;

  TeamsLocalRepository({required TeamsLocalDataSource teamsLocalDataSource})
      : _teamsLocalDataSource = teamsLocalDataSource;

  @override
  Future<Either<Failure, void>> createTeams(TeamsEntity teams) {
    try {
      _teamsLocalDataSource.createTeams(teams);
      return Future.value(Right(null));
    } catch (e) {
      return Future.value(Left(LocalDatabaseFailure(message: e.toString())));
    }
  }

  @override
  Future<Either<Failure, void>> deleteTeams(String id) {
    try {
      _teamsLocalDataSource.deleteTeams(id);
      return Future.value(Right(null));
    } catch (e) {
      return Future.value(Left(LocalDatabaseFailure(message: e.toString())));
    }
  }

  @override
  Future<Either<Failure, List<TeamsEntity>>> getTeams() {
    try {
      return _teamsLocalDataSource.getTeams().then(
        (value) {
          return Right(value);
        },
      );
    } catch (e) {
      return Future.value(Left(LocalDatabaseFailure(message: e.toString())));
    }
  }
}
