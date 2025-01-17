import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';

import '../../../../app/usecase/usecase.dart';
import '../../../../core/error/failure.dart';
import '../repository/teams_repository.dart';

class DeleteTeamsParams extends Equatable {
  final String teamsId;

  const DeleteTeamsParams({required this.teamsId});

  const DeleteTeamsParams.empty() : teamsId = '_empty.string';

  @override
  List<Object?> get props => [
        teamsId,
      ];
}

class DeleteTeamsUsecase implements UsecaseWithParams<void, DeleteTeamsParams> {
  final ITeamsRepository teamsRepository;

  DeleteTeamsUsecase({required this.teamsRepository});

  @override
  Future<Either<Failure, void>> call(DeleteTeamsParams params) async {
    return await teamsRepository.deleteTeams(params.teamsId);
  }
}
