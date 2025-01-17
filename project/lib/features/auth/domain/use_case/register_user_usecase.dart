import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';

import '../../../../app/usecase/usecase.dart';
import '../../../../core/error/failure.dart';
import '../../../teams/domain/entity/teams_entity.dart';
import '../entity/auth_entity.dart';
import '../repository/auth_repository.dart';

class RegisterUserParams extends Equatable {
  final String fname;
  final String lname;
  final String phone;
  final TeamsEntity teams;
  final String username;
  final String password;

  const RegisterUserParams({
    required this.fname,
    required this.lname,
    required this.phone,
    required this.teams,
    required this.username,
    required this.password,
  });

  // Initial constructor
  const RegisterUserParams.initial({
    required this.fname,
    required this.lname,
    required this.phone,
    required this.teams,
    required this.username,
    required this.password,
  });

  @override
  List<Object?> get props => [fname, lname, phone, teams, username, password];
}

class RegisterUseCase implements UsecaseWithParams<void, RegisterUserParams> {
  final IAuthRepository repository;

  RegisterUseCase(this.repository);

  @override
  Future<Either<Failure, void>> call(RegisterUserParams params) {
    final authEntity = AuthEntity(
      fName: params.fname,
      lName: params.lname,
      phone: params.phone,
      teams: params.teams,
      username: params.username,
      password: params.password,
    );
    return repository.registerUser(authEntity);
  }
}
