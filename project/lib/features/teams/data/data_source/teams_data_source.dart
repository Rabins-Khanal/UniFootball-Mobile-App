import '../../domain/entity/teams_entity.dart';

abstract interface class ITeamsDataSource {
  Future<List<TeamsEntity>> getTeams();
  Future<void> createTeams(TeamsEntity teams);
  Future<void> deleteTeams(String id);
}
