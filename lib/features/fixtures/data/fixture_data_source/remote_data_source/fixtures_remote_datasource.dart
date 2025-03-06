import 'package:uni_football_app/features/fixtures/data/model/fixtures_model.dart';

abstract class FixturesRemoteDataSource {
  Future<List<FixtureModel>> fetchFixtures();
}

class FixturesRemoteDataSourceImpl implements FixturesRemoteDataSource {
  @override
  Future<List<FixtureModel>> fetchFixtures() async {
    // Simulating API response (Replace this with actual API call)
    await Future.delayed(
        const Duration(seconds: 1)); // Simulating network delay
    return [
      FixtureModel(
        team1: "Team A",
        team2: "Team B",
        team1Logo: "https://link_to_team_a_logo",
        team2Logo: "https://link_to_team_b_logo",
        venue: "Stadium A",
        date: DateTime(2025, 5, 20, 18, 30),
      ),
      // Add more fixtures here
    ];
  }
}
