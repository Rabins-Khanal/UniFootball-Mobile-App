import 'package:uni_football_app/features/fixtures/data/model/fixtures_model.dart';

abstract class FixturesLocalDataSource {
  Future<List<FixtureModel>> getCachedFixtures();
  Future<void> cacheFixtures(List<FixtureModel> fixtures);
}

class FixturesLocalDataSourceImpl implements FixturesLocalDataSource {
  List<FixtureModel> _cachedFixtures = []; // Simulated local cache (Replace with database storage)

  @override
  Future<List<FixtureModel>> getCachedFixtures() async {
    return _cachedFixtures;
  }

  @override
  Future<void> cacheFixtures(List<FixtureModel> fixtures) async {
    _cachedFixtures = fixtures;
  }
}
