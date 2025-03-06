import 'package:equatable/equatable.dart';
import 'package:uni_football_app/features/fixtures/domain/entity/fixture_entity.dart';

abstract class FixturesState extends Equatable {
  const FixturesState();
  @override
  List<Object> get props => [];
}

class FixturesInitial extends FixturesState {}

class FixturesLoading extends FixturesState {}

class FixturesLoaded extends FixturesState {
  final List<FixtureEntity> fixturesList;
  const FixturesLoaded(this.fixturesList);
  @override
  List<Object> get props => [fixturesList];
}

class FixturesError extends FixturesState {
  final String message;
  const FixturesError(this.message);
  @override
  List<Object> get props => [message];
}
