part of 'register_bloc.dart';

sealed class RegisterEvent extends Equatable {
  const RegisterEvent();

  @override
  List<Object> get props => [];
}

class LoadTeams extends RegisterEvent {}

class RegisterUser extends RegisterEvent {
  final BuildContext context;
  final String fName;
  final String lName;
  final String phone;
  final TeamsEntity teams;
  final String username;
  final String password;

  const RegisterUser({
    required this.context,
    required this.fName,
    required this.lName,
    required this.phone,
    required this.teams,
    required this.username,
    required this.password,
  });
}
