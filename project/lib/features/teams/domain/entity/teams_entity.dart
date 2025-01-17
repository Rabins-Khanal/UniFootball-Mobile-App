import 'package:equatable/equatable.dart';

class TeamsEntity extends Equatable {
  final String? teamsId;
  final String teamsName;

  const TeamsEntity({
    this.teamsId,
    required this.teamsName,
  });

  @override
  List<Object?> get props => [teamsId, teamsName];
}
