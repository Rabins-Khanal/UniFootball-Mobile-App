import 'package:equatable/equatable.dart';

import '../../domain/entity/teams_entity.dart';

class TeamsState extends Equatable {
  final List<TeamsEntity> teams;
  final bool isLoading;
  final String? error;

  const TeamsState({
    required this.teams,
    required this.isLoading,
    this.error,
  });

  factory TeamsState.initial() {
    return TeamsState(
      teams: [],
      isLoading: false,
    );
  }

  TeamsState copyWith({
    List<TeamsEntity>? teams,
    bool? isLoading,
    String? error,
  }) {
    return TeamsState(
      teams: teams ?? this.teams,
      isLoading: isLoading ?? this.isLoading,
      error: error,
    );
  }

  @override
  List<Object?> get props => [teams, isLoading, error];
}
