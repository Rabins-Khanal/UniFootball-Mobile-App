import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:uni_football_app/features/fixtures/domain/usecase/fixture_usecase.dart';

import 'fixtures_event.dart';
import 'fixtures_state.dart';

class FixturesBloc extends Bloc<FixturesEvent, FixturesState> {
  final GetFixturesUseCase getFixtures;

  FixturesBloc({required this.getFixtures}) : super(FixturesInitial()) {
    on<FetchFixtures>(onFetchFixtures);
  }

  Future<void> onFetchFixtures(
      FetchFixtures event, Emitter<FixturesState> emit) async {
    emit(FixturesLoading());
    final result = await getFixtures();
    result.fold(
      (failure) => emit((failure.message)),
      (fixturesList) => emit(FixturesLoaded(fixturesList)),
    );
  }
}
