import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';

import '../../../../app/usecase/usecase.dart';
import '../../../../core/error/failure.dart';
import '../entity/auth_entity.dart';
import '../repository/auth_repository.dart';

class RegisterUserParams extends Equatable {
  final String fullname;
  final String email;
  final String username;
  final String password;
  final String? image;

  const RegisterUserParams({
    required this.fullname,
    required this.email,
    required this.username,
    required this.password,
    this.image,
  });

  const RegisterUserParams.initial({
    required this.fullname,
    required this.email,
    required this.username,
    required this.password,
    this.image,
  });

  @override
  List<Object?> get props => [fullname, email, username, password];
}

class RegisterUseCase implements UsecaseWithParams<void, RegisterUserParams> {
  final IAuthRepository repository;

  RegisterUseCase(this.repository);

  @override
  Future<Either<Failure, void>> call(RegisterUserParams params) {
    final authEntity = AuthEntity(
      fullName: params.fullname,
      email: params.email,
      username: params.username,
      password: params.password,
      image: params.image,
    );
    return repository.registerUser(authEntity);
  }
}
