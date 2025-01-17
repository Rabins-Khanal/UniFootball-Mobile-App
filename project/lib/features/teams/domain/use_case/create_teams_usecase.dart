import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';

import '../../../../app/usecase/usecase.dart';
import '../../../../core/error/failure.dart';
import '../entity/teams_entity.dart';
import '../repository/teams_repository.dart';

class CreateTeamsParams extends Equatable {
  final String teamsName;

  const CreateTeamsParams({required this.teamsName});

  // Empty constructor
  const CreateTeamsParams.empty() : teamsName = '_empty.string';

  @override
  List<Object?> get props => [teamsName];
}

class CreateTeamsUseCase implements UsecaseWithParams<void, CreateTeamsParams> {
  final ITeamsRepository teamsRepository;

  CreateTeamsUseCase({required this.teamsRepository});

  @override
  Future<Either<Failure, void>> call(CreateTeamsParams params) async {
    return await teamsRepository.createTeams(
      TeamsEntity(
        teamsName: params.teamsName,
      ),
    );
  }
}
