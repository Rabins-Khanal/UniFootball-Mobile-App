import 'package:dartz/dartz.dart';
import 'package:uni_football_app/core/error/failure.dart';
import 'package:uni_football_app/features/fixtures/domain/entity/fixture_entity.dart';


abstract class FixturesRepository {
  Future<Either<Failure, List<FixtureEntity>>> getFixtures();
}
