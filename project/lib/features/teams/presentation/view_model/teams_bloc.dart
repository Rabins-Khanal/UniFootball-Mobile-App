import 'package:bloc/bloc.dart';

import '../../domain/use_case/create_teams_usecase.dart';
import '../../domain/use_case/delete_teams_usecase.dart';
import '../../domain/use_case/get_all_teams_usecase.dart';
import 'teams_event.dart';
import 'teams_state.dart';

class TeamsBloc extends Bloc<TeamsEvent, TeamsState> {
  final CreateTeamsUseCase _createTeamsUseCase;
  final GetAllTeamsUseCase _getAllTeamsUseCase;
  final DeleteTeamsUsecase _deleteTeamsUsecase;

  TeamsBloc({
    required CreateTeamsUseCase createTeamsUseCase,
    required GetAllTeamsUseCase getAllTeamsUseCase,
    required DeleteTeamsUsecase deleteTeamsUsecase,
  })  : _createTeamsUseCase = createTeamsUseCase,
        _getAllTeamsUseCase = getAllTeamsUseCase,
        _deleteTeamsUsecase = deleteTeamsUsecase,
        super(TeamsState.initial()) {
    on<LoadTeams>(_onLoadTeams);
    on<AddTeams>(_onAddTeams);
    on<DeleteTeams>(_onDeleteTeams);

    // Call this event whenever the bloc is created to load the batches
    add(LoadTeams());
  }

  Future<void> _onLoadTeams(LoadTeams event, Emitter<TeamsState> emit) async {
    emit(state.copyWith(isLoading: true));
    final result = await _getAllTeamsUseCase.call();
    result.fold(
      (failure) =>
          emit(state.copyWith(isLoading: false, error: failure.message)),
      (teams) => emit(state.copyWith(isLoading: false, teams: teams)),
    );
  }

  Future<void> _onAddTeams(AddTeams event, Emitter<TeamsState> emit) async {
    emit(state.copyWith(isLoading: true));
    final result = await _createTeamsUseCase
        .call(CreateTeamsParams(teamsName: event.teamsName));
    result.fold(
      (failure) =>
          emit(state.copyWith(isLoading: false, error: failure.message)),
      (teams) {
        emit(state.copyWith(isLoading: false, error: null));

        add(LoadTeams());
      },
    );
  }

  Future<void> _onDeleteTeams(
      DeleteTeams event, Emitter<TeamsState> emit) async {
    emit(state.copyWith(isLoading: true));
    final result = await _deleteTeamsUsecase
        .call(DeleteTeamsParams(teamsId: event.teamsId));
    result.fold(
      (failure) =>
          emit(state.copyWith(isLoading: false, error: failure.message)),
      (teams) {
        emit(state.copyWith(isLoading: false, error: null));
        add(LoadTeams());
      },
    );
  }
}
