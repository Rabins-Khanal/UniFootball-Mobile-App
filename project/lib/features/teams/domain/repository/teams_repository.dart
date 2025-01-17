import 'package:dartz/dartz.dart';

import '../../../../core/error/failure.dart';
import '../entity/teams_entity.dart';

abstract interface class ITeamsRepository {
  Future<Either<Failure, List<TeamsEntity>>> getTeams();
  Future<Either<Failure, void>> createTeams(TeamsEntity teams);
  Future<Either<Failure, void>> deleteTeams(String id);
}
