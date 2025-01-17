import 'package:dartz/dartz.dart';

import '../../../../app/usecase/usecase.dart';
import '../../../../core/error/failure.dart';
import '../entity/teams_entity.dart';
import '../repository/teams_repository.dart';

class GetAllTeamsUseCase implements UsecaseWithoutParams<List<TeamsEntity>> {
  final ITeamsRepository repository;

  GetAllTeamsUseCase({required this.repository});

  @override
  Future<Either<Failure, List<TeamsEntity>>> call() async {
    return await repository.getTeams();
  }
}
