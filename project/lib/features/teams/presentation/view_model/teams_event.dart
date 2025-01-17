import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

@immutable
sealed class TeamsEvent extends Equatable {
  const TeamsEvent();

  @override
  List<Object> get props => [];
}

final class LoadTeams extends TeamsEvent {}

final class AddTeams extends TeamsEvent {
  final String teamsName;
  const AddTeams(this.teamsName);

  @override
  List<Object> get props => [teamsName];
}

final class DeleteTeams extends TeamsEvent {
  final String teamsId;

  const DeleteTeams(this.teamsId);

  @override
  List<Object> get props => [teamsId];
}
