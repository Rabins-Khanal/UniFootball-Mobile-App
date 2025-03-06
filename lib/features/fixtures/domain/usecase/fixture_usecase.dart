import 'package:dartz/dartz.dart';
import 'package:uni_football_app/core/error/failure.dart';
import 'package:uni_football_app/features/fixtures/domain/entity/fixture_entity.dart';
import 'package:uni_football_app/features/fixtures/domain/repository/fixtures_repository.dart';

class GetFixturesUseCase {
  final FixturesRepository repository;

  GetFixturesUseCase(this.repository);

  Future<Either<Failure, List<FixtureEntity>>> call() async {
    return await repository.getFixtures();
  }
}
