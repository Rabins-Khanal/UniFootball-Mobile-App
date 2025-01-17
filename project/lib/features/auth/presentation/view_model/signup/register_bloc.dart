import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

import '../../../../../core/common/snackbar/my_snackbar.dart';
import '../../../../teams/domain/entity/teams_entity.dart';
import '../../../../teams/presentation/view_model/teams_bloc.dart';
import '../../../domain/use_case/register_user_usecase.dart';

part 'register_event.dart';
part 'register_state.dart';

class RegisterBloc extends Bloc<RegisterEvent, RegisterState> {
  final TeamsBloc _teamsBloc;
  final RegisterUseCase _registerUseCase;

  RegisterBloc({
    required TeamsBloc teamsBloc,
    required RegisterUseCase registerUseCase,
  })  : _teamsBloc = teamsBloc,
        _registerUseCase = registerUseCase,
        super(RegisterState.initial()) {
    on<LoadTeams>(_onLoadTeams);
    on<RegisterUser>(_onRegisterEvent);
  }

  void _onLoadTeams(
    LoadTeams event,
    Emitter<RegisterState> emit,
  ) {
    emit(state.copyWith(isLoading: true));
    emit(state.copyWith(isLoading: false, isSuccess: true));
  }

  void _onRegisterEvent(
    RegisterUser event,
    Emitter<RegisterState> emit,
  ) async {
    emit(state.copyWith(isLoading: true));
    final result = await _registerUseCase.call(RegisterUserParams(
      fname: event.fName,
      lname: event.lName,
      phone: event.phone,
      teams: event.teams,
      username: event.username,
      password: event.password,
    ));

    result.fold(
      (l) => emit(state.copyWith(isLoading: false, isSuccess: false)),
      (r) {
        emit(state.copyWith(isLoading: false, isSuccess: true));
        showMySnackBar(
            context: event.context, message: "Registration Successful");
      },
    );
  }
}
