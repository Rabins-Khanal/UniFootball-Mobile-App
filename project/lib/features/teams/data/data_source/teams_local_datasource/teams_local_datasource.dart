import '../../../../../core/network/hive_service.dart';
import '../../../domain/entity/teams_entity.dart';
import '../../model/teams_hive_model.dart';
import '../teams_data_source.dart';

class TeamsLocalDataSource implements ITeamsDataSource {
  final HiveService hiveService;

  TeamsLocalDataSource({required this.hiveService});

  @override
  Future<void> createTeams(TeamsEntity teams) async {
    try {
      // Convert BatchEntity to BatchHiveModel
      final teamsHiveModel = TeamsHiveModel.fromEntity(teams);
      await hiveService.addTeams(teamsHiveModel);
    } catch (e) {
      throw Exception(e);
    }
  }

  @override
  Future<void> deleteTeams(String id) async {
    try {
      await hiveService.deleteTeams(id);
    } catch (e) {
      throw Exception(e);
    }
  }

  @override
  Future<List<TeamsEntity>> getTeams() {
    try {
      return hiveService.getAllTeams().then(
        (value) {
          return value.map((e) => e.toEntity()).toList();
        },
      );
    } catch (e) {
      throw Exception(e);
    }
  }
}
